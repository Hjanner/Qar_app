import 'package:flutter/material.dart';
import '/models/user_model.dart';

class HomeButton extends StatelessWidget {
  final User user; // Requiere un objeto User
  final Color color;

  const HomeButton({
    super.key,
    required this.user,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navega a HomeScreen y pasa el objeto User
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
          arguments: user, // Pasa el objeto User como argumento
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home_outlined, size: 20),
          const SizedBox(width: 8),
          const Text(
            'Ir a Inicio',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}