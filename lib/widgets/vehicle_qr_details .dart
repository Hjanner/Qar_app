import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '/models/vehicle_model.dart';
import '/services/qr_service.dart';

class VehicleQrDetails extends StatelessWidget {
  final Vehicle vehicle;
  final bool showSaveButton;

  const VehicleQrDetails({
    super.key,
    required this.vehicle,
    this.showSaveButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final qrData = jsonEncode(vehicle.toMap());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Tarjeta con el código QR
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 250.0,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Placa: ${vehicle.plateNumber}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Propietario: ${vehicle.ownerName}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Teléfono: ${vehicle.ownerPhone}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tipo: ${vehicle.vehicleType}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Color: ${vehicle.color}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (vehicle.notes != null) Text('Notas: ${vehicle.notes}', style: const TextStyle(fontSize: 16), textAlign: TextAlign.start,),

                ],
              ),
            ),
            const SizedBox(height: 30),

            // Botón para guardar el QR (condicional)
            if (showSaveButton)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => QrService.saveQrImage(context, vehicle),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.download_outlined, size: 24),
                      SizedBox(width: 12),
                      Text(
                        'Guardar QR',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Botón para ir a Inicio
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.blue.shade700),
                  ),
                ),
                child: const Text(
                  'Ir a Inicio',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}