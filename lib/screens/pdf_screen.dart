// import 'package:flutter/material.dart';
// import '../services/pdf_service.dart';
// import '../models/user_model.dart';

// class PdfScreen extends StatelessWidget {
//   final User user;

//   const PdfScreen({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PDF Generado'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // ignore: unused_local_variable
//             final pdfFile = await PdfService.generatePdf(user);
//             // Aquí puedes abrir el PDF o compartirlo
//           },
//           child: const Text('Descargar PDF'),
//         ),
//       ),
//     );
//   }
// }