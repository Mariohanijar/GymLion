// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/training_manager.dart'; // Importa a nova localização
import 'Pages/login_page.dart'; // Importa a tela inicial

void main() {
  // Configura o TrainingManager no topo da árvore de widgets
  runApp(
    ChangeNotifierProvider(
      create: (context) => TrainingManager(), 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gymlion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFC7A868),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC7A868)),
        useMaterial3: true,
      ),
      // O aplicativo SEMPRE começa na LoginPage
      home: const LoginPage(),
    );
  }
}