import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        useMaterial3: true,
      ),
      home: const TaskPage(),
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // 원본 상태 - 할 일 목록과 각 완료 여부
  final List<String> _tasks = ['5주차 강의 복습', '상태 흐름도 작성'];
  final List<bool> _done = [false, false];

  // 계산값 - 미완료 항목 수
  int get _remaining => _done.where((done) => !done).length;

  // 완료/취소 토글 함수
  void _toggleDone(int index) {
    setState(() {
      _done[index] = !_done[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28.0),
            border: Border.all(color: const Color(0xFF1E293B), width: 3.5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 헤더 제목
              const Text(
                '나의 할 일',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFFE2E8F0), thickness: 1),
              const SizedBox(height: 16),

              // 2. 남은 할 일 수 표시
              Row(
                children: [
                  const Text(
                    '남은 할 일 ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF334155),
                    ),
                  ),
                  Text(
                    '$_remaining',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D9488),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3. 할 일 카드 목록
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final isDone = _done[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: isDone
                          ? const Color(0xFFECFDF5)
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: isDone
                            ? const Color(0xFFA7F3D0)
                            : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isDone
                              ? Icons.check
                              : Icons.radio_button_unchecked,
                          size: 20,
                          color: isDone
                              ? const Color(0xFF0D9488)
                              : const Color(0xFF94A3B8),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _tasks[index],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isDone
                                  ? const Color(0xFF0F172A)
                                  : const Color(0xFF334155),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            onPressed: () => _toggleDone(index),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: isDone
                                  ? const Color(0xFFE2E8F0)
                                  : const Color(0xFFCCFBF1),
                              foregroundColor: isDone
                                  ? const Color(0xFF475569)
                                  : const Color(0xFF0F766E),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              isDone ? '취소' : '완료',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}