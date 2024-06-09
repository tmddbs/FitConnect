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
class Commu extends StatefulWidget {
  @override
  _CommuState createState() => _CommuState();
}

class _CommuState extends State<Commu> {
  List<String> comments = []; // 댓글 목록을 저장할 리스트

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
                  '  [제목] 어쩌구저쩌구',
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
                  onPressed: () {},
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
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '    댓글',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          // 댓글 목록
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return buildComment(comments[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (comment) {
                      // 입력된 댓글을 댓글 목록에 추가하고 입력 필드를 비웁니다.
                      setState(() {
                        comments.add(':  ' + comment);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('댓글이 등록되었습니다.'),
                        duration: Duration(seconds: 1),
                      ));
                    },
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(Icons.comment),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // 등록 버튼 클릭 시 동작 (댓글을 추가하는 작업을 여기에 넣어도 됩니다.)
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('댓글이 등록되었습니다.'),
                      
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  child: Text('등록', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildComment(String comment) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
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
        child: Text(
          comment,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
