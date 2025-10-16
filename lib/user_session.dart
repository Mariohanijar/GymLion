import 'dart:convert'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserSession {
  final int id;
  final String username;
  final String email;
  final String name;
  final String phone;
  final double height;
  final double weight;
  final DateTime birthday;

  UserSession({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.phone,
    required this.height,
    required this.weight,
    required this.birthday,
  });

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      height: json['height'] is int ? (json['height'] as int).toDouble() : json['height'] as double,
      weight: json['weight'] is int ? (json['weight'] as int).toDouble() : json['weight'] as double,
      birthday: DateTime.parse(json['birthday'] as String),
    );
  }

//cache
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'name': name,
        'phone': phone,
        'height': height,
        'weight': weight,
   
        'birthday': birthday.toIso8601String().split('T')[0], 
      };

  int get age {
    final now = DateTime.now();
    int age = now.year - birthday.year;
    if (now.month < birthday.month || (now.month == birthday.month && now.day < birthday.day)) {
      age--;
    }
    return age;
  }
}

const String _sessionKey = 'user_session_data';
class SessionManager {
  static UserSession? currentUser;


  static Future<void> saveSession(UserSession user) async {
    final prefs = await SharedPreferences.getInstance();
    final userMap = user.toJson();
    final jsonString = jsonEncode(userMap);
    await prefs.setString(_sessionKey, jsonString);
    currentUser = user; 
  }


  static Future<bool> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    
 
    final jsonString = prefs.getString(_sessionKey);

    if (jsonString == null || jsonString.isEmpty) {
      currentUser = null;
      return false; 
    }

    try {

      final userMap = jsonDecode(jsonString) as Map<String, dynamic>;
      currentUser = UserSession.fromJson(userMap);
      return true; 
    } catch (e) {

      print('Erro ao carregar a sessão do cache: $e');
      await prefs.remove(_sessionKey);
      currentUser = null;
      return false;
    }
  }
  static Future<void> destroySession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
    currentUser = null;
  }
}