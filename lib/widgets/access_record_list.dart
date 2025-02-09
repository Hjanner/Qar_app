import 'package:flutter/material.dart';
import '../models/access_record_model.dart';

//muestra los registros de acceso en listas desplegables organizadas por día.


class AccessRecordList extends StatelessWidget {
  final List<AccessRecord> records;

  const AccessRecordList({required this.records});

  @override
  Widget build(BuildContext context) {
    final groupedRecords = _groupRecordsByDay(records);

    return ListView(
      children: groupedRecords.entries.map((entry) {
        final day = entry.key;
        final records = entry.value;

        return ExpansionTile(
          title: Text(day),
          children: records.map((record) {
            return ListTile(
              title: Text('${record.ownerName} - ${record.plateNumber}'),
              subtitle: Text('Hora: ${record.accessTime.hour}:${record.accessTime.minute}'),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  Map<String, List<AccessRecord>> _groupRecordsByDay(List<AccessRecord> records) {
    final Map<String, List<AccessRecord>> groupedRecords = {};

    for (final record in records) {
      final day = '${record.accessTime.day}/${record.accessTime.month}/${record.accessTime.year}';
      if (!groupedRecords.containsKey(day)) {
        groupedRecords[day] = [];
      }
      groupedRecords[day]!.add(record);
    }

    return groupedRecords;
  }
}