import 'package:flutter/material.dart';
import 'StopWatch.dart';
import 'Timer.dart';
import 'Profile_01.dart';
import 'LeaderBoard.dart';
import 'Main_02.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main1',
      
      home: Scaffold(
        body: PageView(
        children: [
          Main_01(),
          Main_02()
        ],
      ),
      ),
    );
  }
}

class Main_01 extends StatefulWidget {
  const Main_01({super.key});

  @override
  State<Main_01> createState() => _Main_01State();
}

class _Main_01State extends State<Main_01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title: Transform.rotate(
            angle: 3.14159, // 라디안 단위로 180도를 나타냅니다.
            child: Icon(Icons.hdr_strong, size: 30, color: Colors.green,),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        // 스크린의 크기를 정의하는 Container
        width: MediaQuery.of(context).size.width, // 스크린의 너비
        height: MediaQuery.of(context).size.height, // 스크린의 높이
        child: Stack(
          
          children: [
            Column(
              children: [
                Text('오늘의 활동', style: TextStyle(letterSpacing: 1.0, fontSize: 25, fontWeight: FontWeight.bold)),
                Text('1509 칼로리', style: TextStyle(letterSpacing: 1.0, fontSize: 25),),
              ],
            ),
            Positioned(
              top: 70, // 원하는 위치의 값을 지정
              left: -40, // 원하는 위치의 값을 지정
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Leader()),
                    );
                  print('이미지 클릭됨');
                },
                child: Image.asset(
                  'assets/map.png',
                  width: 450,
                  height: 450,
                ),
              ),
            ),
            Positioned(
              top: 90, // 원하는 위치의 값을 지정
              left: 180, // 원하는 위치의 값을 지정
              child: InkWell(
                onTap: () {
                  showPopup(context);
                },
                child: Image.asset(
                  'assets/ping1.png',
                  width: 160,
                  height: 160,
                ),
              ),
            ),
            Positioned(
              top: 180, // 원하는 위치의 값을 지정
              left: 10, // 원하는 위치의 값을 지정
              child: InkWell(
                onTap: () {
                  // 이미지 클릭 시 실행할 동작
                  print('이미지 클릭됨');
                },
                child: Image.asset(
                  'assets/ping1.png',
                  width: 140,
                  height: 140,
                ),
              ),
            ),
            Positioned(
              top: 270, // 원하는 위치의 값을 지정
              left: 210, // 원하는 위치의 값을 지정
              child: InkWell(
                onTap: () {
                  // 이미지 클릭 시 실행할 동작
                  print('이미지 클릭됨');
                },
                child: Image.asset(
                  'assets/ping1.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar( color: Colors.white10,
        child: Container(
          child: Row(
            children: [
              IconButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => stopwatch()),
                    );
                  }, icon: Icon(Icons.timer)),
              IconButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => timer()),
                    );
                  }, icon: Icon(Icons.timer_10)),
              IconButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => stopwatch()),
                    );
                  }, icon: Icon(Icons.fitness_center)),
                  
            ],
          ),
        ),
      ),
    );

  }
}