import 'package:flutter/material.dart';

void range(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      double _currentValue = 0; // 슬라이더의 초기값을 0으로 설정

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: Container(
              height: 260,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "현재 범위",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 0), // 텍스트와 슬라이더 사이의 간격
                  Slider(
                    value: _currentValue,
                    min: 0,
                    max: 3,
                    divisions: 3,
                    label: (_currentValue + 1).toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentValue = value;
                      });
                    },
                  ),
                  SizedBox(height: 0),
                  // 슬라이더 값에 따라 다른 이미지 표시
                  if (_currentValue == 0)
                    Image.asset(
                      'assets/img_0611/board_map/대덕_1.png',
                      width: 180,
                      height: 180,
                    )
                  else if (_currentValue == 1)
                    Image.asset(
                      'assets/img_0611/board_map/대덕_2.png',
                      width: 180,
                      height: 180,
                    )
                  else if (_currentValue == 2)
                    Image.asset(
                      'assets/img_0611/board_map/대덕_3.png',
                      width: 180,
                      height: 180,
                    )
                  else if (_currentValue == 3)
                    Image.asset(
                      'assets/img_0611/board_map/대덕_4.png',
                      width: 180,
                      height: 180,
                    ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("닫기"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          );
        },
      );
    },
  );
}
