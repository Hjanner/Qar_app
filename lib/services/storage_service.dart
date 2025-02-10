import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/vehicle_model.dart';
import '../models/access_record_model.dart';

class StorageService {
  static const String _vehicleListKey = 'vehicleList';
  static const String _accessRecordListKey = 'accessRecordList';

  // Guardar lista de vehículos
  static Future<void> saveVehicles(List<Vehicle> vehicles) async {
    final prefs = await SharedPreferences.getInstance();
    final vehicleList = vehicles.map((vehicle) => jsonEncode(vehicle.toMap())).toList();
    await prefs.setStringList(_vehicleListKey, vehicleList);
  }

  // Cargar lista de vehículos
  static Future<List<Vehicle>> loadVehicles() async {
    final prefs = await SharedPreferences.getInstance();
    final vehicleList = prefs.getStringList(_vehicleListKey) ?? [];

    return vehicleList.map((mapString) {
      final map = _parseMapString(mapString);
      return Vehicle.fromMap(map);
    }).toList();
  }

  // Guardar lista de registros de acceso
  static Future<void> saveAccessRecords(List<AccessRecord> records) async {
    final prefs = await SharedPreferences.getInstance();
    final recordList = records.map((record) => jsonEncode(record.toMap())).toList();
    await prefs.setStringList(_accessRecordListKey, recordList);
  }

  // Cargar lista de registros de acceso
  static Future<List<AccessRecord>> loadAccessRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordList = prefs.getStringList(_accessRecordListKey) ?? [];

    return recordList.map((mapString) {
      final map = _parseMapString(mapString);
      return AccessRecord.fromMap(map);
    }).toList();
  }

  // Método para convertir un String en un Map
  static Map<String, dynamic> _parseMapString(String mapString) {
    try {
      // Si el JSON es válido, simplemente lo parseamos
      return jsonDecode(mapString);
    } catch (e) {
      // Si no es un JSON válido, usamos el método antiguo
      mapString = mapString.replaceAll('{', '').replaceAll('}', '');
      final parts = mapString.split(',');

      final Map<String, dynamic> map = {};
      for (final part in parts) {
        final keyValue = part.split(':');
        if (keyValue.length == 2) {
          final key = keyValue[0].trim().replaceAll("'", "").replaceAll('"', '');
          final value = keyValue[1].trim().replaceAll("'", "").replaceAll('"', '');

          // Manejar valores nulos o vacíos
          if (value.isEmpty || value == 'null') {
            map[key] = null;
          } else {
            map[key] = value;
          }
        }
      }

      return map;
    }
  }
}