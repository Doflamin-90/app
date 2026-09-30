import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const App2());

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  Color _boxColor = Colors.blue;
  double _boxSize = 150.0;

  void _changeBox() {
    final random = Random();
    setState(() {
      _boxColor = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
      _boxSize = 100.0 + random.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('2. 랜덤 상자 변경 앱')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _boxSize,
                height: _boxSize,
                decoration: BoxDecoration(
                  color: _boxColor,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _changeBox,
                icon: const Icon(Icons.refresh),
                label: const Text('색상 & 크기 랜덤 변경'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
