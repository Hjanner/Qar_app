import 'package:flutter/material.dart';
import '../services/access_record_service.dart';
import '../services/storage_service.dart'; // Importar StorageService
import '../models/access_record_model.dart';

class TestAccessRecordScreen extends StatefulWidget {
  const TestAccessRecordScreen({super.key});

  @override
  _TestAccessRecordScreenState createState() => _TestAccessRecordScreenState();
}

class _TestAccessRecordScreenState extends State<TestAccessRecordScreen> {
  final TextEditingController _plateNumberController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  List<AccessRecord> accessRecords = [];

  Future<void> _registerAccess() async {
    final String plateNumber = _plateNumberController.text.trim();
    final String ownerName = _ownerNameController.text.trim();

    if (plateNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa un número de placa.')),
      );
      return;
    }

    try {
      // Registrar el acceso
      await AccessRecordService.registerAccess(plateNumber, ownerName);

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Acceso registrado para $ownerName ($plateNumber).'),
          backgroundColor: Colors.green,
        ),
      );

      // Limpiar los campos después de registrar
      _plateNumberController.clear();
      _ownerNameController.clear();

      // Actualizar la lista de registros
      _loadAccessRecords();
    } catch (e) {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al registrar el acceso: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loadAccessRecords() async {
    // Usar StorageService para cargar los registros de acceso
    final records = await StorageService.loadAccessRecords();
    setState(() {
      accessRecords = records;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAccessRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba de Registro de Acceso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _plateNumberController,
              decoration: const InputDecoration(
                labelText: 'Número de Placa',
                hintText: 'Ej: ABC123',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ownerNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Propietario',
                hintText: 'Ej: Juan Pérez',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _registerAccess,
              child: const Text('Registrar Acceso'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Registros de Acceso:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: accessRecords.length,
                itemBuilder: (context, index) {
                  final record = accessRecords[index];
                  return ListTile(
                    title: Text('Placa: ${record.plateNumber}'),
                    subtitle: Text('Propietario: ${record.ownerName}\nFecha: ${record.accessTime}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _plateNumberController.dispose();
    _ownerNameController.dispose();
    super.dispose();
  }
}