import 'package:flutter/material.dart';
import 'models/Exercise.dart';

class FinishWorkoutPage extends StatelessWidget {
  final List<Exercise> completedExercises; // 완료된 운동 목록

  FinishWorkoutPage({Key? key, required this.completedExercises})
      : super(key: key);

  void _shareWorkoutHistory(BuildContext context) {
    //!!!!!!여기서 db로 어떻게 데이터 보낼지 정할 수 있어!!!!!!
    // 수치 정리 로직
    List<Map<String, dynamic>> workoutData = [];

    for (var exercise in completedExercises) {
      for (var set in exercise.sets.where((set) => set.completed)) {
        workoutData.add({
          'exercise': exercise.name,
          'set': set.setNumber,
          'kg': set.kg,
          'reps': set.reps,
        });
      }
    }
    // 로그 출력
    for (var data in workoutData) {
      print(
          "Exercise: ${data['exercise']}, Set: ${data['set']}, Kg: ${data['kg']}, Reps: ${data['reps']}");
    }

    // 여기서 DB나 서비스로 데이터 전송 가능
    // Snackbar를 통해 사용자에게 알림
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Workout history shared!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share your Workout History!"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/2'),
            child: Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          _buildHistoryBox(),
        ],
      ),
      bottomNavigationBar: Padding(
        //이 버튼을 클릭하면 데이터가 전송돼
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _shareWorkoutHistory(context),
          child: Text('Share Your Workout History',
              style: TextStyle(fontSize: 20)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryBox() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Program_1',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Fri, June 12, 2024',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time),
                  SizedBox(width: 5),
                  Text('00:00'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.fitness_center),
                  SizedBox(width: 5),
                  Text('0 Kg'),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Exercise', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Set', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Reps', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Kg', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Divider(),
          ...completedExercises.expand((exercise) {
            return [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  exercise.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...exercise.sets.where((set) => set.completed).map((set) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 60),
                      Expanded(
                          child: Text(
                        'Set ${set.setNumber}',
                        textAlign: TextAlign.right,
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          child: Text(
                        '${set.reps} reps',
                        textAlign: TextAlign.right,
                      )),
                      Expanded(
                          child: Text(
                        '${set.kg} kg',
                        textAlign: TextAlign.right, // 오른쪽 정렬
                      )),
                    ],
                  ),
                );
              }).toList(),
              Divider(),
            ];
          }).toList(),
        ],
      ),
    );
  }
}
