import 'package:flutter/material.dart';
import '../models/vehicle_model.dart';
import '../services/storage_service.dart';

class ListVehiclesScreen extends StatefulWidget {
  const ListVehiclesScreen({super.key});

  @override
  _ListVehiclesScreenState createState() => _ListVehiclesScreenState();
}

class _ListVehiclesScreenState extends State<ListVehiclesScreen> {
  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    final loadedVehicles = await StorageService.loadVehicles();
    setState(() {
      vehicles = loadedVehicles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehículos Registrados'),
      ),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];
          return ListTile(
            title: Text(vehicle.plateNumber),
            subtitle: Text('Propietario: ${vehicle.ownerName}'),
            trailing: Text(vehicle.vehicleType),
          );
        },
      ),
    );
  }
}