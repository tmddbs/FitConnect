import 'dart:async';
import 'package:flutter/material.dart';
import 'Finish_Workout.dart';
import '../models/Exercise.dart';
import '../models/TimerManager.dart';

class StartExercisePage extends StatefulWidget {
  final List<Exercise> selectedExercises;

  StartExercisePage({Key? key, required this.selectedExercises})
      : super(key: key);

  @override
  _StartExercisePageState createState() => _StartExercisePageState();
}

class _StartExercisePageState extends State<StartExercisePage> {
  TimerManager timerManager = TimerManager();
  int _stopwatchSeconds = 0;
  Timer? _stopwatchTimer;
  bool _isStopwatchRunning = false;
  late List<Exercise> _selectedExercises;

  @override
  void initState() {
    super.initState();
    _initializeSession();
  }

  void _initializeSession() {
    _selectedExercises = List.from(widget.selectedExercises); // 초기 운동 리스트 복사
    _stopwatchSeconds = 0;
    _isStopwatchRunning = false;
    _stopwatchTimer?.cancel();
  }

  void _toggleStopwatch() {
    if (_isStopwatchRunning) {
      _stopwatchTimer?.cancel();
    } else {
      _stopwatchTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _stopwatchSeconds++;
        });
      });
    }
    setState(() {
      _isStopwatchRunning = !_isStopwatchRunning;
    });
  }

  void _finishExercise() {
    // 스탑워치가 실행 중이라면 중지
    if (_isStopwatchRunning) {
      _stopwatchTimer?.cancel();
    }

    // 완료된 운동 목록 필터링 (여기서 각 운동의 세트별 완료 상태를 확인하고 필터링합니다.)
    List<Exercise> completedExercises = _selectedExercises.where((exercise) {
      return exercise.sets.any((set) => set.completed);
    }).toList();
    // 로그 출력: 완료된 운동과 각 세트의 상세 정보
    print("Completed Exercises: ${completedExercises.length}");
    for (Exercise exercise in completedExercises) {
      print("Exercise: ${exercise.name}");
      for (ExerciseSet set in exercise.sets) {
        print("  Set ${set.setNumber}: ${set.kg} kg x ${set.reps} reps");
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FinishWorkoutPage(
            completedExercises: completedExercises,
            exerciseDuration: _stopwatchSeconds),
      ),
    );
  }

  void _resetState() {
    setState(() {
      _selectedExercises = List.from(widget.selectedExercises); // 초기 상태로 재설정
      _stopwatchSeconds = 0;
      _isStopwatchRunning = false;
      for (var exercise in _selectedExercises) {
        for (var set in exercise.sets) {
          set.completed = false; // 모든 세트의 완료 상태를 초기화
        }
      }
    });
  }

  @override
  void dispose() {
    _stopwatchTimer?.cancel();
    timerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Exercise'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildStopwatchControls(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedExercises.length,
              itemBuilder: (context, index) {
                return ExerciseInputCard(
                  exercise: widget.selectedExercises[index],
                  showRestTimerCallback: () =>
                      timerManager.showRestTimer(context),
                  resetRestTimerCallback: () => timerManager.resetRestTimer(),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('+ Add Exercise'),
              ),
              ElevatedButton(
                onPressed: () => timerManager.updateRestTime(context),
                child: Text('Set Rest Timer'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStopwatchControls() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _toggleStopwatch,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Icon(_isStopwatchRunning ? Icons.pause : Icons.play_arrow),
                  SizedBox(width: 5),
                  Text(formatTime(_stopwatchSeconds)),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _finishExercise,
            child: Text(
              'Finish',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 161, 224, 149),
            ),
          ),
        ],
      ),
    );
  }
}

String formatTime(int seconds) {
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}

Widget buildTitleSection() {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 0, right: 230, top: 0, bottom: 5),
        child: Text(
          'Custom Program_1',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 0, right: 305, top: 0, bottom: 5),
        child: Text(
          'Week 1, Day 1',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
      ),
      Divider(),
    ],
  );
}

