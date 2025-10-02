import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'training_manager.dart'; 

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<TrainingManager>(context); 
    final history = manager.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Treinos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: history.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history_toggle_off, color: Colors.white38, size: 60),
                  const SizedBox(height: 10),
                  const Text(
                    'Você ainda não terminou um treino.',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  const Text(
                    'Seu histórico aparecerá aqui!',
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final workout = history[index];
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      workout.name,
                      style: const TextStyle(color: Color(0xFFC7A868), fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Data: ${workout.date.day}/${workout.date.month}/${workout.date.year} | ${workout.exercises.length} Exercícios',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                    onTap: () {
                    },
                  ),
                );
              },
            ),
    );
  }
}