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
      home: Commu(),
    );
  }
}

class Commu extends StatelessWidget {
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
                    '[제목] 어쩌구저쩌구',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                
                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.circle, size: 30.0, color: const Color.fromARGB(255, 88, 88, 88)),
                ),
                Column(
                  children: [
                    Text('data'),
                    Text('data'),

                  ],
                )
              ],
            ),
          ),
          Divider(thickness: 1),
          Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                    '종앙선거관리위원회는 대통령의 임기만료 3일 전 실시한다. 종앙선거관리위원회는 대통령의 임기만료 3일 전 실시한다종앙선거관리위원회는 대통령의 임기만료 3일 전 실시한다종앙선거관리위원회는 대통령의 임기만료 3일 전 실시한다종앙선거관리위원회는 대통령의 임기만료 3일 전 실시한다종앙선거관리위원회는 대통령의 임기만료 3일 전 실시한다국회에서는 대통령을 선출한다. 대통령은 대한민국의 원수이며, 국가를 대표한다.',
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
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // 카테고리 버튼 클릭 시 동작
                  },
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
