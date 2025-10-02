import 'package:flutter/foundation.dart';

class ExerciseSet {
  final int series;
  final int repetitions;
  ExerciseSet({required this.series, required this.repetitions});
}

class WorkoutExercise {
  final String name;
  final ExerciseSet setsReps;
  
  WorkoutExercise({required this.name, required this.setsReps});
}

class Workout {
  final String name;
  final DateTime date;
  final List<WorkoutExercise> exercises;

  Workout({
    required this.name,
    required this.date,
    required this.exercises,
  });
}



class TrainingManager extends ChangeNotifier {
  List<WorkoutExercise> _currentWorkoutPlan = [];
  final List<Workout> _history = [];


  List<WorkoutExercise> get currentWorkoutPlan => _currentWorkoutPlan;
  List<Workout> get history => _history.reversed.toList();

  void setWorkoutPlan(String bodyPart, List<WorkoutExercise> exercises) {
    _currentWorkoutPlan = exercises;
    debugPrint('Plano de treino atualizado: $bodyPart com ${exercises.length} exercícios.');
    notifyListeners();
  }


  void saveWorkout(String bodyPart, List<WorkoutExercise> executedExercises) {
    if (executedExercises.isEmpty) return;

    final newWorkout = Workout(
      name: 'Treino de $bodyPart',
      date: DateTime.now(),
      exercises: executedExercises,
    );
    _history.add(newWorkout);
    debugPrint('Treino salvo: ${newWorkout.name}');
    notifyListeners();
  }
}