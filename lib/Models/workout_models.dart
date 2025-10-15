class WorkoutExercise {
  final int exerciseId;
  final String name;
  final int sets;
  final int reps;
  final double? weight;
  final int restTime; 

  WorkoutExercise({
    required this.exerciseId,
    required this.name,
    required this.sets,
    required this.reps,
    this.weight,
    required this.restTime,
  });

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutExercise(
      exerciseId: json['exerciseId'] as int,
      name: json['name'] as String,
      sets: json['sets'] as int,
      reps: json['reps'] as int,
      weight: (json['weight'] as num?)?.toDouble(),
      restTime: json['restTime'] as int, 
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'sets': sets,
      'reps': reps,
      'weight': weight ?? 0.0, 
      'restTime': restTime, 
    };
  }
}

class Workout {
  final int id;
  final String name;
  final int userId;
  final List<WorkoutExercise> exercises;
  final DateTime date; 

  Workout({
    required this.id,
    required this.name,
    required this.userId,
    required this.exercises,
  }) : date = DateTime.now(); 

  factory Workout.fromJson(Map<String, dynamic> json) {
    var exercisesJson = json['exercises'] as List;
    List<WorkoutExercise> exercisesList = exercisesJson
        .map((e) => WorkoutExercise.fromJson(e))
        .toList();

    return Workout(
      id: json['id'] as int,
      name: json['name'] as String,
      userId: json['userId'] as int,
      exercises: exercisesList,
    );
  }
}