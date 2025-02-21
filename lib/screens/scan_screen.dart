import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qar/models/user_model.dart';
import 'package:qar/screens/outputs/access_result_screen.dart';
import 'dart:async';
import 'dart:convert';
import '../services/access_record_service.dart';
import '../models/vehicle_model.dart';

class QrScannerScreen extends StatefulWidget {
  final User user;

  const QrScannerScreen({super.key, required this.user});

  @override
  _QrScannerScreenState createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = false;
  bool isProcessing = false;
  bool isTorchOn = false;
  Timer? _debounceTimer;

  late final User user;

  @override
  void initState() {
    super.initState();
    user = widget.user; // Obtén el objeto User desde el widget
  }

  @override
  void dispose() {
    cameraController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade700),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Entendido',
                style: TextStyle(color: Colors.blue.shade700),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _processScannedData(String scannedData) async {
    if (isProcessing) return;
    isProcessing = true;

    try {
      final Map<String, dynamic> scannedVehicle = jsonDecode(scannedData);

      // Validación de datos requeridos
      if (!scannedVehicle.containsKey('plateNumber')) {
        throw const FormatException('El código QR no contiene información de placa válida');
      }

      final String plateNumber = scannedVehicle['plateNumber'];
      final String ownerName = scannedVehicle['ownerName'] ?? 'Desconocido';

      // Verificar registro
      final bool isRegistered = await AccessRecordService.isPlateRegistered(plateNumber);

      final vehicle = Vehicle(
        plateNumber: plateNumber,
        ownerName: ownerName,
        ownerPhone: scannedVehicle['ownerPhone'] ?? 'Desconocido',
        vehicleType: scannedVehicle['vehicleType'] ?? 'Desconocido',
        color: scannedVehicle['color'] ?? 'Desconocido',
        entryDate: DateTime.tryParse(scannedVehicle['entryDate'] ?? '') ?? DateTime.now(),
        notes: scannedVehicle['notes'],
      );

      if (isRegistered) {
        await AccessRecordService.registerAccess(plateNumber, ownerName);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccessResultScreen(
            isAccessGranted: isRegistered,
            vehicle: isRegistered ? vehicle : null,
            user: user,
          ),
        ),
      );
    } on FormatException catch (e) {
      _showErrorDialog(
        'Error de Formato',
        'El código QR no tiene el formato correcto: ${e.message}',
      );
    } on Exception catch (e) {
      _showErrorDialog(
        'Error de Procesamiento',
        'No se pudo procesar el código QR: ${e.toString()}',
      );
    } finally {
      setState(() {
        isScanning = false;
        isProcessing = false;
      });
    }
  }

  void _onDetect(BarcodeCapture capture) {
    if (_debounceTimer?.isActive ?? false) return;

    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null && !isScanning && !isProcessing) {
        setState(() {
          isScanning = true;
        });

        _processScannedData(barcode.rawValue!);
        _debounceTimer = Timer(const Duration(seconds: 2), () {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Escanear QR',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: Icon(
              isTorchOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.blue.shade900,
            ),
            onPressed: () {
              setState(() {
                isTorchOn = !isTorchOn;
                cameraController.toggleTorch();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: cameraController,
                      onDetect: _onDetect,
                    ),
                    // Overlay de escaneo
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 5,
                        ),
                      ),
                    ),
                    // Indicador de procesamiento
                    if (isProcessing)
                      Container(
                        color: Colors.black54,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.blue.shade700,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Procesando QR...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
          ),
          // Instrucciones
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Centre el código QR dentro del marco para escanear.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue.shade900.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}