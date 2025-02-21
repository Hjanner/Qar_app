import 'package:flutter/material.dart';
import 'package:qar/auth/login_screen.dart';
import 'package:qar/models/user_model.dart';
import 'package:qar/services/auth_service.dart';
import 'package:qar/screens/scan_screen.dart';
import 'package:qar/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.loadInitialData(); // Cargar datos iniciales
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qar App',
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.blue,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.blue.shade100, 
          selectionHandleColor: Colors.blue.shade700, // Color del manejador 
          cursorColor: Colors.blue.shade700, // Color del cursor
        ),        
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        //'/scanner': (context) => const QrScannerScreen(),
      },
      // Usa onGenerateRoute para manejar rutas dinámicas
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final user = settings.arguments as User; // Obtén el objeto User
          return MaterialPageRoute(
            builder: (context) => HomeScreen(user: user),
          );
        }
        if (settings.name == '/scanner') {
          final user = settings.arguments as User; // Obtén el objeto User
          return MaterialPageRoute(
            builder: (context) => QrScannerScreen(user: user),
          );
        }
        return null;
      },
    );
  }
}