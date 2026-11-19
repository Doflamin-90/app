import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/artwork.dart';
import 'layer_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Artwork> _artworks = [];

  @override
  void initState() {
    super.initState();
    _loadArtworks();
  }

  Future<void> _loadArtworks() async {
    try {
      final data = await DatabaseHelper.instance.getArtworks();
      if (!mounted) return;
      setState(() {
        _artworks = data.isNotEmpty
            ? data
            : [
                Artwork(id: 1, title: '캐릭터 러프 & 선화 복기', createdAt: '2026-11-16'),
                Artwork(id: 2, title: '명암 레이어 연습작', createdAt: '2026-11-15'),
              ];
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _artworks = [
          Artwork(id: 1, title: '캐릭터 러프 & 선화 복기', createdAt: '2026-11-16'),
        ];
      });
    }
  }

  void _showAddArtworkDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2B2B2B),
          title: const Text('새 캔버스 만들기', style: TextStyle(color: Colors.white, fontSize: 16)),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: '작품 제목 입력 (예: 상반신 구도 연습)',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF2196F3))),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('취소', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2196F3)),
              onPressed: () async {
                final text = controller.text.trim();
                if (text.isNotEmpty) {
                  final newArt = Artwork(
                    title: text,
                    createdAt: DateTime.now().toString().split(' ')[0],
                  );
                  int insertedId = _artworks.length + 1;
                  try {
                    insertedId = await DatabaseHelper.instance.insertArtwork(newArt);
                  } catch (_) {}
                  if (!mounted) return;
                  Navigator.pop(dialogContext);
                  _loadArtworks();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LayerDetailScreen(
                        artworkId: insertedId,
                        artworkTitle: text,
                      ),
                    ),
                  );
                }
              },
              child: const Text('시작하기', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showQuickTourModal() {
    int pageIndex = 0;
    final icons = [Icons.brush, Icons.layers, Icons.help_outline];
    final titles = [
      '브러시 & 지우개 툴',
      '단계별 레이어 분리 복기',
      '실시간 조작 가이드 (?)',
    ];
    final descs = [
      '브러시 툴로 수정할 포인트를 직접 표시하고,\n지우개 툴로 불필요한 선을 깔끔하게 지울 수 있습니다.',
      '스케치 · 선화 · 채색 탭을 오가며\n각 작업 단계에서 수정해야 할 부분을 따로 기록합니다.',
      '작업 중 도구 사용법이 헷갈릴 때는\n하단 ? 버튼을 눌러 핵심 툴 설명을 바로 확인하세요.',
    ];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF3A3A3A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              content: SizedBox(
                width: 280,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icons[pageIndex], size: 54, color: const Color(0xFF2196F3)),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      titles[pageIndex],
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      descs[pageIndex],
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text('SKIP', style: TextStyle(color: Colors.white70)),
                        ),
                        Row(
                          children: [
                            _buildDot(pageIndex == 0),
                            _buildDot(pageIndex == 1),
                            _buildDot(pageIndex == 2),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            if (pageIndex < 2) {
                              setModalState(() => pageIndex++);
                            } else {
                              Navigator.pop(dialogContext);
                            }
                          },
                          child: Text(
                            pageIndex < 2 ? '다음' : '닫기',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.white : Colors.white30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF333333),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Art Revision',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildGridTile(
                    icon: Icons.brush,
                    label: '새로운 캔버스',
                    onTap: _showAddArtworkDialog,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildGridTile(
                    icon: Icons.menu_book_outlined,
                    label: '툴 퀵투어 가이드',
                    onTap: _showQuickTourModal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '이전 편집작품 (단계별 복기 목록)',
              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _artworks.length,
                itemBuilder: (context, index) {
                  final art = _artworks[index];
                  return Card(
                    color: const Color(0xFF1F1F1F),
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.white10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2B2B),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.edit_outlined, color: Colors.white),
                      ),
                      title: Text(
                        art.title,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      subtitle: Text(
                        '최근 작업일: ${art.createdAt}',
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LayerDetailScreen(
                              artworkId: art.id ?? 1,
                              artworkTitle: art.title,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 34),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}