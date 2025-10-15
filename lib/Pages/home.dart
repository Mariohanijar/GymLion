// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:gym/user_session.dart';
import 'training_selection_page.dart'; 
import 'history_page.dart'; 
import 'profile_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _chatInputController = TextEditingController();

  // Widget auxiliar para criar os placeholders dos gráficos
  Widget _buildGraphPlaceholder(String title, String value1, String value2) {
    return Container(
      width: 100, 
      height: 100, 
      decoration: BoxDecoration(
        color: Colors.grey[200], 
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 4),
              const Icon(Icons.show_chart, size: 30, color: Colors.red), 
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(value1, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                  const Text(' -> ', style: TextStyle(fontSize: 10, color: Colors.black54)),
                  Text(value2, style: const TextStyle(fontSize: 10, color: Colors.black54)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'GYMLION',
                    style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      // BOTÃO HISTÓRICO
                      IconButton(
                        icon: const Icon(Icons.history, color: Colors.white, size: 28),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HistoryPage()),
                          );
                        },
                      ),
                      // PERFIL/EDITAR (AGORA FUNCIONAL)
                      GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    SessionManager.currentUser?.username ?? 'Usuário',
                                    style: const TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  const SizedBox(width: 8),
                                  const CircleAvatar(
                                    backgroundColor: Color(0xFFC7A868),
                                    radius: 15,
                                    child: Icon(Icons.person, size: 20, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),

                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Card de Desempenho
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFC7A868), 
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Desempenho', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildGraphPlaceholder('Peso', '73', '74'),
                        _buildGraphPlaceholder('Gordura', '20', '18'),
                        _buildGraphPlaceholder('Massa', '50', '52'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Botão "Treinar"
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrainingSelectionPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC7A868),
                    minimumSize: const Size(200, 60), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  ),
                  child: const Text('Treinar', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}