import 'dart:convert'; // Importa la librería para trabajar con JSON
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/vehicle_model.dart';
import '../services/access_record_service.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR'),
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) async {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? data = barcode.rawValue; // Obtén el valor escaneado
            if (data != null) {
              print('Datos escaneados: $data'); // Depuración: Imprime los datos escaneados

              try {
                // Intenta parsear el JSON
                String jsonString = data.replaceAll("'", '"'); // Reemplaza comillas simples por dobles
                jsonString = jsonString.replaceAll(": ", ":"); // Elimina espacios después de los dos puntos
                jsonString = jsonString.replaceAll(", ", ","); // Elimina espacios después de las comas

                final Map<String, dynamic> jsonData = jsonDecode(jsonString);

                // Accede a los campos del JSON de manera segura
                final String plateNumber = jsonData['plateNumber'] ?? 'Desconocido';
                print('Placa escaneada: $plateNumber'); // Depuración: Imprime la placa escaneada

                // Validar si la placa está registrada
                final vehicle = await AccessRecordService.validatePlateNumber(plateNumber);
                if (vehicle != null) {
                  // Registrar el acceso del vehículo
                  await AccessRecordService.registerAccess(vehicle);

                  // Mostrar mensaje de acceso permitido
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Acceso permitido: ${vehicle.ownerName} - ${vehicle.plateNumber}')),
                  );
                } else {
                  // Mostrar mensaje de acceso denegado
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Acceso denegado: Placa no registrada')),
                  );
                }
              } catch (e) {
                // Manejar errores de parseo o validación
                print('Error parsing JSON: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error al escanear el código QR')),
                );
              }
            }
          }
        },
      
      ),
    );
  }
}