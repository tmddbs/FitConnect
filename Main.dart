import 'package:flutter/material.dart';
import 'package:ksy_0522/Main_01.dart';
import 'Community_01.dart';
import 'Community_02.dart';
import 'Community_03.dart';
import 'Finish Workout.dart';
import 'LeaderBoard.dart';
import 'Main_02.dart';
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
import 'Main_01.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main1',
      
      home:Main()
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _Main_State();
}

class _Main_State extends State<Main> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        Main_01(),
        Main_02()
      ],
    );
  }
}