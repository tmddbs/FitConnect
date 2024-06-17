import 'dart:async';
import 'package:ksy_0522/Profile.dart';
import 'package:ksy_0522/global.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Main_01 extends StatefulWidget {
  @override
  State<Main_01> createState() => _Main_01State();
}

class _Main_01State extends State<Main_01> {
  int _number = 0;

  @override
  void initState() {
    super.initState();
    _loadNumber();
  }

  Future<void> _loadNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _number = prefs.getInt('savedNumber') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Person> topThreePersons = getSortedPersonsBytodyaCalories();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('오늘의 활동',
                        style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    Text(globalMyData.todayCalories.toString() + ' 칼로리',
                        style: TextStyle(letterSpacing: 1.0, fontSize: 25)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/12'),
                  child: Container(
                    width: 350,
                    height: 350,
                    child: Image.asset(
                      'assets/map/' +
                          globalMyData.address +
                          '.png', //address 필요
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Center(
                          child: Text('이미지를 찾을 수 없습니다.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              )),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 180,
                  child: InkWell(
                    onTap: () {
                      showPopup(context, topThreePersons[1]);
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          top: 24,
                          left: 28,
                          child: Image.asset(
                            'assets/marker/' + topThreePersons[1].profileImage,
                            width: 45,
                            height: 45,
                          ),
                        ),
                        Image.asset(
                          'assets/marker/마커_은.png',
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 60,
                  child: InkWell(
                    onTap: () {
                      showPopup(context, topThreePersons[0]);
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          top: 24,
                          left: 28,
                          child: Image.asset(
                            'assets/marker/' + topThreePersons[0].profileImage,
                            width: 45,
                            height: 45,
                          ),
                        ),
                        Image.asset(
                          'assets/marker/마커_금.png',
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 80,
                  child: InkWell(
                    onTap: () {
                      showPopup(context, topThreePersons[2]);
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          top: 24,
                          left: 28,
                          child: Image.asset(
                            'assets/marker/' + topThreePersons[2].profileImage,
                            width: 45,
                            height: 45,
                          ),
                        ),
                        Image.asset(
                          'assets/marker/마커_동.png',
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(31, 82, 78, 78),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/11');
                },
                icon: Icon(Icons.timer, size: 35.0),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/10');
                },
                icon: Icon(Icons.timer_10, size: 35.0),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/2');
                },
                icon: Icon(Icons.fitness_center, size: 35.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
