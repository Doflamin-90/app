import 'package:flutter/material.dart';

void main() => runApp(const App3());

class App3 extends StatefulWidget {
  const App3({super.key});

  @override
  State<App3> createState() => _App3State();
}

class _App3State extends State<App3> {
  double _fontSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('3. 폰트 크기 조절 앱')),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '크기 조절 텍스트',
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 10),
              Text('현재 크기: ${_fontSize.toInt()}pt', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              Slider(
                value: _fontSize,
                min: 10.0,
                max: 50.0,
                divisions: 40,
                label: '${_fontSize.toInt()}',
                onChanged: (value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}