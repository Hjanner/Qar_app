import 'package:flutter/material.dart';
import 'package:qar/models/user_model.dart';
import 'package:qar/screens/register_vehicle_screen.dart';
import 'package:qar/auth/register_user_screen.dart';
import 'package:qar/widgets/logo_secction.dart';
import 'package:qar/componets/app_button_styles.dart';

class RegisterOptionsScreen extends StatelessWidget {
  final User user;

  const RegisterOptionsScreen({super.key, required this.user});

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
              // AppBar personalizado con botón de retroceso
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue.shade700),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Logo section reutilizable
              LogoSection(),

              // Botones de Registrar
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterVehicleScreen(user: user),
                              ),
                            );
                          },
                          style: AppButtonStyles.whiteWithBlueBorder,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.directions_car_outlined, size: 24),
                              SizedBox(width: 12),
                              Text(
                                'Registrar Vehículo',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                builder: (context) => const RegisterUserScreen(),
                              ),
                            );
                          },
                          style: AppButtonStyles.whiteWithBlueBorder,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add_outlined, size: 24),
                              SizedBox(width: 12),
                              Text(
                                'Registrar Operador',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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