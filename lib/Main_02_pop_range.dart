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
              height: 200,
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
                  SizedBox(height: 10), // 텍스트와 슬라이더 사이의 간격
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
                  SizedBox(height: 2),
                  Image.asset('assets/map.png', width: 110, height: 110,)
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("닫기"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
