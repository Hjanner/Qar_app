import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
import '../services/storage_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plateNumberController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _colorController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Vehículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _plateNumberController,
                decoration: const InputDecoration(labelText: 'Número de Placa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de placa';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ownerNameController,
                decoration: const InputDecoration(labelText: 'Nombre del Propietario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del propietario';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _vehicleTypeController,
                decoration: const InputDecoration(labelText: 'Tipo de Vehículo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el tipo de vehículo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(labelText: 'Color del Vehículo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el color del vehículo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notas Adicionales'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final vehicle = Vehicle(
                      plateNumber: _plateNumberController.text,
                      ownerName: _ownerNameController.text,
                      vehicleType: _vehicleTypeController.text,
                      color: _colorController.text,
                      entryDate: DateTime.now(),
                      notes: _notesController.text,
                    );

                    // Cargar lista actual
                    final vehicles = await StorageService.loadVehicles();
                    vehicles.add(vehicle);

                    // Guardar lista actualizada
                    await StorageService.saveVehicles(vehicles);

                    // Limpiar formulario
                    _formKey.currentState!.reset();

                    // Mostrar mensaje de éxito
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vehículo registrado exitosamente')),
                    );
                  }
                },
                child: const Text('Registrar Vehículo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}