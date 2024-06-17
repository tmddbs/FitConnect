import 'package:flutter/material.dart';
import 'Community_01.dart';
import '../main/Main_02_pop_range.dart';
import '../Profile.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Custom Layout', home: Main_02());
  }
}

class Main_02 extends StatefulWidget {
  const Main_02({super.key});

  @override
  State<Main_02> createState() => _Main_02State();
}

class _Main_02State extends State<Main_02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Transform.rotate(
            angle: 0, // 라디안 단위로 180도를 나타냅니다.
            child: Icon(
              Icons.hdr_strong,
              size: 30,
              color: Colors.green,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    range(context);
                  },
                  child: Text(
                    '#한강로동',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.circle,
                      size: 70.0, color: Color.fromARGB(255, 115, 197, 119)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 카테고리 버튼 클릭 시 동작
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  ),
                  child: Text('카테고리', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '검색어를 입력하세요',
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
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // 항목 개수
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () {
                    Widget destinationPage;

                    switch (index) {
                      case 0:
                        destinationPage = Commu(); // community_01.dart의 페이지 위젯
                        break;
                      case 1:
                        destinationPage = Commu(); // community_02.dart의 페이지 위젯
                        break;
                      case 2:
                        destinationPage = Commu(); // community_03.dart의 페이지 위젯
                        break;
                      case 3:
                        destinationPage = Commu(); // community_04.dart의 페이지 위젯
                        break;
                      case 4:
                        destinationPage = Commu(); // community_05.dart의 페이지 위젯
                        break;
                      default:
                        destinationPage = Main_02(); // 에러 페이지 또는 기본 페이지
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => destinationPage),
                    );
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.green),
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
                        Row(
                          children: [
                            Chip(
                              label: Text('#태그',
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green,
                            ),
                            SizedBox(width: 5.0),
                            Chip(
                              label: Text('#태그',
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '제목',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Text('내용'),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('지역명', style: TextStyle(color: Colors.grey)),
                            Text('시간', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent, // 바텀앱바 배경 없애기
        elevation: 0, // 그림자 없애기
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Write()),
                // );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: Size(100, 50),
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                '글쓰기',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
