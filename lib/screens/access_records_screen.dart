import 'package:flutter/material.dart';
import '../models/access_record_model.dart';
import '../services/storage_service.dart';
import '../widgets/access_record_list.dart';

class AccessRecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros de Acceso'),
      ),
      body: FutureBuilder<List<AccessRecord>>(
        future: StorageService.loadAccessRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay registros de acceso'));
          } else {
            final records = snapshot.data!;
            return AccessRecordList(records: records);
          }
        },
      ),
    );
  }
}