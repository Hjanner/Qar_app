import 'package:flutter/material.dart';
import '../../models/access_record_model.dart';
import '../../services/storage_service.dart';
import '../../widgets/access_record_list.dart';

class AccessRecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade100,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar personalizado
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.blue[700]),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Registros de Acceso',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Lista de registros de acceso
              Expanded(
                child: FutureBuilder<List<AccessRecord>>(
                  future: StorageService.loadAccessRecords(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 16,
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No hay registros de acceso',
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 16,
                          ),
                        ),
                      );
                    } else {
                      final records = snapshot.data!;
                      return AccessRecordList(records: records);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}