// lib/exercise_options_page.dart

import 'package:flutter/material.dart';

class ExerciseOptionsPage extends StatelessWidget {
  final String bodyPart;

  const ExerciseOptionsPage({super.key, required this.bodyPart});

  // Função que retorna a lista de exercícios com base na parte do corpo (mantida)
  List<String> _getExercises(String part) {
    switch (part) {
      case 'Superiores':
        return [
          'Supino Reto',
          'Remada Curvada',
          'Desenvolvimento Militar',
          'Elevação Lateral',
          'Tríceps Corda',
          'Rosca Direta',
        ];
      case 'Inferiores':
        return [
          'Agachamento Livre',
          'Leg Press',
          'Cadeira Extensora',
          'Mesa Flexora',
          'Panturrilha',
        ];
      case 'Cardio':
        return [
          'Corrida 30 min',
          'Elíptico 20 min',
          'Remo 15 min',
          'Pular Corda',
        ];
      case 'Abdômen':
        return ['Prancha 3 séries', 'Abdominal na Polia', 'Elevação de Pernas'];
      default:
        return ['Nenhum exercício encontrado.'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercises = _getExercises(bodyPart);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercícios: $bodyPart',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black87,
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(
                Icons.fitness_center,
                color: Color(0xFFC7A868),
              ),
              title: Text(
                exercise,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              trailing: const Icon(
                Icons.add_circle_outline,
                color: Colors.white70,
              ),
              onTap: () {
                // Ao tocar, chamamos a função para abrir o pop-up de seleção de S/R
                _showSetRepSelection(context, exercise);
              },
            ),
          );
        },
      ),
    );
  }

  // --- FUNÇÃO PARA MOSTRAR O POP-UP DE SÉRIES/REPETIÇÕES ---
  void _showSetRepSelection(BuildContext context, String exercise) {
    // Usamos um widget temporário para gerenciar o estado dos contadores no pop-up
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SetRepSelectionDialog(exercise: exercise);
      },
    );
  }
}

// =======================================================================
// === NOVO WIDGET PARA O POP-UP INTERATIVO (STATEFUL) ====================
// =======================================================================

class SetRepSelectionDialog extends StatefulWidget {
  final String exercise;
  const SetRepSelectionDialog({super.key, required this.exercise});

  @override
  State<SetRepSelectionDialog> createState() => _SetRepSelectionDialogState();
}

class _SetRepSelectionDialogState extends State<SetRepSelectionDialog> {
  // Valores iniciais (default)
  int _series = 3;
  int _repetitions = 10;

  // Limites
  static const int maxSeries = 5;
  static const int maxRepetitions = 30;
  static const int minSeries = 1;
  static const int minRepetitions = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      title: Text(
        'Adicionar ${widget.exercise}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // --- Seleção de Séries ---
          _buildCounterRow(
            label: 'Séries (Máx: $maxSeries)',
            value: _series,
            onDecrement: () {
              if (_series > minSeries) {
                setState(() => _series--);
              }
            },
            onIncrement: () {
              if (_series < maxSeries) {
                setState(() => _series++);
              }
            },
          ),
          const SizedBox(height: 20),

          // --- Seleção de Repetições ---
          _buildCounterRow(
            label: 'Repetições (Máx: $maxRepetitions)',
            value: _repetitions,
            onDecrement: () {
              if (_repetitions > minRepetitions) {
                setState(() => _repetitions--);
              }
            },
            onIncrement: () {
              if (_repetitions < maxRepetitions) {
                setState(() => _repetitions++);
              }
            },
          ),
        ],
      ),
      actions: <Widget>[
        // Botão Cancelar
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
        ),
        // Botão Adicionar
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC7A868),
          ),
          onPressed: () {
            // Lógica para ADICIONAR o exercício com S/R ao treino
            Navigator.of(context).pop(); // Fecha o pop-up
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${widget.exercise} adicionado: $_series Séries de $_repetitions Reps!',
                  style: const TextStyle(color: Colors.black),
                ),
                backgroundColor: const Color(0xFFC7A868),
                duration: const Duration(seconds: 3),
              ),
            );
          },
          child: const Text('Adicionar', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  // Widget Auxiliar para os contadores (+ / -)
  Widget _buildCounterRow({
    required String label,
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // CORREÇÃO AQUI: Envolver a label em Expanded
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),

        Row(
          mainAxisSize:
              MainAxisSize.min, // Garante que esta Row só ocupe o mínimo
          children: [
            // Botão de Decrementar
            _buildControlButton(Icons.remove, onDecrement),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '$value',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Botão de Incrementar
            _buildControlButton(Icons.add, onIncrement),
          ],
        ),
      ],
    );
  }

  // Widget Auxiliar para os botões de controle (+ / -)
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
