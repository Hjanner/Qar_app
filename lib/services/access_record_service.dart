import 'package:shared_preferences/shared_preferences.dart';
import '../models/vehicle_model.dart';
import '../models/access_record_model.dart';
import '../services/storage_service.dart';

class AccessRecordService {
  // Verificar si la placa está registrada
  static Future<bool> isPlateRegistered(String plateNumber) async {
    final vehicles = await StorageService.loadVehicles();
    return vehicles.any((vehicle) => vehicle.plateNumber == plateNumber);
  }

  // Registrar un acceso en la lista de registros
  static Future<void> registerAccess(String plateNumber, String ownerName) async {
    final accessRecords = await StorageService.loadAccessRecords();

    // Crear un nuevo registro de acceso
    final newAccessRecord = AccessRecord(
      plateNumber: plateNumber,
      ownerName: ownerName, // Valor predeterminado si es null
      accessTime: DateTime.now(),
    );

    // Agregar el nuevo registro a la lista
    accessRecords.add(newAccessRecord);

    // Guardar la lista actualizada en el almacenamiento
    await StorageService.saveAccessRecords(accessRecords);
  }
}