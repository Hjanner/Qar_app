class User {
  final String id;
  final String username;
  final String password;
  final String role; // 'admin' o 'vigilante'

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
  });
}