import 'package:flutter/material.dart';
import 'package:gym/user_session.dart';
import 'package:intl/intl.dart'; 

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

    // Lógica para obter e formatar os dados
    final idDisplay = currentUser?.id.toString() ?? 'ID indisponível';
    final birthdayDisplay = currentUser != null
        // ✅ FORMATANDO DATA: Usando DateFormat para exibir a data no formato BR (dd/MM/yyyy)
        ? DateFormat('dd/MM/yyyy').format(currentUser.birthday)
        : 'Não disponível';

    final heightDisplay = currentUser != null
        ? '${(currentUser.height/100).toStringAsFixed(2)} m'
        : 'Não disponível';

    final weightDisplay = currentUser != null
        ? '${currentUser.weight.toStringAsFixed(1)} kg'
        : 'Não disponível';


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

              // ✅ DADOS DE IDENTIFICAÇÃO BÁSICOS
              _buildDataRow(
                label: 'Nome Completo',
                value: currentUser?.name ?? 'Não disponível',
              ),
              _buildDataRow(
                label: 'Username',
                value: currentUser?.username ?? 'Não disponível',
              ),
              _buildDataRow(
                label: 'E-mail',
                value: currentUser?.email ?? 'Não disponível',
              ),
              _buildDataRow(
                label: 'Telefone',
                value: currentUser?.phone ?? 'Não disponível',
              ),

              const SizedBox(height: 30),
              
              _buildDataRow(
                label: 'Data de Nascimento',
                value: birthdayDisplay,
              ),
              _buildDataRow(
                label: 'Altura',
                value: heightDisplay,
              ),
              _buildDataRow(
                label: 'Peso Atual',
                value: weightDisplay,
              ),
              
              const SizedBox(height: 40),

            ],
          ),
        ),
      ),
    );
  }
}