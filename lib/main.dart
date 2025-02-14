import 'package:flutter/material.dart';
import 'package:qar/auth/login_screen.dart';
import 'package:qar/services/auth_service.dart';

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
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:qar/screens/scan_screen.dart';
// import 'screens/home_screen.dart';
// import 'services/initial_data_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await InitialDataService.loadInitialData(); // Cargar datos iniciales
//   //debugShowCheckedModeBanner = false; // Desactiva la banda de "Debug"
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Qar App',
//       theme: ThemeData(
//         fontFamily: 'Quicksand',
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/home',
//       routes: {
//         '/scanner': (context) => const QrScannerScreen(),
//         '/home': (context) => const HomeScreen(), // Define tu HomePage aquí
//       },
//     );
//   }
// }