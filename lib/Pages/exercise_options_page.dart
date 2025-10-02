import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'training_manager.dart';
import 'workout_execution_page.dart'; 

class ExerciseOptionsPage extends StatefulWidget {
  final String bodyPart; 
  const ExerciseOptionsPage({super.key, required this.bodyPart});

  @override
  State<ExerciseOptionsPage> createState() => _ExerciseOptionsPageState();
}

class _ExerciseOptionsPageState extends State<ExerciseOptionsPage> {
  final List<WorkoutExercise> _selectedExercises = [];

  List<String> _getExercises(String part) {
    switch (part) {
      case 'Superiores':
        return ['Supino Reto', 'Remada Curvada', 'Desenvolvimento Militar', 'Elevação Lateral', 'Tríceps Corda', 'Rosca Direta'];
      case 'Inferiores':
        return ['Agachamento Livre', 'Leg Press', 'Cadeira Extensora', 'Mesa Flexora', 'Panturrilha'];
      case 'Cardio':
        return ['Corrida 30 min', 'Elíptico 20 min', 'Remo 15 min', 'Pular Corda'];
      case 'Abdômen':
        return ['Prancha 3 séries', 'Abdominal na Polia', 'Elevação de Pernas'];
      default:
        return ['Nenhum exercício encontrado.'];
    }
  }

  void _addExerciseToPlan(String exerciseName, int series, int reps) {
    final newSet = ExerciseSet(series: series, repetitions: reps);
    final newExercise = WorkoutExercise(name: exerciseName, setsReps: newSet);
    
    setState(() {
      _selectedExercises.add(newExercise);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$exerciseName adicionado: $series Séries de $reps Reps! (${_selectedExercises.length} no total)',
          style: const TextStyle(color: Colors.black)
        ),
        backgroundColor: const Color(0xFFC7A868),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _startWorkout() {
    if (_selectedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adicione pelo menos um exercício!', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    Provider.of<TrainingManager>(context, listen: false).setWorkoutPlan(
      widget.bodyPart,
      _selectedExercises,
    );
    
  
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutExecutionPage(
          bodyPart: widget.bodyPart,
          exercises: _selectedExercises,
        ),
      ),
    );
  }

  void _showSetRepSelection(BuildContext context, String exercise) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SetRepSelectionDialog(
          exercise: exercise,
          onConfirm: _addExerciseToPlan, 
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercises = _getExercises(widget.bodyPart);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Montar Treino: ${widget.bodyPart}', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.black,
        child: ElevatedButton(
          onPressed: _startWorkout,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC7A868),
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: Text(
            'COMEÇAR TREINO (${_selectedExercises.length} Exercícios)',
            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            color: Colors.grey[900], 
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.fitness_center, color: Color(0xFFC7A868)),
              title: Text(exercise, style: const TextStyle(color: Colors.white, fontSize: 18)),
              trailing: const Icon(Icons.add_circle_outline, color: Colors.white70),
              onTap: () => _showSetRepSelection(context, exercise),
            ),
          );
        },
      ),
    );
  }
}

typedef AddExerciseCallback = void Function(String name, int series, int reps);

class SetRepSelectionDialog extends StatefulWidget {
  final String exercise;
  final AddExerciseCallback onConfirm; 
  
  const SetRepSelectionDialog({super.key, required this.exercise, required this.onConfirm});

  @override
  State<SetRepSelectionDialog> createState() => _SetRepSelectionDialogState();
}

class _SetRepSelectionDialogState extends State<SetRepSelectionDialog> {
  int _series = 3;
  int _repetitions = 10;
  static const int maxSeries = 5;
  static const int maxRepetitions = 30;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      title: Text('Adicionar ${widget.exercise}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildCounterRow(
            label: 'Séries (Máx: $maxSeries)',
            value: _series,
            onDecrement: () { if (_series > 1) setState(() => _series--); },
            onIncrement: () { if (_series < maxSeries) setState(() => _series++); },
          ),
          const SizedBox(height: 20),

          _buildCounterRow(
            label: 'Repetições (Máx: $maxRepetitions)',
            value: _repetitions,
            onDecrement: () { if (_repetitions > 1) setState(() => _repetitions--); },
            onIncrement: () { if (_repetitions < maxRepetitions) setState(() => _repetitions++); },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC7A868)),
          onPressed: () {
            widget.onConfirm(widget.exercise, _series, _repetitions);
            Navigator.of(context).pop(); 
          },
          child: const Text('Adicionar', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _buildCounterRow({required String label, required int value, required VoidCallback onDecrement, required VoidCallback onIncrement}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildControlButton(Icons.remove, onDecrement),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text('$value', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            _buildControlButton(Icons.add, onIncrement),
          ],
        ),
      ],
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFC7A868).withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }
}