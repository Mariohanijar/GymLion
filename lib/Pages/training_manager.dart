// lib/training_manager.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // Adicionado para usar ChangeNotifier

class ExerciseSet {
  final int series;
  final int repetitions;
  ExerciseSet({required this.series, required this.repetitions});
}

class WorkoutExercise {
  final String name;
  final ExerciseSet setsReps;
  final bool isCustom; 
  
  WorkoutExercise({required this.name, required this.setsReps, this.isCustom = false});
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
  final Map<String, List<WorkoutExercise>> _customExercisesByGroup = {};
  List<WorkoutExercise> _currentWorkoutPlan = [];
  final List<Workout> _history = [];

  List<WorkoutExercise> get currentWorkoutPlan => _currentWorkoutPlan;
  List<Workout> get history => _history.reversed.toList();
  Map<String, List<WorkoutExercise>> get customExercisesByGroup => _customExercisesByGroup;
  
  // ----------------------------------------------------
  // MÉTODO PARA ADICIONAR UM EXERCÍCIO PERSONALIZADO (SIMPLIFICADO)
  // ----------------------------------------------------
  void addCustomExercise({
    required String groupName,
    required String exerciseName,
  }) {
    // Usa uma chave minúscula para consistência
    final key = groupName.trim().toLowerCase(); 
    
    // Cria um exercício com Sets/Reps padrão (ou inicializa como 0/0)
    final newExercise = WorkoutExercise(
      name: exerciseName,
      setsReps: ExerciseSet(series: 3, repetitions: 10), // Valores padrão para novo exercício
      isCustom: true, 
    );

    if (_customExercisesByGroup.containsKey(key)) {
      _customExercisesByGroup[key]!.add(newExercise);
    } else {
      _customExercisesByGroup[key] = [newExercise];
    }
    
    debugPrint('Exercício personalizado adicionado: $exerciseName para $groupName');
    notifyListeners();
    // Nota: O _currentWorkoutPlan não é alterado aqui, 
    // ele será montado na ExerciseOptionsPage usando tanto os exercícios padrões quanto os customizados.
  }
  
  // Mantenha os outros métodos...
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