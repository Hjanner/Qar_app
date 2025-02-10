class Vehicle {
  final String plateNumber; // Número de placa
  final String ownerName;   // Nombre del propietario
  final String ownerPhone;  // Teléfono del propietario
  final String vehicleType; // Tipo de vehículo (auto, moto, camión, etc.)
  final String color;       // Color del vehículo
  final DateTime entryDate; // Fecha de entrada
  final String? notes;      // Notas adicionales

  Vehicle({
    required this.plateNumber,
    required this.ownerName,
    required this.ownerPhone,
    required this.vehicleType,
    required this.color,
    required this.entryDate,
    this.notes,
  });

  // Convertir a Map para guardar en almacenamiento local
  Map<String, dynamic> toMap() {
    return {
      'plateNumber': plateNumber,
      'ownerName': ownerName,
      'ownerPhone': ownerPhone,
      'vehicleType': vehicleType,
      'color': color,
      'entryDate': entryDate.toIso8601String(),
      'notes': notes,
    };
  }

  // Convertir de Map a Vehicle
  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      plateNumber: map['plateNumber'] ?? 'Desconocido', // Valor predeterminado si es nulo
      ownerName: map['ownerName'] ?? 'Desconocido',     // Valor predeterminado si es nulo
      ownerPhone: map['ownerPhone'] ?? 'Desconocido',   // Valor predeterminado si es nulo
      vehicleType: map['vehicleType'] ?? 'Desconocido', // Valor predeterminado si es nulo
      color: map['color'] ?? 'Desconocido',             // Valor predeterminado si es nulo
      entryDate: DateTime.parse(map['entryDate'] ?? DateTime.now().toIso8601String()), // Valor predeterminado si es nulo
      notes: map['notes'],
    );
  }
}