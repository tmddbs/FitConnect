import 'package:flutter/material.dart';
import 'Main_01.dart';
import 'Start_01.dart';

class Start_02 extends StatelessWidget {
  final String? dropdownValue1;
  final String? dropdownValue2;
  final String? dropdownValue3;

  Start_02({this.dropdownValue1, this.dropdownValue2, this.dropdownValue3});

  @override
  Widget build(BuildContext context) {
    String address = '';
    if (dropdownValue1 == null) {
    } else if (dropdownValue2 == null) {
      address += ('$dropdownValue1');
    } else if (dropdownValue3 == null) {
      address += ('$dropdownValue1 $dropdownValue2');
    } else {
      address += ('$dropdownValue1 $dropdownValue2 $dropdownValue3');
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 텍스트 컨테이너
            Container(
              child: Text(
                '$address',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 100),

            Container(
              child: Image.asset(
                'assets/$address.png',
                width: 200,
                height: 200,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                    width: 200,
                    height: 200,
                    child: Center(
                        child: Text('이미지를 찾을 수 없습니다.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ))),
                  );
                },
              ),
            ),

            SizedBox(height: 80),

            // 버튼 컨테이너
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // 추가할 텍스트
                  Text(
                    '이 주소가 맞나요?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 20),

                  // 버튼들
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 첫 번째 버튼
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Start_01()),
                          );
                        },
                        style: myButtonStyle,
                        child: const Text(
                          '< Back',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // 두 번째 버튼
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Main_01()),
                          );
                        },
                        style: myButtonStyle,
                        child: const Text(
                          'Start >',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
