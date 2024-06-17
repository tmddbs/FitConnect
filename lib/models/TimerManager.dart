import 'dart:async';
import 'package:flutter/material.dart';

class TimerManager {
  Timer? _timer;
  int restSeconds = 60;
  final StreamController<int> _timerStreamController =
      StreamController<int>.broadcast();

  Stream<int> get timerStream => _timerStreamController.stream;

  void startTimer(int duration) {
    restSeconds = duration; // 시작 시간 설정
    _timer?.cancel(); // 기존 타이머가 있으면 취소
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (restSeconds > 0) {
        restSeconds--;
        _timerStreamController.add(restSeconds); // 스트림에 현재 시간을 푸시
      } else {
        timer.cancel();
        _timerStreamController.add(0); // 스트림에 0을 푸시
      }
    });
  }

  void showRestTimer(BuildContext context) {
    _timer?.cancel(); // 기존 타이머가 있으면 취소

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (restSeconds > 0) {
        restSeconds--;
        _timerStreamController.add(restSeconds); // 스트림에 현재 시간을 푸시
      } else {
        timer.cancel();
        _timerStreamController.add(0); // 스트림에 0을 푸시
        Navigator.of(context).pop(); // 타이머가 끝나면 dialog 닫음
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rest Timer'),
          content: StreamBuilder<int>(
            stream: timerStream,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text(
                formatTime(snapshot.data ?? restSeconds),
                style: TextStyle(fontSize: 48),
              );
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _timer?.cancel();
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void resetRestTimer() {
    restSeconds = 60; // 기본 휴식 시간으로 초기화 (필요에 따라 변경 가능)
  }

  void updateRestTime(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController timeController =
            TextEditingController(text: restSeconds.toString());
        return AlertDialog(
          title: Text("Set Rest Time"),
          content: TextField(
            controller: timeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Rest time in seconds",
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                int? newTime = int.tryParse(timeController.text);
                if (newTime != null) {
                  restSeconds = newTime;
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void dispose() {
    _timer?.cancel();
    _timerStreamController.close();
  }
}
