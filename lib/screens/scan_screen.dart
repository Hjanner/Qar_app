import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:convert'; // Para jsonDecode
import '../services/access_record_service.dart'; // Importar el nuevo servicio
import '../models/vehicle_model.dart'; // Para acceder a la clase Vehicle

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  _QrScannerScreenState createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = false;
  String scannedPlate = '';
  String scannedOwnerName = '';

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _processScannedData(String scannedData) async {
    try {
      // Decodificar el JSON escaneado
      final Map<String, dynamic> scannedVehicle = jsonDecode(scannedData);

      // Extraer el número de placa y el nombre del propietario
      final String plateNumber = scannedVehicle['plateNumber'] ?? 'Desconocido';
      final String ownerName = scannedVehicle['ownerName'] ?? 'Desconocido'; // Valor predeterminado si es null

      setState(() {
        scannedPlate = plateNumber;
        scannedOwnerName = ownerName;
      });

      // Verificar si la placa está registrada
      final bool isRegistered = await AccessRecordService.isPlateRegistered(plateNumber);

      if (isRegistered) {
        // Registrar el acceso
        await AccessRecordService.registerAccess(plateNumber, ownerName);

        // Mostrar mensaje de acceso permitido
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Acceso permitido para $ownerName ($plateNumber).'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Mostrar mensaje de acceso denegado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Acceso denegado. La placa $plateNumber no está registrada.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Manejar errores de decodificación JSON
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al procesar el código QR: $e'),
          backgroundColor: Colors.orange,
        ),
      );
    } finally {
      setState(() {
        isScanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null && !isScanning) {
                    setState(() {
                      isScanning = true;
                    });

                    _processScannedData(barcode.rawValue!);
                  }
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  scannedPlate.isEmpty
                      ? 'Escanea un código QR'
                      : 'Placa escaneada: $scannedPlate',
                  style: const TextStyle(fontSize: 18),
                ),
                if (scannedOwnerName.isNotEmpty)
                  Text(
                    'Propietario: $scannedOwnerName',
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}