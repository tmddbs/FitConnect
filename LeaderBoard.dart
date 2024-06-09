import 'package:flutter/material.dart';
import 'Main_01.dart';
import 'Profile_01.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monthly Ranking',
      home: Leader(),
    );
  }
}

class Leader extends StatefulWidget {
  @override
  _LeaderState createState() => _LeaderState();
}

class _LeaderState extends State<Leader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('      Monthly Ranking'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Main_01()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRankingTile(2, '이름', '지역', '----kcal', false, 'assets/ping1.png'),
                  buildRankingTile(1, '이름', '지역', '----kcal', true, 'assets/ping1.png'),
                  buildRankingTile(3, '이름', '지역', '----kcal', false, 'assets/ping1.png'),
                ],
              ),
              SizedBox(height: 20),
              for (int i = 4; i <= 7; i++)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 20,
                    child: Text(
                      '$i',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text('이름'),
                  subtitle: Text('지역'),
                  trailing: Text('${(12000 - i * 1000)}kcal'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRankingTile(int rank, String name, String region, String kcal, bool isMain, String imagePath) {
    return Column(
      children: [
        Text(
          kcal,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            showPopup(context);
          },
          child: Container(
            width: isMain ? 100 : 80,
            height: isMain ? 200 : 180,
            decoration: BoxDecoration(
              color: isMain ? Colors.green : Colors.lightGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imagePath),
                  radius: isMain ? 40 : 35,
                ),
                SizedBox(height: 8),
                Text(
                  '$rank',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  region,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
