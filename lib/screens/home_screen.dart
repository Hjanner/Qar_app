import 'package:flutter/material.dart';
import 'package:qar/auth/login_screen.dart';
import 'package:qar/componets/app_button_styles.dart';
import 'package:qar/models/user_model.dart';
import 'package:qar/screens/register_options_screen.dart';
import 'package:qar/screens/records_options_screen.dart';
import 'package:qar/screens/scan_screen.dart';
import 'package:qar/widgets/logo_secction.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

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
              // AppBar personalizado con botón de cerrar sesión
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.blue.shade700),
                      onPressed: () {
                        // Cerrar sesión y redirigir a LoginScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Logo section 
              LogoSection(),

              // Buttons section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (user.role == 'vigilante' || user.role == 'admin')
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QrScannerScreen(user: user),
                                ),
                              );
                            },
                            style: AppButtonStyles.blueWithWhiteText,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.qr_code_scanner_outlined, size: 28),
                                SizedBox(width: 12),
                                Text(
                                  'Escanear',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (user.role == 'admin')
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterOptionsScreen(user: user),
                                ),
                              );
                            },
                            style: AppButtonStyles.whiteWithBlueBorder,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline, size: 24),
                                SizedBox(width: 12),
                                Text(
                                  'Registrar',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecordsOptionsScreen(user: user),
                              ),
                            );
                          },
                          style: AppButtonStyles.whiteWithBlueBorder,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.history_outlined, size: 24),
                              SizedBox(width: 12),
                              Text(
                                'Registros',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}