import 'package:flutter/material.dart';
import 'package:qar/componets/app_button_styles.dart';
import 'package:qar/models/user_model.dart';
import 'package:qar/screens/outputs/list_users_screen%20.dart';
import 'package:qar/screens/outputs/list_vehicles_screen.dart';
import 'package:qar/screens/outputs/access_records_screen.dart';
import 'package:qar/widgets/logo_secction.dart';

class RecordsOptionsScreen extends StatelessWidget {
  final User user;

  const RecordsOptionsScreen({super.key, required this.user});

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

              // Logo section 
              LogoSection(),

              // Botones de Registros
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
                                builder: (context) => ListVehiclesScreen(user: user),
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
                                'Vehículos',
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
                                builder: (context) => AccessRecordsScreen(),
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
                                'Accesos',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                  builder: (context) => ListUsersScreen(currentUser: user),
                                ),
                              );
                            },
                            style: AppButtonStyles.whiteWithBlueBorder,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.people_outline, size: 24),
                                SizedBox(width: 12),
                                Text(
                                  'Operadores',
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