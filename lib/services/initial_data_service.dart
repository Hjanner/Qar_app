import '../models/vehicle_model.dart';
import 'storage_service.dart';

class InitialDataService {
  static Future<void> loadInitialData() async {
    // Cargar lista actual de vehículos
    final vehicles = await StorageService.loadVehicles();

    // Si no hay vehículos registrados, cargar datos de prueba
    if (vehicles.isEmpty) {
      final testVehicles = [
        Vehicle(
          plateNumber: 'ABC123',
          ownerName: 'Juan Pérez',
          vehicleType: 'Auto',
          color: 'Rojo',
          entryDate: DateTime.now(),
          notes: 'Vehículo de prueba',
        ),
        Vehicle(
          plateNumber: 'XYZ789',
          ownerName: 'María López',
          vehicleType: 'Moto',
          color: 'Negro',
          entryDate: DateTime.now(),
          notes: 'Vehículo de prueba',
        ),
      ];

      // Guardar vehículos de prueba
      await StorageService.saveVehicles(testVehicles);
    }
  }
}