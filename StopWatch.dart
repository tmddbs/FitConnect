import 'package:flutter/material.dart';
import 'dart:async';
import 'Finish Workout.dart';
import 'LeaderBoard.dart';
import 'Main_01.dart';
import 'Main_02_pop_range.dart';
import 'Profile_01.dart';
import 'Profile_02.dart';
import 'Profile_03.dart';
import 'Select_Exercise_Page.dart';
import 'Start_01.dart';
import 'Start_02.dart';
import 'StopWatch.dart';
import 'Timer.dart';
import 'Weight_Trainning_Page_1.dart';
import 'Weight_Trainning_Page_2.dart';
import 'Weight_Trainning_recording_page_1.dart';
import 'Write.dart';

void main() {
  runApp(const stopwatch());
}

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
            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Main_01()),
                    );
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
      bottomNavigationBar: BottomAppBar( color: Color.fromARGB(31, 82, 78, 78),
        child: Container(
          child: Row(
            mainAxisAlignment : MainAxisAlignment.spaceAround,
            children: [
              
              IconButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => stopwatch()),
                    );
                  }, icon: Icon(Icons.timer, size: 35.0),),
              IconButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => timer()),
                    );
                  }, icon: Icon(Icons.timer_10, size: 35.0)),
              IconButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => stopwatch()),
                    );
                  }, icon: Icon(Icons.fitness_center, size: 35.0)),
                  
            ],
          ),
        ),
      ),
    );
  }
}
