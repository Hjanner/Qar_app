import 'package:flutter/material.dart';
import 'package:qar/models/user_model.dart';
import 'package:qar/screens/edit_user_screen.dart';
import 'package:qar/services/auth_service.dart';

class ListUsersScreen extends StatefulWidget {
  final User currentUser;

  const ListUsersScreen({super.key, required this.currentUser});

  @override
  _ListUsersScreenState createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  List<User> users = [];
  List<User> filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();
  final Map<String, bool> _showPasswordMap = {}; // Para controlar la visibilidad de la contraseña

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final loadedUsers = await AuthService.getUsers();
    setState(() {
      users = loadedUsers;
      filteredUsers = loadedUsers;
      // Inicializar el mapa de visibilidad de contraseña
      for (var user in loadedUsers) {
        _showPasswordMap[user.username] = false;
      }
    });
  }

  void _filterUsers(String query) {
    setState(() {
      filteredUsers = users.where((user) {
        final username = user.username.toLowerCase();
        final role = user.role.toLowerCase();
        final searchLower = query.toLowerCase();

        return username.contains(searchLower) || role.contains(searchLower);
      }).toList();
    });
  }

  void _togglePasswordVisibility(String username) {
    setState(() {
      _showPasswordMap[username] = !_showPasswordMap[username]!;
    });
  }

  Future<void> _deleteUser(User user) async {
    final users = await AuthService.getUsers();
    users.removeWhere((u) => u.username == user.username);
    await AuthService.saveUsers(users);

    setState(() {
      this.users = users;
      filteredUsers = users;
    });
  }

  Future<void> _showDeleteConfirmationDialog(User user) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Usuario'),
          content: Text(
              '¿Estás seguro de que deseas eliminar al usuario ${user.username}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.blue.shade700),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cerrar el diálogo
                await _deleteUser(user); // Eliminar el usuario
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Usuario eliminado: ${user.username}'),
                    backgroundColor: Colors.green.shade700,
                  ),
                );
              },
              child: Text(
                'Eliminar',
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),
          ],
          backgroundColor: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade100,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar personalizado
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue[700]),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Usuarios Registrados',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              // Barra de búsqueda
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar por nombre o rol...',
                      prefixIcon: Icon(Icons.search, color: Colors.blue.shade700),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue.shade50)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue.shade700, width: 2)),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16),
                    ),
                    onChanged: _filterUsers,
                  ),
                ),
              ),

              // Lista de usuarios
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    final showPassword = _showPasswordMap[user.username] ?? false;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                      title: Text(
                        user.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rol: ${user.role}'),
                          if (showPassword) Text('Contraseña: ${user.password}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              showPassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.blue.shade700),
                            onPressed: () => _togglePasswordVisibility(user.username),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue.shade700),
                            onPressed: () {
                              // Navegar a la pantalla de edición
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditUserScreen(user: user),
                                ),
                              ).then((_) => _loadUsers()); // Recargar la lista después de editar
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red.shade700),
                            onPressed: () async {
                              await _showDeleteConfirmationDialog(user);
                            },
                          ),
                        ],
                      ),
                    ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}