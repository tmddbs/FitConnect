import 'package:flutter/material.dart';
import 'package:ksy_0522/main/Main.dart';
import 'dart:async';
import 'Timer.dart';

class stopwatch extends StatelessWidget {
  const stopwatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  double _seconds = 0.0;
  bool _isRunning = false;
  late Timer _timer;
  List<double> _laps = [];

  void _startStopwatch() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _seconds += 0.01;
      });
    });
  }

  void _stopStopwatch() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetStopwatch() {
    _timer.cancel();
    setState(() {
      _seconds = 0.0;
      _laps.clear();
      _isRunning = false;
    });
  }

  void _recordLap() {
    setState(() {
      _laps.insert(0, _seconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/9');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _seconds.toStringAsFixed(2),
              style: const TextStyle(fontSize: 72),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isRunning ? null : _startStopwatch,
                  child: const Text('Start'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isRunning ? _stopStopwatch : null,
                  child: const Text('Stop'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isRunning ? _recordLap : null,
                  child: const Text('Lap'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Laps'),
            Expanded(
              child: ListView.builder(
                itemCount: _laps.length,
                itemBuilder: (context, index) {
                  double lapTime = _laps[index];
                  return ListTile(
                    title: Text('Lap ${_laps.length - index}'),
                    trailing: Text(lapTime.toStringAsFixed(2)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(31, 82, 78, 78),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.timer, size: 35.0),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/10');
                  },
                  icon: Icon(Icons.timer_10, size: 35.0)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/2');
                  },
                  icon: Icon(Icons.fitness_center, size: 35.0)),
            ],
          ),
        ),
      ),
    );
  }
}
