import 'package:flutter/material.dart';
import '/models/vehicle_model.dart';
import '/models/user_model.dart';
import '/componets/home_button.dart'; // Importa el widget reutilizable

class AccessResultScreen extends StatelessWidget {
  final bool isAccessGranted;
  final Vehicle? vehicle;
  final User user; // Añade el parámetro User

  const AccessResultScreen({
    super.key,
    required this.isAccessGranted,
    this.vehicle,
    required this.user, // Requiere un objeto User
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Resultado de Acceso',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.blue.shade700,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Tarjeta de resultado
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Icono animado
                      TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Icon(
                              isAccessGranted
                                  ? Icons.check_circle_outline
                                  : Icons.cancel_outlined,
                              color: isAccessGranted
                                  ? Colors.green.shade600
                                  : Colors.red.shade600,
                              size: 120,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 18),

                      // Mensaje de resultado
                      Text(
                        isAccessGranted ? 'Acceso Permitido' : 'Acceso Denegado',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isAccessGranted
                              ? Colors.green.shade600
                              : Colors.red.shade600,
                        ),
                      ),

                      if (!isAccessGranted)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'El vehículo no está registrado en el sistema',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Información del vehículo
                if (isAccessGranted && vehicle != null) ...[
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade100.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información del Vehículo',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.confirmation_number_outlined,
                            'Placa', vehicle!.plateNumber),
                        _buildInfoRow(
                            Icons.person_outline, 'Propietario', vehicle!.ownerName),
                        _buildInfoRow(Icons.directions_car_outlined, 'Tipo',
                            vehicle!.vehicleType),
                        if (vehicle!.notes != null && vehicle!.notes!.isNotEmpty)
                          _buildInfoRow(
                              Icons.note_outlined, 'Notas', vehicle!.notes!),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 32),

                // Botones de acción
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        context,
                        'Escanear',
                        Icons.qr_code_scanner_outlined,
                        () => Navigator.pop(context),
                        Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: HomeButton(
                        user: user, // Pasa el objeto User
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Colors.blue.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon,
      VoidCallback onPressed, Color color) {
    return ElevatedButton(
      onPressed: onPressed,
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
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}