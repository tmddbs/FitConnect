import 'package:flutter/material.dart';
import 'global.dart';

int a = 1000; // 예시로 설정한 내 칼로리, 실제 애플리케이션에서는 사용자의 데이터를 받아올 것

class User {
  int rank;

  final String name;
  final String region;
  final double calories;
  final String imagePath;
  Color tileColor; // 색상 필드를 수정 가능하도록 변경

  User({
    required this.rank,
    required this.name,
    required this.region,
    required this.calories,
    required this.imagePath,
    required this.tileColor,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '월간 랭킹',
      home: Leader(),
    );
  }
}

class Leader extends StatefulWidget {
  @override
  _LeaderState createState() => _LeaderState();
}

class _LeaderState extends State<Leader> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    initializeUsers();
  }

  void initializeUsers() {
    users = [
      User(
          rank: 1,
          name: globalPerson1.name,
          region: globalPerson1.address,
          calories: globalPerson1.todayCalories,
          imagePath: 'assets/marker/' + globalPerson1.profileImage,
          tileColor: Color.fromARGB(255, 149, 229, 138)),
      User(
          rank: 2,
          name: globalPerson2.name,
          region: globalPerson2.address,
          calories: globalPerson2.todayCalories,
          imagePath: 'assets/marker/' + globalPerson2.profileImage,
          tileColor: Color.fromARGB(255, 149, 229, 138)),
      User(
          rank: 3,
          name: globalPerson3.name,
          region: globalPerson3.address,
          calories: globalPerson3.todayCalories,
          imagePath: 'assets/marker/' + globalPerson3.profileImage,
          tileColor: Color.fromARGB(255, 149, 229, 138)),
      User(
          rank: 4,
          name: globalPerson4.name,
          region: globalPerson4.address,
          calories: globalPerson4.todayCalories,
          imagePath: 'assets/marker/' + globalPerson4.profileImage,
          tileColor: Color.fromARGB(255, 149, 229, 138)),
      User(
          rank: 5,
          name: globalPerson5.name,
          region: globalPerson5.address,
          calories: globalPerson5.todayCalories,
          imagePath: 'assets/marker/' + globalPerson5.profileImage,
          tileColor: Color.fromARGB(255, 149, 229, 138)),
      User(
          rank: 6,
          name: globalPerson6.name,
          region: globalPerson6.address,
          calories: globalPerson6.todayCalories,
          imagePath: 'assets/marker/' + globalPerson6.profileImage,
          tileColor: Color.fromARGB(255, 149, 229, 138)),
      User(
          rank: 7,
          name: globalPerson7.name,
          region: globalPerson7.address,
          calories: globalPerson7.todayCalories,
          imagePath: 'assets/marker/' + globalPerson7.profileImage,
          tileColor: Color.fromARGB(255, 149, 229, 138)),
      User(
          rank: 0,
          name: globalMyData.name,
          region: globalMyData.address,
          calories: globalMyData.todayCalories,
          imagePath: 'assets/marker' + globalMyData.profileImage,
          tileColor: Colors.blue[300]!),
    ];
    sortAndUpdateRanking();
  }

  void sortAndUpdateRanking() {
    users.sort((a, b) => b.calories.compareTo(a.calories));
    for (int i = 0; i < users.length; i++) {
      users[i].rank = i + 1;
    }

    // 1, 2, 3등의 타일 색상을 고정
    if (users.isNotEmpty)
      users[0].tileColor =
          users[0].name == '나' ? Colors.blue[300]! : Colors.green[400]!;
    if (users.length > 1)
      users[1].tileColor =
          users[1].name == '나' ? Colors.blue[300]! : Colors.green[400]!;
    if (users.length > 2)
      users[2].tileColor =
          users[2].name == '나' ? Colors.blue[300]! : Colors.green[400]!;

    // 기존의 3등이 4등으로 밀리면서 색상을 흰색으로 변경
    if (users.length > 3)
      users[3].tileColor = Color.fromARGB(255, 149, 229, 138);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 순위', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRankingTile(users[1], size: 'small'),
                  buildRankingTile(users[0], size: 'large'),
                  buildRankingTile(users[2], size: 'small'),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              ...users.sublist(3).map((user) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: user.tileColor,
                      radius: 20,
                      child: Text('${user.rank}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.region),
                    trailing: Text('${user.calories}kcal'),
                    tileColor: user.name == '나'
                        ? Colors.blue[100]
                        : null, // '나' 타일 배경색 변경
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRankingTile(User user, {String size = 'small'}) {
    double width = size == 'large' ? 100 : 100;
    double height = size == 'large' ? 200 : 180;
    double avatarRadius = size == 'large' ? 45 : 35;

    return Column(
      children: [
        Text('${user.calories}kcal',
            style: TextStyle(fontSize: 14, color: Colors.grey)),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: user.tileColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(user.imagePath),
                radius: avatarRadius,
              ),
              SizedBox(height: 8),
              Text(
                '${user.rank}',
                style: TextStyle(
                  fontSize: size == 'large' ? 28 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: size == 'large' ? 18 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                user.region,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
