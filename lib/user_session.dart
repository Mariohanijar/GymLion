
class UserSession {
  final int id;
  final String username;
  final String email;
  final String name;

  UserSession({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
  });

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      name:json['name'],
    );
  }
}

class SessionManager {
  static UserSession? currentUser;
}
