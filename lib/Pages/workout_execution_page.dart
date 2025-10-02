import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'training_manager.dart';
import 'main_nav_page.dart';

class WorkoutExecutionPage extends StatefulWidget {
  final String bodyPart;
  final List<WorkoutExercise> exercises;

  const WorkoutExecutionPage({
    super.key,
    required this.bodyPart,
    required this.exercises,
  });

  @override
  State<WorkoutExecutionPage> createState() => _WorkoutExecutionPageState();
}

class _WorkoutExecutionPageState extends State<WorkoutExecutionPage> {
  int _currentExerciseIndex = 0;

  void _moveToNextExercise() {
    setState(() {
      if (_currentExerciseIndex < widget.exercises.length - 1) {
        _currentExerciseIndex++;
      } else {
        _finishWorkout();
      }
    });
  }

  void _finishWorkout() {
    final manager = Provider.of<TrainingManager>(context, listen: false);

    manager.saveWorkout(widget.bodyPart, widget.exercises);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Treino de ${widget.bodyPart} concluído e salvo!',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFC7A868),
        duration: const Duration(seconds: 3),
      ),
    );


    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainNavPage()),
      (Route<dynamic> route) =>
          route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.exercises.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Nenhum exercício para este treino.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final currentExercise = widget.exercises[_currentExerciseIndex];
    final progress = '${_currentExerciseIndex + 1}/${widget.exercises.length}';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Treino de ${widget.bodyPart} ($progress)',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentExercise.name,
              style: const TextStyle(
                color: Color(0xFFC7A868),
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${currentExercise.setsReps.series} Séries de ${currentExercise.setsReps.repetitions} Repetições',
              style: const TextStyle(color: Colors.white70, fontSize: 20),
            ),
            const SizedBox(height: 40),

            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'A Fazer: ${currentExercise.setsReps.series} Séries',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _moveToNextExercise,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _currentExerciseIndex < widget.exercises.length - 1
                      ? const Color(0xFFC7A868)
                      : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  _currentExerciseIndex < widget.exercises.length - 1
                      ? 'Terminar Exercício e PRÓXIMO'
                      : 'FINALIZAR TREINO',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
