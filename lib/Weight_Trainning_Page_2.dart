import 'package:flutter/material.dart';

class Weight_Training_Page_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Program"),
        actions: [
          ElevatedButton(
            //디자인에 있어서 일단 버튼은 추가했는데 이건 뭐지....?
            onPressed: () => Navigator.pushNamed(context, '/7'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 58, 161, 58), // 버튼 배경색
              foregroundColor: Color.fromARGB(255, 226, 226, 226), // 버튼 텍스트색
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            child: Text('List'),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      //구분용
      body: Column(
        children: [
          Divider(color: Colors.grey), // 구분선
          Container(
            padding: EdgeInsets.only(
                //패딩 조절용
                top: 10.0,
                left: 70.0,
                right: 100.0,
                bottom: 10.0),
            margin: EdgeInsets.only(
                //마진 조절용
                top: 10.0,
                left: 16.0,
                right: 16.0,
                bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3), // position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Custom Program_1",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("01 June 2024", style: TextStyle(color: Colors.grey[600])),
                Text("55:24 min", style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/6'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 235, 235, 235), // 버튼 배경색
              foregroundColor: Color.fromARGB(255, 145, 145, 145), // 버튼 텍스트색
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            child: Text('+ Add Exercises'),
          ),
        ],
      ),
    );
  }
}
