// lib/pages/training_selection_page.dart

import 'package:flutter/material.dart';
import 'exercise_options_page.dart'; 

class TrainingSelectionPage extends StatelessWidget {
  const TrainingSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('O que deseja treinar hoje?', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTrainingOption(context, 'Superiores'),
          _buildTrainingOption(context, 'Inferiores'),
          _buildTrainingOption(context, 'Cardio'),
          _buildTrainingOption(context, 'Abdômen'),
        ],
      ),
    );
  }

  Widget _buildTrainingOption(BuildContext context, String bodyPart) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC7A868), 
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 70), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseOptionsPage(bodyPart: bodyPart),
            ),
          );
        },
        child: Text(bodyPart),
      ),
    );
  }
}