import 'package:flutter/material.dart';

void main() => runApp(const App1());

class App1 extends StatefulWidget {
  const App1({super.key});

  @override
  State<App1> createState() => _App1State();
}

class _App1State extends State<App1> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text('1. 테마 변경 앱')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 80,
                color: _isDarkMode ? Colors.amber : Colors.orange,
              ),
              const SizedBox(height: 20),
              Text(
                _isDarkMode ? '현재 상태: 다크 모드' : '현재 상태: 라이트 모드',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isDarkMode = !_isDarkMode;
                  });
                },
                child: Text(_isDarkMode ? '라이트 모드로 변경' : '다크 모드로 변경'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}