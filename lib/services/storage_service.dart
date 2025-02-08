import 'package:shared_preferences/shared_preferences.dart';
import '../models/vehicle_model.dart';

class StorageService {
  static const String _vehicleListKey = 'vehicleList';

  // Guardar lista de vehículos
  static Future<void> saveVehicles(List<Vehicle> vehicles) async {
    final prefs = await SharedPreferences.getInstance();
    final vehicleList = vehicles.map((vehicle) => vehicle.toMap().toString()).toList();
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

  // Método para convertir un String en un Map
  static Map<String, dynamic> _parseMapString(String mapString) {
    // Eliminar llaves y comillas
    mapString = mapString.replaceAll('{', '').replaceAll('}', '');
    final parts = mapString.split(',');

    final Map<String, dynamic> map = {};
    for (final part in parts) {
      final keyValue = part.split(':');
      if (keyValue.length == 2) {
        final key = keyValue[0].trim().replaceAll("'", "").replaceAll('"', '');
        final value = keyValue[1].trim().replaceAll("'", "").replaceAll('"', '');

        // Manejar valores nulos o vacíos
        if (value.isEmpty) {
          map[key] = null;
        } else {
          map[key] = value;
        }
      }
    }

    return map;
  }
}