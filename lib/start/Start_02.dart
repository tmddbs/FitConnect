import 'package:flutter/material.dart';
import '../global.dart';

class Start_02 extends StatelessWidget {
  final String? dropdownValue1;
  final String? dropdownValue2;
  final String? dropdownValue3;

  Start_02({this.dropdownValue1, this.dropdownValue2, this.dropdownValue3});

  @override
  Widget build(BuildContext context) {
    String address = '';
    if (dropdownValue1 != null) {
      address += dropdownValue1!;
    }
    if (dropdownValue2 != null) {
      address += ' ' + dropdownValue2!;
    }
    if (dropdownValue3 != null) {
      address += ' ' + dropdownValue3!;
    }

    globalMyData.address = address;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                'assets/map/$address.png',
                width: 200,
                height: 200,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Text(
                        '이미지를 찾을 수 없습니다.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 80),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    '이 주소가 맞나요?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
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
                      ElevatedButton(
                        onPressed: () {
                          // Main 페이지로 이동
                          Navigator.pushNamed(context, '/9');
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

final ButtonStyle myButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.white,
  foregroundColor: Color(0xff55b150),
  minimumSize: Size(125, 50),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
    side: BorderSide(
      color: Color(0xff55b150),
      width: 4,
    ),
  ),
);
