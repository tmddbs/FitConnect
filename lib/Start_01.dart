import 'package:flutter/material.dart';
import 'Start_01_dropdown.dart';
import 'Start_02.dart';
import 'Start_gps.dart';

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
  late LoadingOverlay _loadingOverlay;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _loadingOverlay.remove();
    super.dispose();
  }

  Future<void> _setInitialLocation() async {
    _loadingOverlay.show();
    try {
      var address = await LocationService.getCurrentAddress();
      setState(() {
        dropdownValue1 = address[0];
        dropdownValue2 = address[1];
        dropdownValue3 = address[2];
      });
    } catch (e) {
      print(e);
    } finally {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Start_02(
                  dropdownValue1: dropdownValue1,
                  dropdownValue2: dropdownValue2,
                  dropdownValue3: dropdownValue3,
                )),
      );
      _loadingOverlay.hide();
    }
  }

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

            SizedBox(height: 80),

            // 버튼 컨테이너
            Container(
              child: Column(
                children: [
                  // 추가할 텍스트
                  GestureDetector(
                    onTap: () {
                      _loadingOverlay = LoadingOverlay(context);
                      _setInitialLocation();
                    },
                    child: const Text(
                      'gps를 이용해 주소 입력',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // 텍스트와 버튼 사이 간격 조절

                  ElevatedButton(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingOverlay {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  LoadingOverlay(this.context);

  void show() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  void hide() {
    _overlayEntry?.remove();
  }

  void remove() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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
