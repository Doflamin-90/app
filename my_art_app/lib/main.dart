import 'package:flutter/material.dart';

void main() {
  runApp(const ArtTimelineApp());
}

class ArtTimelineApp extends StatelessWidget {
  const ArtTimelineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '아트 타임라인',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const TimelineHomePage(),
    );
  }
}

enum WorkType { all, handDrawn, digital }

class Artwork {
  final String id;
  final String title;
  final WorkType type;
  final DateTime date;

  Artwork({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
  });
}

class TimelineHomePage extends StatefulWidget {
  const TimelineHomePage({super.key});

  @override
  State<TimelineHomePage> createState() => _TimelineHomePageState();
}

class _TimelineHomePageState extends State<TimelineHomePage> {
  WorkType _selectedFilter = WorkType.all;

  final List<Artwork> _artworks = [
    Artwork(
      id: '1',
      title: '첫 번째 수채화 캐릭터',
      type: WorkType.handDrawn,
      date: DateTime(2026, 3, 10),
    ),
    Artwork(
      id: '2',
      title: '디지털 팬아트 레이아웃',
      type: WorkType.digital,
      date: DateTime(2026, 5, 20),
    ),
    Artwork(
      id: '3',
      title: '크로키 및 포즈 연습',
      type: WorkType.handDrawn,
      date: DateTime(2026, 8, 15),
    ),
    Artwork(
      id: '4',
      title: '팀프로젝트 캐릭터 시안',
      type: WorkType.digital,
      date: DateTime(2026, 10, 1),
    ),
  ];

  List<Artwork> get _filteredArtworks {
    if (_selectedFilter == WorkType.all) return _artworks;
    return _artworks.where((art) => art.type == _selectedFilter).toList();
  }

  int get _handDrawnCount =>
      _artworks.where((art) => art.type == WorkType.handDrawn).length;
  int get _digitalCount =>
      _artworks.where((art) => art.type == WorkType.digital).length;

  void _addNewArtwork(String title, WorkType type) {
    setState(() {
      _artworks.insert(
        0,
        Artwork(
          id: DateTime.now().toString(),
          title: title,
          type: type,
          date: DateTime.now(),
        ),
      );
    });
  }

  void _showAddDialog() {
    final titleController = TextEditingController();
    WorkType selectedType = WorkType.handDrawn;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('새 작품 등록'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: '작품 제목',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SegmentedButton<WorkType>(
                    segments: const [
                      ButtonSegment(
                        value: WorkType.handDrawn,
                        label: Text('손그림'),
                        icon: Icon(Icons.edit),
                      ),
                      ButtonSegment(
                        value: WorkType.digital,
                        label: Text('디지털'),
                        icon: Icon(Icons.computer),
                      ),
                    ],
                    selected: {selectedType},
                    onSelectionChanged: (newSelection) {
                      setDialogState(() {
                        selectedType = newSelection.first;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty) {
                      _addNewArtwork(
                        titleController.text.trim(),
                        selectedType,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('등록'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎨 나의 일러스트 타임라인'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 요약 대시보드
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('전체 작품', '${_artworks.length}개'),
                    _buildStatItem('✏️ 손그림', '$_handDrawnCount개'),
                    _buildStatItem('💻 디지털', '$_digitalCount개'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. 필터 선택 칩
            Row(
              children: [
                const Text('분류 필터: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('전체'),
                  selected: _selectedFilter == WorkType.all,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedFilter = WorkType.all);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('손그림'),
                  selected: _selectedFilter == WorkType.handDrawn,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedFilter = WorkType.handDrawn);
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('디지털'),
                  selected: _selectedFilter == WorkType.digital,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedFilter = WorkType.digital);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 3. 타임라인 작품 리스트
            Expanded(
              child: _filteredArtworks.isEmpty
                  ? const Center(child: Text('등록된 작품이 없습니다.'))
                  : ListView.builder(
                      itemCount: _filteredArtworks.length,
                      itemBuilder: (context, index) {
                        final item = _filteredArtworks[index];
                        final isHand = item.type == WorkType.handDrawn;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isHand
                                  ? Colors.orange.shade100
                                  : Colors.blue.shade100,
                              child: Text(
                                isHand ? '✏️' : '💻',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            title: Text(
                              item.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '작성일: ${item.date.year}-${item.date.month.toString().padLeft(2, '0')}-${item.date.day.toString().padLeft(2, '0')}',
                            ),
                            trailing: Chip(
                              label: Text(
                                isHand ? '손그림' : '디지털',
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: isHand
                                  ? Colors.orange.shade50
                                  : Colors.blue.shade50,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        icon: const Icon(Icons.add),
        label: const Text('작품 등록'),
      ),
    );
  }
}