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
  List<int> _completedSteps = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await DatabaseHelper.instance.getArtworks();
      final steps = await DatabaseHelper.instance.getCompletedTutorialSteps();
      if (!mounted) return;
      setState(() {
        _completedSteps = steps;
        _artworks = data.isNotEmpty
            ? data
            : [
                Artwork(id: 1, title: '기초 선 긋기 & 브러시 연습', createdAt: '2026-11-19'),
                Artwork(id: 2, title: '스케치-선화 레이어 분리 실습', createdAt: '2026-11-18'),
              ];
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _artworks = [
          Artwork(id: 1, title: '기초 선 긋기 & 브러시 연습', createdAt: '2026-11-19'),
        ];
      });
    }
  }

  void _openTutorialCanvas({required bool isTutorialMode, required int id, required String title}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LayerDetailScreen(
          artworkId: id,
          artworkTitle: title,
          isTutorialMode: isTutorialMode,
        ),
      ),
    );
    _loadData();
  }

  void _showAddArtworkDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2B2B2B),
          title: const Text('자유 연습 캔버스 만들기', style: TextStyle(color: Colors.white, fontSize: 16)),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: '연습 제목 입력 (예: 명암 불투명도 연습)',
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
                  _openTutorialCanvas(isTutorialMode: false, id: insertedId, title: text);
                }
              },
              child: const Text('시작하기', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 도구별 사용법 도감 모달
  void _showToolDictionaryModal() {
    final tools = [
      {
        'icon': Icons.brush,
        'name': '1. 브러시 & 굵기 (px)',
        'usage': '• 2~5px: 세밀한 눈, 머리카락 선화 작업용\n• 15~30px: 넓은 면 채색 및 수정 포인트 강조 표시용',
      },
      {
        'icon': Icons.opacity,
        'name': '2. 불투명도 (%) 조절',
        'usage': '• 20~40%: 밑그림(러프)을 연하게 깔아두거나 명암을 겹칠 때 사용\n• 100%: 최종 선을 또렷하게 따낼 때 사용',
      },
      {
        'icon': Icons.cleaning_services,
        'name': '3. 지우개 & 실행 취소 (Undo)',
        'usage': '• 선 전체를 되돌릴 때는 하단 실행취소(↶) 버튼을, 선 끝부분만 다듬을 때는 지우개 툴을 사용합니다.',
      },
      {
        'icon': Icons.layers,
        'name': '4. 단계별 레이어 (스케치·선화·채색)',
        'usage': '• 한 캔버스에 다 그리지 않고 작업 단계별로 탭을 나누어 그리면, 이전 단계 그림을 망치지 않고 수정할 수 있습니다.',
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2B2B2B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '드로잉 툴 핵심 사용법 도감',
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: tools.length,
                itemBuilder: (_, index) {
                  final tool = tools[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(tool['icon'] as IconData, color: const Color(0xFF2196F3), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              tool['name'] as String,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          tool['usage'] as String,
                          style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    final completedCount = _completedSteps.length;
    final progressValue = completedCount / 4.0;

    return Scaffold(
      backgroundColor: const Color(0xFF2B2B2B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF333333),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Art Tool Tutorial',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 튜토리얼 학습 진도율 카드
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2196F3).withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '기초 드로잉 툴 마스터 진도',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$completedCount / 4 단계 완료',
                        style: const TextStyle(color: Color(0xFF2196F3), fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 8,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () => _openTutorialCanvas(
                        isTutorialMode: true,
                        id: 999,
                        title: '실습형 툴 튜토리얼',
                      ),
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      label: Text(
                        completedCount == 4 ? '튜토리얼 다시 실습하기' : '단계별 툴 실습 시작하기',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 2. 도구 도감 & 자유 연습 그리드
            Row(
              children: [
                Expanded(
                  child: _buildGridTile(
                    icon: Icons.menu_book_outlined,
                    label: '도구별 사용법 도감',
                    onTap: _showToolDictionaryModal,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildGridTile(
                    icon: Icons.brush,
                    label: '자유 캔버스 연습',
                    onTap: _showAddArtworkDialog,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              '내 툴 연습 & 복기 노트',
              style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _artworks.length,
                itemBuilder: (context, index) {
                  final art = _artworks[index];
                  return Card(
                    color: const Color(0xFF1F1F1F),
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.white10),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.edit_outlined, color: Colors.white),
                      title: Text(
                        art.title,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      subtitle: Text(
                        '최근 연습일: ${art.createdAt}',
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                      onTap: () => _openTutorialCanvas(
                        isTutorialMode: false,
                        id: art.id ?? 1,
                        title: art.title,
                      ),
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
        height: 86,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
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