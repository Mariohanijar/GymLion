// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importe as classes necessárias
import 'Pages/training_manager.dart'; // Assumindo lib/managers/training_manager.dart
import 'Pages/main_nav_page.dart';
import 'Pages/login_page.dart'; 

// Crie uma cor Material para o dourado principal (Gymlion Color)
const MaterialColor gymlionGold = MaterialColor(
  0xFFC7A868,
  <int, Color>{
    50: Color(0xFFFFFBE6), 
    100: Color(0xFFFFF0B3),
    200: Color(0xFFFFE080),
    300: Color(0xFFFDD04D),
    400: Color(0xFFC7A868), // Cor Principal
    500: Color(0xFFB0945E),
    600: Color(0xFFA18552),
    700: Color(0xFF8F7346),
    800: Color(0xFF7D613A),
    900: Color(0xFF6B4F2E),
  },
);



void main() {
  runApp(
    // Envolve toda a aplicação com o TrainingManager (Provider)
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
      title: 'GYMLION',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define o tema escuro
        brightness: Brightness.dark,
        primarySwatch: gymlionGold,
        primaryColor: const Color(0xFFC7A868),
        scaffoldBackgroundColor: Colors.black, // Fundo preto
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        // Define a cor de acentuação para botões e outros widgets
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC7A868),
          secondary: Color(0xFFC7A868),
          surface: Colors.black,
        ),
        useMaterial3: true,
      ),
      // Mude para LoginPage se quiser exigir login
      // Mude para MainNavPage para ir direto ao menu de abas
      home: const LoginPage(), 
      // home: const LoginPage(), // Se quiser testar o fluxo de login
    );
  }
}