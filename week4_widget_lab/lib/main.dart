import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '프로필 화면',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 화면'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // TODO(AC1): 프로필 머리말 (CircleAvatar, Text, Icon 조합)
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '김민재',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '컴퓨터공학과 / Flutter 개발자 지망',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // TODO(AC2): 정보 카드 세 개 (관심 분야, 이번 주 목표, 연락 방법)
          const Card(
            child: ListTile(
              leading: Icon(Icons.star, color: Colors.amber),
              title: Text('관심 분야'),
              subtitle: Text('Flutter 앱 개발, Dart 언어, UI/UX 디자인'),
            ),
          ),
          const SizedBox(height: 8),

          const Card(
            child: ListTile(
              leading: Icon(Icons.flag, color: Colors.green),
              title: Text('이번 주 목표'),
              subtitle: Text('기본 위젯 조합법 익히기 및 제출 완료하기'),
            ),
          ),
          const SizedBox(height: 8),

          const Card(
            child: ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('연락 방법'),
              subtitle: Text('user@example.com / GitHub: @Doflamin-90'),
            ),
          ),
          const SizedBox(height: 24),

          // TODO(AC3): 확인 버튼과 SnackBar 피드백
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('프로필을 확인했습니다'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text('프로필 확인', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}