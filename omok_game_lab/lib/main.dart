import 'package:flutter/material.dart';

void main() {
  runApp(const OmokApp());
}

class OmokApp extends StatelessWidget {
  const OmokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '프롬프트 엔지니어링 오목 실습',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const OmokGamePage(),
    );
  }
}

class OmokGamePage extends StatefulWidget {
  const OmokGamePage({super.key});

  @override
  State<OmokGamePage> createState() => _OmokGamePageState();
}

enum Stone { none, black, white }

class _OmokGamePageState extends State<OmokGamePage> {
  static const int gridSize = 15;
  List<Stone> board = List.generate(gridSize * gridSize, (_) => Stone.none);
  Stone currentTurn = Stone.black;
  String statusMessage = "흑돌(Black) 차례입니다.";
  bool isGameOver = false;

  void _resetGame() {
    setState(() {
      board = List.generate(gridSize * gridSize, (_) => Stone.none);
      currentTurn = Stone.black;
      statusMessage = "흑돌(Black) 차례입니다.";
      isGameOver = false;
    });
  }

  void _placeStone(int index) {
    if (board[index] != Stone.none || isGameOver) return;

    setState(() {
      board[index] = currentTurn;

      if (_checkWinner(index, currentTurn)) {
        isGameOver = true;
        statusMessage = "${currentTurn == Stone.black ? '흑돌(Black)' : '백돌(White)'} 승리!";
      } else {
        currentTurn = (currentTurn == Stone.black) ? Stone.white : Stone.black;
        statusMessage = "${currentTurn == Stone.black ? '흑돌(Black)' : '백돌(White)'} 차례입니다.";
      }
    });
  }

  bool _checkWinner(int index, Stone stone) {
    int row = index ~/ gridSize;
    int col = index % gridSize;

    List<List<int>> directions = [
      [0, 1],   // 가로
      [1, 0],   // 세로
      [1, 1],   // 대각선 ↘
      [1, -1],  // 대각선 ↙
    ];

    for (var dir in directions) {
      int count = 1;

      // 정방향 탐색
      for (int i = 1; i < 5; i++) {
        int r = row + dir[0] * i;
        int c = col + dir[1] * i;
        if (r < 0 || r >= gridSize || c < 0 || c >= gridSize) break;
        if (board[r * gridSize + c] == stone) {
          count++;
        } else {
          break;
        }
      }

      // 역방향 탐색
      for (int i = 1; i < 5; i++) {
        int r = row - dir[0] * i;
        int c = col - dir[1] * i;
        if (r < 0 || r >= gridSize || c < 0 || c >= gridSize) break;
        if (board[r * gridSize + c] == stone) {
          count++;
        } else {
          break;
        }
      }

      if (count >= 5) return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프롬프트 엔지니어링 오목 실습'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // 1. 현재 상태 메시지
          Text(
            statusMessage,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 2. 15x15 오목 바둑판
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  color: const Color(0xFFDCB35C), // 바둑판 나무색
                  child: GridView.builder(
                    itemCount: gridSize * gridSize,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSize,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _placeStone(index),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 0.5),
                          ),
                          child: Center(
                            child: board[index] == Stone.none
                                ? null
                                : Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: board[index] == Stone.black
                                          ? Colors.black
                                          : Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // 3. 재시작 버튼
          ElevatedButton.icon(
            onPressed: _resetGame,
            icon: const Icon(Icons.refresh),
            label: const Text('게임 재시작'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}