// lib/exercise_options_page.dart

import 'package:flutter/material.dart';

class ExerciseOptionsPage extends StatelessWidget {
  // A propriedade 'bodyPart' armazena a escolha da tela anterior
  final String bodyPart; 

  const ExerciseOptionsPage({super.key, required this.bodyPart});

  // Função que retorna a lista de exercícios com base na parte do corpo
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

  @override
  Widget build(BuildContext context) {
    final exercises = _getExercises(bodyPart);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercícios: $bodyPart', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black87,
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            color: Colors.grey[900], // Fundo escuro
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.fitness_center, color: Color(0xFFC7A868)), // Ícone dourado
              title: Text(
                exercise,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              trailing: const Icon(Icons.add_circle_outline, color: Colors.white70),
              onTap: () {
                // Aqui você pode adicionar a lógica para ADICIONAR este exercício ao treino do dia
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$exercise adicionado ao seu treino!', style: const TextStyle(color: Colors.black)),
                    backgroundColor: const Color(0xFFC7A868),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}