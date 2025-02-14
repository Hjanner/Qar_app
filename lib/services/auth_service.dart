import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _userListKey = 'userList';

  // Registrar un nuevo usuario
  static Future<void> registerUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userList = await getUsers();
    userList.add(user);
    final userListString = userList.map((u) => jsonEncode(u.toMap())).toList();
    await prefs.setStringList(_userListKey, userListString);
  }

  // Obtener la lista de usuarios registrados
  static Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final userList = prefs.getStringList(_userListKey) ?? [];
    return userList.map((mapString) {
      final map = jsonDecode(mapString);
      return User.fromMap(map);
    }).toList();
  }

  // Iniciar sesión
  static Future<User?> login(String username, String password) async {
    final users = await getUsers();
    return users.firstWhere(
      (user) => user.username == username && user.password == password,
      orElse: () => User(username: '', password: '', role: ''), // Usuario vacío si no se encuentra
    );
  }

  // Cargar datos iniciales (usuarios predeterminados)
  static Future<void> loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    final userList = prefs.getStringList(_userListKey);

    if (userList == null || userList.isEmpty) {
      // Si no hay usuarios, creamos algunos predeterminados
      final defaultUsers = [
        User(username: 'admin', password: 'admin123', role: 'admin'),
        User(username: 'vigilante', password: 'vigilante123', role: 'vigilante'),
      ];
      await registerUser(defaultUsers[0]);
      await registerUser(defaultUsers[1]);
    }
  }
}