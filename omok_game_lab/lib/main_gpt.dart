import 'package:flutter/material.dart';

void main() {
  runApp(const OmokApp());
}

// 오목판 크기
const int boardSize = 15;

class OmokApp extends StatelessWidget {
  const OmokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '오목 게임',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
        ),
        useMaterial3: true,
      ),
      home: const OmokPage(),
    );
  }
}

class OmokPage extends StatefulWidget {
  const OmokPage({super.key});

  @override
  State<OmokPage> createState() => _OmokPageState();
}

class _OmokPageState extends State<OmokPage> {
  // 0 = 빈칸
  // 1 = 흑돌
  // 2 = 백돌
  late List<List<int>> board;

  int currentPlayer = 1;
  bool gameOver = false;
  String message = '흑돌 차례입니다';

  @override
  void initState() {
    super.initState();
    resetBoard();
  }

  void resetBoard() {
    board = List.generate(
      boardSize,
      (_) => List.filled(boardSize, 0),
    );
  }

  // 돌 놓기
  void placeStone(int row, int col) {
    if (gameOver) return;

    // 이미 돌이 있으면 놓지 않음
    if (board[row][col] != 0) return;

    setState(() {
      board[row][col] = currentPlayer;

      // 승리 확인
      if (checkWin(row, col)) {
        gameOver = true;

        if (currentPlayer == 1) {
          message = '흑돌 승리!';
        } else {
          message = '백돌 승리!';
        }
      }
      // 무승부 확인
      else if (isBoardFull()) {
        gameOver = true;
        message = '무승부입니다!';
      }
      // 다음 차례
      else {
        currentPlayer = currentPlayer == 1 ? 2 : 1;

        message = currentPlayer == 1
            ? '흑돌 차례입니다'
            : '백돌 차례입니다';
      }
    });

    // 게임 종료 메시지
    if (gameOver) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (!mounted) return;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text('게임 종료'),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    startNewGame();
                  },
                  child: const Text('새 게임'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  // 승리 확인
  bool checkWin(int row, int col) {
    final player = board[row][col];

    const directions = [
      [0, 1], // 가로
      [1, 0], // 세로
      [1, 1], // 대각선 ↘
      [1, -1], // 대각선 ↙
    ];

    for (final direction in directions) {
      final rowDirection = direction[0];
      final colDirection = direction[1];

      int count = 1;

      // 한쪽 방향
      count += countStones(
        row,
        col,
        rowDirection,
        colDirection,
        player,
      );

      // 반대 방향
      count += countStones(
        row,
        col,
        -rowDirection,
        -colDirection,
        player,
      );

      if (count >= 5) {
        return true;
      }
    }

    return false;
  }

  // 같은 돌의 개수 계산
  int countStones(
    int row,
    int col,
    int rowDirection,
    int colDirection,
    int player,
  ) {
    int count = 0;

    int r = row + rowDirection;
    int c = col + colDirection;

    while (
        r >= 0 &&
        r < boardSize &&
        c >= 0 &&
        c < boardSize &&
        board[r][c] == player) {
      count++;

      r += rowDirection;
      c += colDirection;
    }

    return count;
  }

  // 바둑판이 꽉 찼는지 확인
  bool isBoardFull() {
    for (final row in board) {
      if (row.contains(0)) {
        return false;
      }
    }

    return true;
  }

  // 새 게임
  void startNewGame() {
    setState(() {
      resetBoard();

      currentPlayer = 1;
      gameOver = false;
      message = '흑돌 차례입니다';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E0B5),
      appBar: AppBar(
        title: const Text(
          '오목',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            // 현재 차례
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPlayer == 1
                          ? Colors.black
                          : Colors.white,
                      border: Border.all(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 오목판
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6A85F),
                    border: Border.all(
                      color: Colors.brown.shade900,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final boardWidth = constraints.maxWidth;
                      final cellSize =
                          boardWidth / (boardSize - 1);

                      return Stack(
                        children: [
                          // 바둑판 선
                          CustomPaint(
                            size: Size(
                              boardWidth,
                              boardWidth,
                            ),
                            painter: BoardPainter(),
                          ),

                          // 착수 위치
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            physics:
                                const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: boardSize,
                            ),
                            itemCount: boardSize * boardSize,
                            itemBuilder: (context, index) {
                              final row = index ~/ boardSize;
                              final col = index % boardSize;

                              return GestureDetector(
                                behavior:
                                    HitTestBehavior.opaque,
                                onTap: () {
                                  placeStone(row, col);
                                },
                                child: Center(
                                  child: board[row][col] == 0
                                      ? const SizedBox()
                                      : Container(
                                          width: cellSize * 0.82,
                                          height: cellSize * 0.82,
                                          decoration:
                                              BoxDecoration(
                                            shape:
                                                BoxShape.circle,
                                            color:
                                                board[row][col] ==
                                                        1
                                                    ? Colors.black
                                                    : Colors.white,
                                            border:
                                                Border.all(
                                              color: Colors.black
                                                  .withValues(
                                                alpha: 0.35,
                                              ),
                                              width: 1,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withValues(
                                                  alpha: 0.25,
                                                ),
                                                blurRadius: 3,
                                                offset:
                                                    const Offset(
                                                  1,
                                                  2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            const Spacer(),

            // 새 게임 버튼
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: ElevatedButton.icon(
                onPressed: startNewGame,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  '새 게임',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 오목판 그리기
class BoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown.shade900
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // 15 x 15의 교차점
    final cellSize = size.width / (boardSize - 1);

    // 가로줄
    for (int row = 0; row < boardSize; row++) {
      final y = row * cellSize;

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // 세로줄
    for (int col = 0; col < boardSize; col++) {
      final x = col * cellSize;

      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // 화점
    final starPaint = Paint()
      ..color = Colors.brown.shade900
      ..style = PaintingStyle.fill;

    const starPositions = [
      [3, 3],
      [3, 11],
      [7, 7],
      [11, 3],
      [11, 11],
    ];

    for (final position in starPositions) {
      final x = position[0] * cellSize;
      final y = position[1] * cellSize;

      canvas.drawCircle(
        Offset(x, y),
        4,
        starPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    return false;
  }
}