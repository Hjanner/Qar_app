import 'package:flutter/material.dart';
import 'package:qar/models/user_model.dart';
import '../../widgets/vehicle_qr_details .dart';
import '/models/vehicle_model.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;
  final User user;

  const VehicleDetailScreen({super.key, required this.vehicle, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade50,
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
                      'Detalles del Vehículo',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              //const SizedBox(height: 20),

              // Widget reutilizable
              Expanded(
                child: VehicleQrDetails(
                  vehicle: vehicle,
                  showSaveButton: true, // No mostrar el botón de guardar en esta pantalla
                  user: user,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}