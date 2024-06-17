import 'package:flutter/material.dart';
import 'Start_Exercise.dart';

class Weight_Training_Page_1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // 상단바의 높이를 조정
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 20, top: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Daily Workout', style: TextStyle(fontSize: 25)),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.arrow_drop_down,
                        color: Color.fromARGB(255, 29, 80, 250)),
                    iconSize: 45,
                    onSelected: (String result) {
                      if (result == 'Running') {
                        Navigator.pushNamed(context, '/1');
                      } //else if (result == 'Weight Training') {
                      //Navigator.pushNamed(context, '/2');}
                      else if (result == 'Cross-Fit') {
                        Navigator.pushNamed(context, '/3');
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Running',
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child:
                              Text('Running', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Weight Training',
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('Weight Training',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Cross-Fit',
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child:
                              Text('Cross-Fit', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)), // 메뉴 모서리를 둥글게
                    color: Colors.white, // 메뉴의 배경색
                    elevation: 4.0, // 메뉴의 그림자 깊이
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),

      //구분
      body: Container(
        //메인부
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Divider(color: Color.fromARGB(255, 99, 99, 99)),
            Padding(
              padding: EdgeInsets.only(
                  //패딩 조절용
                  top: 0.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 10.0),
              child: Text('Continue Program',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),

            //구분
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromARGB(202, 231, 231, 231), // 전체 컨테이너의 기본 배경색
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        child: Image.asset(
                          'assets/img_0611/dumb_icon.png',
                          width: 72, // 이미지의 너비 조정
                          height: 72, // 이미지의 높이 조정
                          //color: Colors.white, // 이미지에 색상 효과를 적용하고 싶을 때 사용
                        ),
                      ),
                      SizedBox(width: 15), // 이미지와 텍스트 사이 간격
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 65, 177, 70),
                                const Color.fromARGB(255, 156, 207, 96)
                              ], // 그라데이션 적용
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.3, 0.7], // 그라데이션 변경 지점
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Text(
                            "Mango's Program_1",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                      color: Color.fromARGB(
                          183, 110, 252, 82)), // 첫 번째 행과 운동 목록 사이의 구분선
                  _buildExerciseRow('Exercise', 'Set', 'Top Set'),
                  Divider(color: Color.fromARGB(183, 129, 129, 129)),
                  _buildExerciseRow('DeadLift(Barbell)', '3', '6reps'),
                  Divider(color: Color.fromARGB(183, 129, 129, 129)),
                  _buildExerciseRow('Shoulder Press(Dumbell)', '4', '12reps'),
                  Divider(color: Color.fromARGB(183, 129, 129, 129)),
                  _buildExerciseRow('Squat(Barbell)', '3', '8reps'),
                  Divider(color: Color.fromARGB(183, 129, 129, 129)),
                  _buildExerciseRow('Pull down(Machine)', '4', '12reps'),
                  Divider(color: Color.fromARGB(183, 129, 129, 129)),
                  _buildExerciseRow('Dips', '3', '15reps'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StartExercisePage(selectedExercises: [])));
                    },
                    child:
                        Text('Start Exercise', style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 106, 204,
                          110), // Flutter 2.0 이후 버전에서는 backgroundColor 사용
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 3),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/5'),
              child: Text('+ Create Program', style: TextStyle(fontSize: 30)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[300],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//함수 _buildExerciseRow - Weight_Trainning_Page_1에서 프로그램의 운동 관련 항목 표시 -
Widget _buildExerciseRow(String exercise, String sets, String reps) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Expanded(
        flex: 3,
        child: Text(exercise, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      Expanded(
        child: Text(sets, textAlign: TextAlign.center),
      ),
      Expanded(
        child: Text(reps, textAlign: TextAlign.right),
      ),
    ],
  );
}
