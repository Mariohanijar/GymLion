import 'package:flutter/material.dart';
import 'package:gym/user_session.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget _buildDataRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.grey, height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = SessionManager.currentUser;
    final idDisplay = currentUser?.id.toString() ?? 'ID indisponível';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu Perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Dados',
                  style: TextStyle(
                    color: Color(0xFFC7A868),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              

              
              _buildDataRow(
                label: 'ID de Usuário',
                value: idDisplay,
              ),

              _buildDataRow(
                label: 'Username',
                value: currentUser?.username ?? 'Não disponível',
              ),
              
              _buildDataRow(
                label: 'Nome',
                value: currentUser?.name ?? 'Não disponível',
              ),
              
              
              const SizedBox(height: 40),
              

              Center(
                child: ElevatedButton(
                  onPressed: () {

                    Navigator.of(context).pop(); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Voltar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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