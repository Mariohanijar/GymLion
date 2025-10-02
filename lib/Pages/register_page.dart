import 'package:flutter/material.dart';
import 'additional_info_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _loading = false;
  String? _error;

  void _goToNextStep() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _error = null;
      });

      final page1Data = {
        'username': _usernameController.text.trim(),
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text.trim(), 
      };


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdditionalInfoPage(page1Data: page1Data),
        ),
      ).then((_) {
   
        setState(() {
          _loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Novo Usuário', style: TextStyle(color: Color(0xFFC7A868))),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFC7A868)),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dados de Acesso',
                  style: TextStyle(
                    color: Color(0xFFC7A868),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                _buildTextField(_usernameController, 'Nome de Usuário', validator: _validateRequired),
                const SizedBox(height: 20),


                _buildTextField(_nameController, 'Nome Completo', validator: _validateRequired),
                const SizedBox(height: 20),


                _buildTextField(_phoneController, 'Telefone', keyboardType: TextInputType.phone, validator: _validateRequired),
                const SizedBox(height: 20),


                _buildTextField(_emailController, 'E-mail', keyboardType: TextInputType.emailAddress, validator: _validateEmail),
                const SizedBox(height: 20),

                _buildTextField(_passwordController, 'Senha', obscureText: true, validator: _validatePassword),
                const SizedBox(height: 20),

                _buildTextField(_confirmPasswordController, 'Confirmar Senha', obscureText: true, validator: _validateConfirmPassword),
                const SizedBox(height: 40),

                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(_error!, style: const TextStyle(color: Colors.red)),
                  ),

                ElevatedButton(
                  onPressed: _loading ? null : _goToNextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC7A868),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          'Próxima Etapa',
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
  


  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (_validateRequired(value) != null) return 'E-mail é obrigatório';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (_validateRequired(value) != null) return 'Senha é obrigatória';
    if (value!.length < 6) return 'A senha deve ter pelo menos 6 caracteres';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (_validateRequired(value) != null) return 'Confirmação é obrigatória';
    if (value != _passwordController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Widget _buildTextField(
    TextEditingController controller, 
    String label, 
    {bool obscureText = false, 
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator}
  ) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
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
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );
  }
}