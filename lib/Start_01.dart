import 'package:flutter/material.dart';
import 'Start_01_dropdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Start_01(),
    );
  }
}

class Start_01 extends StatefulWidget {
  @override
  _Start_01_State createState() => _Start_01_State();
}

class _Start_01_State extends State<Start_01> {
  String? dropdownValue1;
  String? dropdownValue2;
  String? dropdownValue3;
  final Map<String, List<String>> dropdownOption2 = getDropdownValue2();
  final Map<String, List<String>> dropdownOption3 = getDropdownValue3();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 텍스트 컨테이너
            Container(
              child: const Text(
                '거주지를 선택해주세요',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 100),

            // 드롭다운 컨테이너
            Center(
              child: Container(
                width: 150,
                child: Column(
                  children: [
                    // 첫번째 드롭다운
                    DropdownButton<String>(
                      hint: const Text('시/도'),
                      isExpanded: true,
                      value: dropdownValue1,
                      items: dropdownOption2.keys.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue1 = newValue;
                          dropdownValue2 = null;
                          dropdownValue3 = null;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // 두번째 드롭다운
                    DropdownButton<String>(
                      hint: const Text('시/군/구'),
                      isExpanded: true,
                      value: dropdownValue2,
                      items: dropdownValue1 != null
                          ? dropdownOption2[dropdownValue1!]!
                              .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : [],
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue2 = newValue;
                          dropdownValue3 = null;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // 세번째 드롭다운
                    DropdownButton<String>(
                      hint: const Text('읍/면/동'),
                      isExpanded: true,
                      value: dropdownValue3,
                      items: dropdownValue2 != null
                          ? dropdownOption3[dropdownValue2!]!
                              .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()
                          : [],
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue3 = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            SizedBox(height: 100),

            // 버튼 컨테이너
            Container(
              child: ElevatedButton(
                onPressed: () {
                  // 버튼을 눌렀을 때 실행할 코드
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF55B150),
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 75),
                ),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
