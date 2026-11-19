import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/database_helper.dart';
import '../models/layer_note.dart';
import '../widgets/drawing_canvas.dart';

class LayerDetailScreen extends StatefulWidget {
  final int artworkId;
  final String artworkTitle;

  const LayerDetailScreen({
    Key? key,
    required this.artworkId,
    required this.artworkTitle,
  }) : super(key: key);

  @override
  State<LayerDetailScreen> createState() => _LayerDetailScreenState();
}

class _LayerDetailScreenState extends State<LayerDetailScreen> {
  int _selectedLayerIndex = 0;
  final List<String> _layerTypes = ['1. 스케치', '2. 선화', '3. 채색'];

  final Map<String, List<Stroke>> _layerStrokes = {
    '1. 스케치': [],
    '2. 선화': [],
    '3. 채색': [],
  };
  final Map<String, String> _layerImages = {};
  List<LayerNote> _layerNotes = [];

  Color _selectedColor = Colors.black;
  double _brushSize = 10.0;
  double _opacity = 1.0;
  bool _isEraser = false;
  bool _showCoachMark = false;

  final ImagePicker _picker = ImagePicker();

  final List<Color> _paletteColors = [
    Colors.black,
    Colors.redAccent,
    Colors.blueAccent,
    Colors.green,
    Colors.orange,
    Colors.purpleAccent,
  ];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      final notes = await DatabaseHelper.instance.getLayerNotes(widget.artworkId);
      if (!mounted) return;
      setState(() {
        _layerNotes = notes;
        for (final note in notes) {
          if (note.imagePath.isNotEmpty) {
            _layerImages[note.layerType] = note.imagePath;
          }
        }
      });
    } catch (_) {}
  }

  Future<void> _pickImage() async {
    try {
      final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null && mounted) {
        setState(() {
          _layerImages[_layerTypes[_selectedLayerIndex]] = picked.path;
        });
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('갤러리에서 이미지를 불러오지 못했습니다.')),
      );
    }
  }

  void _undoStroke() {
    final currentStrokes = _layerStrokes[_layerTypes[_selectedLayerIndex]]!;
    if (currentStrokes.isNotEmpty) {
      setState(() {
        currentStrokes.removeLast();
      });
    }
  }

  void _clearCanvas() {
    setState(() {
      _layerStrokes[_layerTypes[_selectedLayerIndex]]!.clear();
    });
  }

  void _openNotesSheet() {
    final currentType = _layerTypes[_selectedLayerIndex];
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF2B2B2B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setSheetState) {
          final currentNotes = _layerNotes.where((n) => n.layerType == currentType).toList();
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SizedBox(
              height: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$currentType 작업 복기 & 성찰 메모',
                        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white54),
                        onPressed: () => Navigator.pop(sheetContext),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                          decoration: const InputDecoration(
                            hintText: '수정 포인트나 팁 기록 (예: 턱선 각도 보정)',
                            hintStyle: TextStyle(color: Colors.white38, fontSize: 12),
                            isDense: true,
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF2196F3))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2196F3)),
                        onPressed: () async {
                          final text = controller.text.trim();
                          if (text.isEmpty) return;
                          final newNote = LayerNote(
                            artworkId: widget.artworkId,
                            layerType: currentType,
                            imagePath: _layerImages[currentType] ?? '',
                            noteText: text,
                            createdAt: DateTime.now().toString().split(' ')[0],
                          );
                          try {
                            await DatabaseHelper.instance.insertLayerNote(newNote);
                          } catch (_) {}
                          controller.clear();
                          await _loadNotes();
                          setSheetState(() {});
                        },
                        child: const Text('기록', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: currentNotes.isEmpty
                        ? const Center(
                            child: Text(
                              '아직 기록된 메모가 없습니다.\n위 입력창에 수정 의도를 남겨보세요.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white38, fontSize: 12),
                            ),
                          )
                        : ListView.builder(
                            itemCount: currentNotes.length,
                            itemBuilder: (_, idx) {
                              final item = currentNotes[idx];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1F1F1F),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '• ${item.noteText}',
                                  style: const TextStyle(color: Colors.white, fontSize: 13),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentType = _layerTypes[_selectedLayerIndex];
    final currentStrokes = _layerStrokes[currentType]!;
    final currentImagePath = _layerImages[currentType];

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D2D2D),
        elevation: 0,
        toolbarHeight: 44,
        title: Text(
          widget.artworkTitle,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_photo_alternate_outlined, color: Colors.white),
            tooltip: '갤러리 이미지 불러오기',
            onPressed: _pickImage,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white70),
            tooltip: '현재 레이어 선 지우기',
            onPressed: _clearCanvas,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: const Color(0xFF2D2D2D),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    _buildTopToolBtn(
                      icon: Icons.brush,
                      selected: !_isEraser,
                      onTap: () => setState(() => _isEraser = false),
                    ),
                    const SizedBox(width: 4),
                    _buildTopToolBtn(
                      icon: Icons.cleaning_services,
                      selected: _isEraser,
                      onTap: () => setState(() => _isEraser = true),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(_layerTypes.length, (index) {
                        final isSelected = _selectedLayerIndex == index;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedLayerIndex = index),
                          child: Container(
                            margin: const EdgeInsets.only(left: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF2196F3) : const Color(0xFF1F1F1F),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _layerTypes[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.white60,
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      color: const Color(0xFF262626),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          ..._paletteColors.map((color) {
                            final isSelected = !_isEraser && _selectedColor == color;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isEraser = false;
                                  _selectedColor = color;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? Colors.white : Colors.white24,
                                    width: isSelected ? 2.5 : 1,
                                  ),
                                ),
                              ),
                            );
                          }),
                          const Divider(color: Colors.white12, height: 18),
                          Text(
                            '${_brushSize.toInt()} px',
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          Expanded(
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Slider(
                                value: _brushSize,
                                min: 2,
                                max: 30,
                                activeColor: const Color(0xFF2196F3),
                                inactiveColor: Colors.white24,
                                onChanged: (val) => setState(() => _brushSize = val),
                              ),
                            ),
                          ),
                          Text(
                            '${(_opacity * 100).toInt()} %',
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                          Expanded(
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Slider(
                                value: _opacity,
                                min: 0.1,
                                max: 1.0,
                                activeColor: const Color(0xFF2196F3),
                                inactiveColor: Colors.white24,
                                onChanged: (val) => setState(() => _opacity = val),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: const Color(0xFF141414),
                        padding: const EdgeInsets.all(8),
                        child: DrawingCanvas(
                          imagePath: currentImagePath,
                          selectedColor: _selectedColor,
                          brushSize: _brushSize,
                          opacity: _opacity,
                          isEraser: _isEraser,
                          strokes: currentStrokes,
                          onStrokeChanged: () => setState(() {}),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 52,
                color: const Color(0xFF2D2D2D),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.undo, color: Colors.white),
                      tooltip: '실행 취소',
                      onPressed: _undoStroke,
                    ),
                    IconButton(
                      icon: const Icon(Icons.help_outline, color: Colors.white, size: 26),
                      tooltip: '조작 가이드',
                      onPressed: () => setState(() => _showCoachMark = true),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$currentType 레이어 상태가 저장되었습니다.')),
                        );
                      },
                      child: const Text('저장', style: TextStyle(color: Colors.white, fontSize: 13)),
                    ),
                    TextButton.icon(
                      onPressed: _openNotesSheet,
                      icon: const Icon(Icons.edit_note, color: Colors.white),
                      label: Text(
                        '메모 (${_layerNotes.where((n) => n.layerType == currentType).length})',
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_showCoachMark)
            GestureDetector(
              onTap: () => setState(() => _showCoachMark = false),
              child: Container(
                color: const Color(0xCC2C5E8A),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '조작 가이드',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '• 좌측 바에서 브러시 색상, 굵기(px), 불투명도(%)를 조절합니다.\n'
                      '• 상단 탭으로 [스케치 · 선화 · 채색] 단계를 전환해 복기합니다.\n'
                      '• 하단 [메모] 버튼을 누르면 수정 의도를 기록할 수 있습니다.',
                      style: TextStyle(color: Colors.white, fontSize: 14, height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '화면을 터치하면 작업 캔버스로 돌아갑니다.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTopToolBtn({
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF4A4A4A) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}