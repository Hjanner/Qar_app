import '../models/vehicle_model.dart';
import '../models/access_record_model.dart';
import 'storage_service.dart';

class AccessRecordService {
  // Validar si la placa está registrada
  static Future<Vehicle?> validatePlateNumber(String plateNumber) async {
    final vehicles = await StorageService.loadVehicles();
    try {
      return vehicles.firstWhere(
        (vehicle) => vehicle.plateNumber.toUpperCase() == plateNumber.toUpperCase(),
      );
    } catch (e) {
      print('Error validating plate number: $e');
      return null;
    }
  }

  // Registrar un acceso
  static Future<void> registerAccess(Vehicle vehicle) async {
    final records = await StorageService.loadAccessRecords();
    records.add(AccessRecord(
      plateNumber: vehicle.plateNumber,
      ownerName: vehicle.ownerName,
      accessTime: DateTime.now(),
    ));
    await StorageService.saveAccessRecords(records);
    print('Access record saved for: ${vehicle.plateNumber}');
  }
}