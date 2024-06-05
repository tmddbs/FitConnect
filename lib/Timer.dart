import 'dart:async';
import 'package:flutter/material.dart';
import 'Main_01.dart';
void main() {
  runApp(const timer());
}

class timer extends StatelessWidget {
  const timer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _initialSeconds = 60;
  int _remainingSeconds = 60;
  bool _isRunning = false;
  Timer? _timer;

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = _initialSeconds;
      _isRunning = false;
    });
  }

  void _setTimer(int seconds) {
    setState(() {
      _initialSeconds = seconds;
      _remainingSeconds = seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 72),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isRunning ? null : _startTimer,
                  child: const Text('Start'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isRunning ? _stopTimer : null,
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Main_01()),
                    );
                  },
                  child: const Text('돌아가기'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            NumberPicker(
              minValue: 0,
              maxValue: 60,
              value: _initialSeconds ~/ 60,
              onChanged: (value) => _setTimer(value * 60 + _initialSeconds % 60),
            ),
            NumberPicker(
              minValue: 0,
              maxValue: 59,
              value: _initialSeconds % 60,
              onChanged: (value) => _setTimer((_initialSeconds ~/ 60) * 60 + value),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberPicker extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final ValueChanged<int> onChanged;

  const NumberPicker({
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (value > minValue) {
              onChanged(value - 1);
            }
          },
        ),
        Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(fontSize: 32),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if (value < maxValue) {
              onChanged(value + 1);
            }
          },
        ),
      ],
    );
  }
}
