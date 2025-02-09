class AccessRecord {
  final String plateNumber;
  final String ownerName;
  final DateTime accessTime;

  AccessRecord({
    required this.plateNumber,
    required this.ownerName,
    required this.accessTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'plateNumber': plateNumber,
      'ownerName': ownerName,
      'accessTime': accessTime.toIso8601String(),
    };
  }

  factory AccessRecord.fromMap(Map<String, dynamic> map) {
    return AccessRecord(
      plateNumber: map['plateNumber'],
      ownerName: map['ownerName'],
      accessTime: DateTime.parse(map['accessTime']),
    );
  }
}