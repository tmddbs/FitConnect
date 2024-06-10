import 'package:flutter/material.dart';
import 'package:flutter_mobile_computing/Start_Exercise_Page.dart';
import 'models/Exercise.dart';
import 'models/AllExercises.dart';

class SelectExercisePage extends StatefulWidget {
  @override
  _SelectExercisePageState createState() => _SelectExercisePageState();
}

class _SelectExercisePageState extends State<SelectExercisePage> {
  String? selectedMuscleGroup = "All";
  String? selectedEquipment = "All";
  String searchText = "";
  List<Exercise> selectedExercises = [];

  List<Exercise> filteredExercises = [];

  @override
  void initState() {
    super.initState();
    // 페이지 로드 시 모든 운동을 포함하도록 filteredExercises 초기화
    filteredExercises = allExercises;
  }

  void filterExercises() {
    //카테고리 필터링
    setState(() {
      var lowerCaseSearchText = searchText.toLowerCase();
      filteredExercises = allExercises.where((exercise) {
        bool matchesSearchText =
            exercise.name.toLowerCase().contains(lowerCaseSearchText);
        bool matchesMuscleGroup = selectedMuscleGroup == "All" ||
            exercise.muscleGroup == selectedMuscleGroup;
        bool matchesEquipment = selectedEquipment == "All" ||
            exercise.equipment == selectedEquipment;
        return matchesSearchText && matchesMuscleGroup && matchesEquipment;
      }).toList();
    });
  }

  void toggleSelection(Exercise exercise) {
    setState(() {
      if (selectedExercises.contains(exercise)) {
        selectedExercises.remove(exercise);
      } else {
        selectedExercises.add(exercise);
      }
    });
  }

  void navigateToStartExercisePage(BuildContext context) {
    if (selectedExercises.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  StartExercisePage(selectedExercises: selectedExercises)));
    } else {
      // 사용자에게 운동을 선택하라는 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select at least one exercise.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercises"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
                decoration: InputDecoration(
                  labelText: "Search exercise name",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  searchText = value;
                  filterExercises();
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      border: OutlineInputBorder(),
                      labelText: 'All Muscle Groups',
                    ),
                    value: selectedMuscleGroup ?? "All",
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMuscleGroup = newValue;
                        filterExercises();
                      });
                    },
                    items: <String>[
                      //운동부위 카테고리
                      'All',
                      'Leg',
                      'Chest',
                      'Back',
                      'Shoulder',
                      'Biceps',
                      'Triceps',
                      'Forearms',
                      'Abs'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      border: OutlineInputBorder(),
                      labelText: 'All Equipment Groups',
                    ),
                    value: selectedEquipment ?? "All",
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEquipment = newValue;
                        filterExercises();
                      });
                    },
                    items: <String>[
                      //운동기구 카테고리
                      'All',
                      'Barbell',
                      'Dumbbell',
                      'Machine',
                      'Body Weight',
                      'Smith Machine',
                      'Cable'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text("Recent Exercises",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                Exercise exercise = filteredExercises[index];
                return ListTile(
                  title: Text(exercise.name),
                  subtitle:
                      Text("${exercise.muscleGroup}, ${exercise.equipment}"),
                  trailing: Icon(selectedExercises.contains(exercise)
                      ? Icons.check_circle
                      : Icons.check_circle_outline),
                  tileColor: selectedExercises.contains(exercise)
                      ? Colors.green[200]
                      : null,
                  onTap: () => toggleSelection(exercise),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () => navigateToStartExercisePage(context),
              child: Text("Add Exercise"),
            ),
          ),
        ],
      ),
    );
  }
}
/*
class StartExercisePage extends StatelessWidget {
  final List<Exercise> selectedExercises;

  StartExercisePage({required this.selectedExercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Exercises'),
      ),
      body: ListView.builder(
        itemCount: selectedExercises.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(selectedExercises[index].name),
            subtitle: Text(
                "${selectedExercises[index].muscleGroup}, ${selectedExercises[index].equipment}"),
          );
        },
      ),
    );
  }
}
*/
