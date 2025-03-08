import 'package:flutter/material.dart';

class AppButtonStyles {
  // Estilo para botones con fondo blanco y borde azul
  static final whiteWithBlueBorder = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.blue.shade700,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: BorderSide(color: Colors.blue.shade700),
    ),
    elevation: 4,
  );

  // Estilo para botones con fondo azul y texto blanco
  static final blueWithWhiteText = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue.shade700,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 4,
  );

}