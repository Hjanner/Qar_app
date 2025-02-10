import '../models/vehicle_model.dart';
import '../models/access_record_model.dart';
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
          ownerPhone: '0000001',
          vehicleType: 'Auto',
          color: 'Rojo',
          entryDate: DateTime.now(),
          notes: 'Vehículo de prueba',
        ),
        Vehicle(
          plateNumber: 'XYZ789',
          ownerName: 'María López',
          ownerPhone: '0000002',
          vehicleType: 'Moto',
          color: 'Negro',
          entryDate: DateTime.now(),
          notes: 'Vehículo de prueba',
        ),
      ];

      // Guardar vehículos de prueba
      await StorageService.saveVehicles(testVehicles);


      //carga registros
      final accessRecords = await StorageService.loadAccessRecords();
      if(accessRecords.isEmpty){
        // Guardar un registro de acceso
        final accessRecord = AccessRecord(
          plateNumber: 'ABC123',
          ownerName: 'Juan Prueba',
          accessTime: DateTime.now(),
        );

        await StorageService.saveAccessRecords([accessRecord]);

        // Cargar registros de acceso
        final accessRecords = await StorageService.loadAccessRecords();
        print('Carga de prueba Registros de acceso cargados: ${accessRecords.length}');
      }
    }
  }
}