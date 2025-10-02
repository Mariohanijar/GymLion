import 'package:flutter/material.dart';
import 'home.dart'; 
import 'training_selection_page.dart'; 
import 'my_workouts_page.dart'; 
import 'performance_page.dart'; 
import 'chatbot_page.dart';

class MainNavPage extends StatefulWidget {
  const MainNavPage({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _selectedIndex = 0; 


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
      body: _widgetOptions.elementAt(_selectedIndex),


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
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.black,
        iconSize: 30,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),

      
        unselectedLabelStyle: const TextStyle(fontSize: 12),

        onTap: _onItemTapped,
      ),
    );
  }
}
