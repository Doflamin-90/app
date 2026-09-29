import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const BrickBreakerApp());
}

class BrickBreakerApp extends StatelessWidget {
  const BrickBreakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '벽돌깨기 게임',
      theme: ThemeData.dark(),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final FocusNode _focusNode = FocusNode();

  // 공 위치 및 속도 (속도를 0.01로 줄여 더 천천히 움직입니다)
  double ballX = 0;
  double ballY = 0;
  double ballXDirection = 0.01;
  double ballYDirection = -0.01;

  // 패들(바) 위치 및 크기
  double paddleX = 0;
  double paddleWidth = 0.4;
  
  // 패들 이동 속도 (0.18로 늘려 반응 속도를 높였습니다)
  double paddleSpeed = 0.18;

  // 게임 상태
  bool hasGameStarted = false;
  bool isGameOver = false;
  bool isGameWon = false;

  // 벽돌 목록 [x좌표, y좌표, 깨짐여부]
  List myBricks = [
    [-0.8, -0.9, false],
    [-0.4, -0.9, false],
    [0.0, -0.9, false],
    [0.4, -0.9, false],
    [0.8, -0.9, false],
    [-0.8, -0.8, false],
    [-0.4, -0.8, false],
    [0.0, -0.8, false],
    [0.4, -0.8, false],
    [0.8, -0.8, false],
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        ballX += ballXDirection;
        ballY += ballYDirection;
      });

      // 벽 충돌
      if (ballX >= 1 || ballX <= -1) {
        ballXDirection = -ballXDirection;
      }
      if (ballY <= -1) {
        ballYDirection = -ballYDirection;
      }

      // 바닥 충돌 (게임 오버)
      if (ballY >= 1) {
        timer.cancel();
        setState(() {
          isGameOver = true;
        });
      }

      // 패들 충돌
      if (ballY >= 0.85 && ballY <= 0.9 && ballX >= paddleX - paddleWidth / 2 && ballX <= paddleX + paddleWidth / 2) {
        ballYDirection = -ballYDirection;
      }

      // 벽돌 충돌
      for (int i = 0; i < myBricks.length; i++) {
        if (myBricks[i][2] == false) {
          if (ballX >= myBricks[i][0] - 0.15 &&
              ballX <= myBricks[i][0] + 0.15 &&
              ballY <= myBricks[i][1] + 0.05 &&
              ballY >= myBricks[i][1] - 0.05) {
            setState(() {
              myBricks[i][2] = true;
              ballYDirection = -ballYDirection;
            });
          }
        }
      }

      // 모든 벽돌 파괴 (승리)
      if (myBricks.every((brick) => brick[2] == true)) {
        timer.cancel();
        setState(() {
          isGameWon = true;
        });
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (paddleX - paddleSpeed >= -1) {
        paddleX -= paddleSpeed;
      } else {
        paddleX = -1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (paddleX + paddleSpeed <= 1) {
        paddleX += paddleSpeed;
      } else {
        paddleX = 1;
      }
    });
  }

  void resetGame() {
    setState(() {
      ballX = 0;
      ballY = 0;
      ballXDirection = 0.01;
      ballYDirection = -0.01;
      paddleX = 0;
      hasGameStarted = false;
      isGameOver = false;
      isGameWon = false;
      myBricks = [
        [-0.8, -0.9, false],
        [-0.4, -0.9, false],
        [0.0, -0.9, false],
        [0.4, -0.9, false],
        [0.8, -0.9, false],
        [-0.8, -0.8, false],
        [-0.4, -0.8, false],
        [0.0, -0.8, false],
        [0.4, -0.8, false],
        [0.8, -0.8, false],
      ];
    });
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent || event is KeyRepeatEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            moveLeft();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            moveRight();
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          _focusNode.requestFocus();
          if (!hasGameStarted) {
            startGame();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
            child: Stack(
              children: [
                if (!hasGameStarted)
                  const Align(
                    alignment: Alignment(0, -0.2),
                    child: Text(
                      '화면을 마우스로 클릭하여 시작하세요\n(좌/우 화살표 키로 조작)',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),

                if (isGameOver)
                  Align(
                    alignment: const Alignment(0, -0.2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('GAME OVER', style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        ElevatedButton(onPressed: resetGame, child: const Text('다시 시작')),
                      ],
                    ),
                  ),

                if (isGameWon)
                  Align(
                    alignment: const Alignment(0, -0.2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('YOU WIN!', style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        ElevatedButton(onPressed: resetGame, child: const Text('다시 시작')),
                      ],
                    ),
                  ),

                // 공
                Align(
                  alignment: Alignment(ballX, ballY),
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // 패들 (바)
                Align(
                  alignment: Alignment(paddleX, 0.9),
                  child: Container(
                    width: MediaQuery.of(context).size.width * paddleWidth / 2,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),

                // 벽돌
                for (int i = 0; i < myBricks.length; i++)
                  if (!myBricks[i][2])
                    Align(
                      alignment: Alignment(myBricks[i][0], myBricks[i][1]),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}