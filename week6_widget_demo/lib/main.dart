import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ConcurrencyDemoApp());
}

class ConcurrencyDemoApp extends StatelessWidget {
  const ConcurrencyDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vs 병렬성 키워드 확인',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const ConcurrencyHomePage(),
    );
  }
}

class ConcurrencyHomePage extends StatefulWidget {
  const ConcurrencyHomePage({super.key});

  @override
  State<ConcurrencyHomePage> createState() => _ConcurrencyHomePageState();
}

class _ConcurrencyHomePageState extends State<ConcurrencyHomePage> {
  String _statusMessage = '버튼을 눌러 비동기/병렬 연산을 테스트하세요.';
  bool _isAsyncLoading = false;
  bool _isHeavyLoading = false;
  bool _isIsolateLoading = false;

  // 1. 일반 비동기 테스트 (Future.delayed)
  Future<void> _runAsyncTest() async {
    setState(() {
      _isAsyncLoading = true;
      _statusMessage = '일반 비동기 작업 진행 중...';
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isAsyncLoading = false;
      _statusMessage = '일반 비동기 테스트 완료! (작업 멈춤 없음)';
    });
  }

  // 2. 메인 스레드 무거운 연산 (UI 멈춤 발생)
  void _runHeavyCalculation() {
    setState(() {
      _isHeavyLoading = true;
      _statusMessage = '메인 무거운 연산 계산 중... (UI 멈춤 주의)';
    });

    // 동기식 무거운 연산
    int total = 0;
    for (int i = 0; i < 2000000000; i++) {
      total += i;
    }

    setState(() {
      _isHeavyLoading = false;
      _statusMessage = '메인 무거운 연산 완료! (결과: $total)';
    });
  }

  // 3. Isolate 병렬 연산 (스레드 분리)
  Future<void> _runIsolateCalculation() async {
    setState(() {
      _isIsolateLoading = true;
      _statusMessage = 'Isolate 병렬 연산 시작...';
    });

    // compute를 사용한 백그라운드 Isolate 분리 연산
    final result = await compute(_heavyTask, 2000000000);

    setState(() {
      _isIsolateLoading = false;
      _statusMessage = 'Isolate 병렬 연산 완료! (결과: $result)';
    });
  }

  // Isolate에서 실행할 최상위/정적 함수
  static int _heavyTask(int count) {
    int total = 0;
    for (int i = 0; i < count; i++) {
      total += i;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('vs 병렬성 키워드 확인'),
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: Column(
        children: [
          // 결과 표시 및 로딩 표시 영역
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isAsyncLoading || _isHeavyLoading || _isIsolateLoading)
                    const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _statusMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 하단 버튼 레이아웃 영역 (교수님 화면과 동일한 스타일)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 버튼 1: 일반 비동기 테스트
              ElevatedButton(
                onPressed: _runAsyncTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text('1. 일반 비동기 테스트 (앱 멈춤 없음)'),
              ),
              // 버튼 2: 메인 무거운 연산
              ElevatedButton(
                onPressed: _runHeavyCalculation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text('2. 메인 무거운 연산 (스레드 독점)'),
              ),
              // 버튼 3: Isolate 병렬 연산
              ElevatedButton(
                onPressed: _runIsolateCalculation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text('3. Isolate 병렬 연산 (스레드 분리)'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}