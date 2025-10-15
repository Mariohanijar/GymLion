import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// ==========================================================
// 1. MODELO DE DADOS
// ==========================================================

// Modelo simples para armazenar mensagens
class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _chatInputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [];
  late final GenerativeModel _model;
  bool _isAILoading = false;

  // Instrução do sistema (personalidade do coach)
  final String _systemInstruction = """
Você é um coach de treino e nutrição chamado GymBro.
Seu objetivo é ajudar o usuário a montar planos de treino e alimentação.
Fale sempre de forma motivadora, direta e com linguagem simples.
Não responda perguntas fora do tema de saúde, treino e nutrição.
Se o usuário perguntar algo fora do tema, diga:
'Posso te ajudar com treinos ou dieta, quer falar sobre isso?'
""";

  @override
  void initState() {
    super.initState();

    // Inicialização do modelo Gemini
    final apiKey = dotenv.env['GOOGLE_API_KEY']!;
    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);

    // Mensagem inicial
    _messages.add(
      ChatMessage(
        text:
            "Olá! Eu sou o GymBro, seu coach de treino e nutrição. Pronto para montar um plano ou revisar sua dieta hoje?",
        isUser: false,
      ),
    );
  }

  @override
  void dispose() {
    _chatInputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ==========================================================
  // 2. ENVIO DE MENSAGEM PARA A IA
  // ==========================================================
  void _sendMessage() async {
    final text = _chatInputController.text.trim();
    if (text.isEmpty || _isAILoading) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _chatInputController.clear();
      _isAILoading = true;
    });

    _scrollToEnd();

    try {
      // Envia a system instruction + conversa do usuário
      final promptContent = [
        Content.text(_systemInstruction),
        Content.text(text),
      ];

      final response = await _model.generateContent(promptContent);

      final responseText =
          response.text ?? "Desculpe, não consegui gerar uma resposta.";

      setState(() {
        _messages.add(ChatMessage(text: responseText, isUser: false));
        _isAILoading = false;
      });
      _scrollToEnd();
    } catch (e) {
      debugPrint('Erro ao chamar o modelo Gemini: $e');
      setState(() {
        _messages.add(
          ChatMessage(
            text: "Erro ao conectar com a IA. Tente novamente.",
            isUser: false,
          ),
        );
        _isAILoading = false;
      });
      _scrollToEnd();
    }
  }

  // ==========================================================
  // 3. ROLAR PARA O FINAL DA LISTA
  // ==========================================================
  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ==========================================================
  // 4. BALÃO DE MENSAGEM
  // ==========================================================
  Widget _buildMessageBubble(
    ChatMessage message,
    BuildContext context,
    Color primaryColor,
  ) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? primaryColor : Colors.grey[850],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isUser ? 15 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 15),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.black : Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // 5. INTERFACE DO CHATBOT
  // ==========================================================
  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFFC7A868);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('GymBro - Seu Coach de Treino 💪'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message, context, primaryColor);
              },
            ),
          ),

          // Indicador de digitação
          if (_isAILoading)
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFFC7A868),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'GymBro está digitando...',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

          // Campo de input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatInputController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Fale com o GymBro...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 12.0,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFFC7A868)),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
