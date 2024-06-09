import 'package:flutter/material.dart';
import 'Main_02.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '제목 가나다라마바사',
      home: Write(),
    );
  }
}

class Write extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                  Text(
                    '   제목을 입력해주세요',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                
                
              ],
            ),
          ),
         
          Divider(thickness: 1,endIndent: 20 ,indent: 20,),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 330.0, // 컨테이너의 너비를 300.0으로 설정
                  height: 500.0, // 컨테이너의 높이를 100.0으로 설정(필요한 경우)
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '내용을 입력해주세요',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),




        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              
              children: [
                
                SizedBox(width: 250.0),
                ElevatedButton(
                  onPressed: () {
                    // 카테고리 버튼 클릭 시 동작
                  },
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  ),
                  child: Text('등록', style: TextStyle(color: Colors.white)),
                ),
                
                
              ],
            ),
          ),
      ),
    );
  }
}
