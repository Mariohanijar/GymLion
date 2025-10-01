// lib/pages/main_nav_page.dart

import 'package:flutter/material.dart';
import 'home.dart';           // Aba 0: Home/Geral
import 'training_selection_page.dart'; // Aba 1: Criar/Montar Novo Treino
import 'my_workouts_page.dart';    // Aba 2: Treinos Salvos (Meus Treinos)
import 'performance_page.dart';    // Aba 3: Desempenho/Dashboard
import 'chatbot_page.dart';        // Aba 4: IA/Chatbot

class MainNavPage extends StatefulWidget {
  const MainNavPage({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _selectedIndex = 0; // Índice inicial (Home)

  // Lista de todas as telas que o rodapé irá exibir
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),             
    TrainingSelectionPage(),
    MyWorkoutsPage(),       
    PerformancePage(),      
    ChatbotPage(),          
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Exibe a tela selecionada no body
      body: _widgetOptions.elementAt(_selectedIndex),

      // O Rodapé de Navegação (BottomNavigationBar)
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Criar Treino',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Meus Treinos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'IA Gym Bro',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed, // Garante que todos os 5 itens caibam
        selectedItemColor: Theme.of(context).primaryColor, // Usa o dourado do tema
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.black, // Fundo do rodapé preto
        onTap: _onItemTapped,
      ),
    );
  }
}