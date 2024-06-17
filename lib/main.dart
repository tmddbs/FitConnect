import 'package:flutter/material.dart';
import 'package:ksy_0522/LeaderBoard.dart';
import 'main/Main.dart';
import 'main/Main_01.dart';
import 'start/Start_01.dart';
import 'start/Start_02.dart';
import 'workout/Finish_Workout.dart';
import 'workout/Weight_Trainning_01.dart';
import 'workout/Weight_Trainning_02.dart';
import 'workout/Select_Exercise_Page.dart';
import 'workout/Running_page.dart';
import 'workout/Crossfit_page.dart';
import 'models/Exercise.dart';
import 'Timer.dart';
import 'StopWatch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout App',
      home: Start_01(),
      routes: {
        '/1': (context) => RunningPage(),
        '/2': (context) => Weight_Training_Page_1(),
        '/3': (context) => CrossFitPage(),
        //'/4': (context) => StartExercisePage(), //이 ㄱㅅㄲ;;;;;;아오
        '/5': (context) => Weight_Training_Page_2(),
        '/6': (context) => SelectExercisePage(),
        '/7': (context) {
          // 예시 데이터
          List<Exercise> completedExercises = []; // 여기에 완료된 운동 데이터 리스트를 채워넣어야 함
          int exerciseDuration = 0;
          return FinishWorkoutPage(
              completedExercises: completedExercises,
              exerciseDuration: exerciseDuration);
        },
        '/8': (context) => Start_02(),
        '/9': (context) => Main(),
        '/10': (context) => TimerPage(),
        '/11': (context) => StopwatchPage(),
        '/12': (context) => Leader(),
      },
    );
  }
}
