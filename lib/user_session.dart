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

  int get age {
        final now = DateTime.now();
        int age = now.year - birthday.year;
        if (now.month < birthday.month || 
            (now.month == birthday.month && now.day < birthday.day)) {
            age--;
        }
        return age;
    }
}


class SessionManager {
  static UserSession? currentUser;
}