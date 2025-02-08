import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/initial_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitialDataService.loadInitialData(); // Cargar datos iniciales
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}