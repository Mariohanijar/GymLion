import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Chave global para o formulário, útil para validação
  final _formKey = GlobalKey<FormState>();

  // Controladores para pegar os valores dos campos
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Variável para o valor selecionado no gênero
  String? _selectedGender;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Se o formulário for válido, você pode pegar os dados e fazer algo com eles.
      String username = _usernameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String gender = _selectedGender ?? 'Não informado';
      String height = _heightController.text;
      String weight = _weightController.text;

      // Por enquanto, apenas imprima os dados no console
      print('Dados do Cadastro:');
      print('Nome de Usuário: $username');
      print('Email: $email');
      print('Senha: $password');
      print('Gênero: $gender');
      print('Altura: $height cm');
      print('Peso: $weight kg');

      // Aqui você poderia, por exemplo, enviar os dados para um backend
      // e depois navegar para a próxima página.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar Conta',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white), // Cor da seta de voltar
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Crie sua conta',
                  style: TextStyle(
                    color: Color(0xFFC7A868),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Campo Nome do Usuário
                _buildTextField(
                  controller: _usernameController,
                  label: 'Nome de Usuário',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome de usuário.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo Email
                _buildTextField(
                  controller: _emailController,
                  label: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Por favor, insira um e-mail válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo Senha
                _buildTextField(
                  controller: _passwordController,
                  label: 'Senha',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo Gênero (Dropdown)
                _buildGenderDropdown(),
                const SizedBox(height: 20),

                // Campo Altura
                _buildTextField(
                  controller: _heightController,
                  label: 'Altura (cm)',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Por favor, insira uma altura válida.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo Peso
                _buildTextField(
                  controller: _weightController,
                  label: 'Peso (kg)',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Por favor, insira um peso válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Botão de Cadastrar
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC7A868),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget utilitário para criar os campos de texto com o mesmo estilo
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFC7A868)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFC7A868)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFC7A868)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
    );
  }

  // Widget utilitário para criar o campo de Gênero
  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Gênero',
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFC7A868)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFC7A868)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFC7A868)),
        ),
      ),
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white),
      value: _selectedGender,
      items: const [
        DropdownMenuItem(
          value: 'Masculino',
          child: Text('Masculino'),
        ),
        DropdownMenuItem(
          value: 'Feminino',
          child: Text('Feminino'),
        ),
        DropdownMenuItem(
          value: 'Não Binário',
          child: Text('Não Binário'),
        ),
        DropdownMenuItem(
          value: 'Outro',
          child: Text('Outro'),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Por favor, selecione seu gênero.';
        }
        return null;
      },
    );
  }
}