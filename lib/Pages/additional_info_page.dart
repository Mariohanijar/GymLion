import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; 

import 'login_page.dart'; 

class AdditionalInfoPage extends StatefulWidget {
  final Map<String, dynamic> page1Data;

  const AdditionalInfoPage({super.key, required this.page1Data});

  @override
  State<AdditionalInfoPage> createState() => _AdditionalInfoPageState();
}

class _AdditionalInfoPageState extends State<AdditionalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  
  bool _loading = false;
  String? _error;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)), 
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFC7A868), 
              onPrimary: Colors.black,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.black,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _birthdayController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _loading = true;
      _error = null;
    });
    final completeData = {
      ...widget.page1Data, // Dados do primeiro passo
      'height': double.tryParse(_heightController.text) ?? 0.0,
      'weight': double.tryParse(_weightController.text) ?? 0.0,
      'birthday': _birthdayController.text,
    };
    

    final url = Uri.parse('http://10.0.2.2:5268/api/users/register'); 

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(completeData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro concluído com sucesso!')),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()), 
          (Route<dynamic> route) => false,
        );
      } else {
        final errorBody = jsonDecode(response.body);
        setState(() {
          _error = errorBody['message'] ?? 'Falha no registro. Verifique seus dados.';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Erro de conexão com o servidor. Tente novamente.';
      });
    } finally {
      setState(() {
        _loading = false;
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
                  'Dados Físicos',
                  style: TextStyle(
                    color: Color(0xFFC7A868),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(_heightController, 'Altura (cm)', keyboardType: TextInputType.number, validator: _validateNumeric),
                const SizedBox(height: 20),
                _buildTextField(_weightController, 'Peso (kg)', keyboardType: TextInputType.number, validator: _validateNumeric),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: _buildTextField(
                      _birthdayController, 
                      'Data de Nascimento', 
                      validator: (value) => (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
                      suffixIcon: const Icon(Icons.calendar_today, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(_error!, style: const TextStyle(color: Colors.red)),
                  ),

                ElevatedButton(
                  onPressed: _loading ? null : _registerUser,
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
                          'Concluir Cadastro',
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

  String? _validateNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (double.tryParse(value) == null) {
      return 'Deve ser um número válido';
    }
    return null;
  }

  Widget _buildTextField(
    TextEditingController controller, 
    String label, 
    {bool obscureText = false, 
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? suffixIcon}
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
        suffixIcon: suffixIcon,
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