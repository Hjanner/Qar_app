// import 'package:flutter/material.dart';
// import 'package:qar/screens/pdf_screen.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import '../models/user_model.dart';

// class QrScreen extends StatelessWidget {
//   final User user;

//   QrScreen({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Código QR'),
//       ),
//       body: Center(
//         child: QrImageView(
//           data: user.toMap().toString(),
//           version: QrVersions.auto,
//           size: 200.0,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PdfScreen(user: user),
//             ),
//           );
//         },
//         child: Icon(Icons.picture_as_pdf),
//       ),
//     );
//   }
// }