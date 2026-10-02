import 'package:flutter/material.dart';

void main() => runApp(const Week05App());

class Week05App extends StatelessWidget {
  const Week05App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
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
  final List<String> _titles = ['5주차 강의 복습', '상태 흐름도 작성'];

  // TODO(AC1): 원본 상태로 bool 리스트 선언 및 초기화
  final List<bool> _done = [false, false];

  // TODO(AC3): 원본 상태(_done)에서 계산된 남은 할 일 수 반환 (중복 저장 X)
  int get _remaining => _done.where((done) => !done).length;

  // TODO(AC2): setState 안에서 토글 기능 구현
  void _toggleDone(int index) {
    setState(() {
      _done[index] = !_done[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('나의 할 일')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('남은 할 일: $_remaining',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          for (var i = 0; i < _titles.length; i++)
            Card(
              child: ListTile(
                leading: Icon(
                  _done[i] ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: _done[i] ? Colors.teal : Colors.grey,
                ),
                title: Text(
                  _titles[i],
                  style: TextStyle(
                    decoration: _done[i] ? TextDecoration.lineThrough : null,
                  ),
                ),
                // TODO(AC2): 완료 여부에 따라 버튼 문구 변경
                trailing: TextButton(
                  onPressed: () => _toggleDone(i),
                  child: Text(_done[i] ? '취소' : '완료'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}