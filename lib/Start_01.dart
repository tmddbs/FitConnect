import 'package:flutter/material.dart';
import 'Start_01_dropdown.dart';
import 'Start_02.dart';

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
                height: 200,
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
                  ],
                ),
              ),
            ),

            SizedBox(height: 100),

            // 버튼 컨테이너
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Start_02(
                              dropdownValue1: dropdownValue1,
                              dropdownValue2: dropdownValue2,
                              dropdownValue3: dropdownValue3,
                            )),
                  );
                },
                style: myButtonStyle,
                child: const Text(
                  'Next',
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
    ));
