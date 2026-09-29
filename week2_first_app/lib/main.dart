import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _strNo = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _strNo = "";
      num1 = 0;
      num2 = 0;
      operand = "";
      _output = "0";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X") {
      num1 = double.parse(_output);
      operand = buttonText;
      _strNo = "";
    } else if (buttonText == ".") {
      if (_strNo.contains(".")) return;
      _strNo = _strNo + buttonText;
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      if (operand == "+") _strNo = (num1 + num2).toString();
      if (operand == "-") _strNo = (num1 - num2).toString();
      if (operand == "X") _strNo = (num1 * num2).toString();
      if (operand == "/") _strNo = (num1 / num2).toString();
      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      _strNo = _strNo + buttonText;
    }

    setState(() {
      _output = _strNo.isEmpty ? "0" : _strNo;
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(24.0)),
          child: Text(buttonText, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("간단 계산기")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(_output, style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold)),
          ),
          const Expanded(child: Divider()),
          Column(children: [
            Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("/")]),
            Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("X")]),
            Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")]),
            Row(children: [buildButton("."), buildButton("0"), buildButton("00"), buildButton("+")]),
            Row(children: [buildButton("CLEAR"), buildButton("=")]),
          ])
        ],
      ),
    );
  }
}