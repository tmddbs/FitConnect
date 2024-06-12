import 'package:flutter/material.dart';

class Exercise {
  String name;
  String muscleGroup;
  String equipment;
  bool completed; // 운동 완료 여부
  List<ExerciseSet> sets; // 세트 정보를 저장하는 리스트

  Exercise({
    required this.name,
    required this.muscleGroup,
    required this.equipment,
    this.completed = false,
    List<ExerciseSet>? sets, // 세트 정보 초기화를 위한 선택적 파라미터
  }) : sets = sets ?? []; // null이면 빈 리스트 할당

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode ^ muscleGroup.hashCode ^ equipment.hashCode;
}

class ExerciseSet {
  int setNumber;
  int kg;
  int reps;
  String target;
  TextEditingController kgController;
  TextEditingController repsController;
  bool completed; // 세트 완료 여부

  ExerciseSet({
    required this.setNumber,
    this.kg = 0,
    this.reps = 0,
    this.target = '-',
    this.completed = false,
  })  : kgController = TextEditingController(),
        repsController = TextEditingController() {
    kgController.text = kg.toString();
    repsController.text = reps.toString();
  }

  @override
  String toString() {
    return 'Set $setNumber: $kg kg x $reps reps, Target: $target';
  }
}
