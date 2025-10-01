
class UserSession {
  final int id;
  final String username;
  final String email;

  UserSession({
    required this.id,
    required this.username,
    required this.email,
  });

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class SessionManager {
  static UserSession? currentUser;
}
