import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _chatInputController = TextEditingController();

  @override
  void dispose() {
    _chatInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Bro AI'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            const Expanded(
              child: Center(
                child: Text(
                  'Converse com o Gym Bro para dicas de treino e nutrição!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
        
            
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900], 
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _chatInputController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Converse com o Gym Bro...',
                  hintStyle: TextStyle(color: Colors.grey[600]), 
                  border: InputBorder.none, 
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFFC7A868)),
                    onPressed: () {
                      if (_chatInputController.text.isNotEmpty) {

                        debugPrint('Mensagem para Gym Bro: ${_chatInputController.text}');
                        _chatInputController.clear(); 
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}