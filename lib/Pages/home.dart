// lib/home_page.dart (ou o nome do seu arquivo)

import 'package:flutter/material.dart';
import 'profile_page.dart'; // Importe a página de perfil
// CORREÇÃO AQUI: Importe a página de seleção de treino
import 'training_selection_page.dart'; 


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _chatInputController = TextEditingController();

  @override
  void dispose() {
    _chatInputController.dispose();
    super.dispose();
  }

  // Widget auxiliar para criar os placeholders dos gráficos (mantido)
  Widget _buildGraphPlaceholder(String title, String value1, String value2) {
    // ... (Mantido o código do placeholder)
    return Container(
      width: 100, // Largura fixa para o placeholder do gráfico
      height: 100, // Altura fixa para o placeholder do gráfico
      decoration: BoxDecoration(
        color: Colors.grey[200], // Cor de fundo do gráfico
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Apenas um texto para simular o gráfico por enquanto
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              const Icon(
                Icons.show_chart,
                size: 30,
                color: Colors.red,
              ), // Ícone para simular gráfico
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value1,
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  const Text(
                    ' -> ',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                  Text(
                    value2,
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          // Se quiser, você pode substituir isso por um gráfico real usando pacotes como 'fl_chart'
          // Ex: Image.asset('assets/graph_placeholder.png', fit: BoxFit.cover),
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
              // ... (Área do GYMLION e Perfil - sem alterações)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'GYMLION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Text(
                          'Mario',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(width: 8),
                        // Logo do leão como placeholder para a foto do usuário
                        Image.asset(
                          'assets/logo-leao.jpg', // Verifique se o caminho está correto
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // ... (Card de Desempenho - sem alterações)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFC7A868), // Cor dourada
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Desempenho',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Gráfico de Peso (placeholder)
                        _buildGraphPlaceholder('Peso', '73', '74'),
                        // Gráfico de Gordura (placeholder)
                        _buildGraphPlaceholder('Gordura', '20', '18'),
                        // Mais um gráfico (placeholder)
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
                    // CORREÇÃO AQUI: Navega para a tela de seleção de treino
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrainingSelectionPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC7A868),
                    minimumSize: const Size(200, 60), // Tamanho um pouco maior
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    'Treinar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // ... (Área do Chatbot "Gym Bro" - sem alterações)
              const Text(
                'Gym Bro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900], // Fundo mais escuro para o input
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: _chatInputController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Converse com o Gym Bro...',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: InputBorder.none, // Remove a borda padrão
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFFC7A868)),
                      onPressed: () {
                        // Lógica para enviar a mensagem para o chatbot
                        if (_chatInputController.text.isNotEmpty) {
                          print(
                            'Mensagem para Gym Bro: ${_chatInputController.text}',
                          );
                          _chatInputController
                              .clear(); // Limpa o campo após enviar
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}