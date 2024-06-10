class Exercise {
  String name;
  String muscleGroup;
  String equipment;

  Exercise(
      {required this.name, required this.muscleGroup, required this.equipment});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode ^ muscleGroup.hashCode ^ equipment.hashCode;
}
