import 'package:flutter/material.dart';
import 'package:qar/screens/access_records_screen.dart';
import 'package:qar/screens/list-vehicles_screen.dart';
import 'package:qar/screens/list-vehicles_screen.dart';
import 'package:qar/debug/test_access_record_screen.dart';
import 'register_screen.dart';
import 'scan_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qar App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text('Registrar Usuario'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QrScannerScreen(),
                  ),
                );
              },
              child: const Text('Escanear QR'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListVehiclesScreen(),
                  ),
                );
              },
              child: const Text('Ver Vehículos Registrados'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccessRecordsScreen(),
                  ),
                );
              },
              child: const Text('Ver Registros de Acceso'),
            ),      
            //debug
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const TestAccessRecordScreen(),
            //       ),
            //     );
            //   },
            //   child: const Text('test'),
            // ),                      
          ],
        ),
      ),
    );
  }
}