class ExerciseInputCard extends StatefulWidget {
  final Exercise exercise;
  final Function showRestTimerCallback;
  final Function resetRestTimerCallback;

  ExerciseInputCard({
    Key? key,
    required this.exercise,
    required this.showRestTimerCallback,
    required this.resetRestTimerCallback,
  }) : super(key: key);
  @override
  _ExerciseInputCardState createState() => _ExerciseInputCardState();
}

class _ExerciseInputCardState extends State<ExerciseInputCard> {
  List<ExerciseSet> sets = []; // 초기화를 선언부에서 제거
  // UI 업데이트와 동기화를 위한 체크박스 상태
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    sets = widget.exercise.sets;
  }

  void addSet() {
    setState(() {
      sets.add(ExerciseSet(setNumber: sets.length + 1));
    });
  }

  void checkSetComplete(ExerciseSet set) {
    setState(() {
      set.completed = !set.completed;
    });
  }

  void onKgChanged(String value, ExerciseSet set) {
    try {
      int kg = int.parse(value);
      setState(() {
        set.kg = kg; // 정상적인 경우 kg 값 업데이트
      });
    } catch (e) {
      // 숫자 변환 실패 시 사용자에게 오류 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid number for kg"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void onRepsChanged(String value, ExerciseSet set) {
    try {
      int reps = int.parse(value);
      setState(() {
        set.reps = reps; // 정상적인 경우 reps 값 업데이트
      });
    } catch (e) {
      // 숫자 변환 실패 시 사용자에게 오류 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid number for reps"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Text(widget.exercise.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: sets.length,
            itemBuilder: (context, index) {
              return buildSetInput(sets[index]);
            },
          ),
          ElevatedButton(
            onPressed: addSet,
            child: Text(
              '+ Add Set',
              style: TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(300, 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: const Color.fromARGB(255, 182, 182, 182), // 배경색
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSetInput(ExerciseSet set) {
    return Dismissible(
      key: Key(set.hashCode.toString()), // 고유한 키를 사용하여 각 세트 식별
      direction: DismissDirection.endToStart, // 오른쪽에서 왼쪽으로 스와이프
      onDismissed: (direction) {
        setState(() {
          sets.remove(set); // 해당 세트 제거
        });
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text('Set ${set.setNumber}', textAlign: TextAlign.center),
            ),
            Expanded(
              flex: 1,
              child: Text(set.target, textAlign: TextAlign.center),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: set.kgController,
                decoration: InputDecoration(
                  labelText: 'Kg',
                  isDense: true,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  int? kg = int.tryParse(val);
                  if (kg != null) {
                    setState(() {
                      set.kg = kg;
                    });
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: set.repsController,
                decoration: InputDecoration(
                  labelText: 'Reps',
                  isDense: true,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  int? reps = int.tryParse(val);
                  if (reps != null) {
                    setState(() {
                      set.reps = reps;
                    });
                  }
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  set.completed = !set.completed; // 체크 토글
                  if (set.completed) {
                    widget.resetRestTimerCallback(); // 타이머 초기화
                    widget.showRestTimerCallback(); // 세트 완료 시 타이머 실행
                  }
                });
              },
              child: Icon(
                set.completed ? Icons.check_circle : Icons.check_circle_outline,
                color: set.completed ? Colors.green : null,
              ),
            ),
          ],
        ),
        onTap: () => checkSetComplete(set),
      ),
    );
  }
}

class RestTimerDialog extends StatefulWidget {
  final int initialTime;
  RestTimerDialog({Key? key, required this.initialTime}) : super(key: key);

  @override
  _RestTimerDialogState createState() => _RestTimerDialogState();
}

class _RestTimerDialogState extends State<RestTimerDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTime.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set Rest Timer'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Rest time in seconds',
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Set'),
          onPressed: () {
            final int? time = int.tryParse(_controller.text);
            if (time != null) {
              Navigator.pop(context, time);
            }
          },
        ),
      ],
    );
  }
}
