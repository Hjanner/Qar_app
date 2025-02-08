// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:qar/models/user_model.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';

// class PdfService {
//   static Future<File> generatePdf(User user) async {
//     final pdf = pw.Document();

//     final qrImage = await QrPainter(
//       data: user.toMap().toString(),
//       version: QrVersions.auto,
//     ).toImageData(300);

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Column(
//             children: [
//               pw.Text('Datos del Usuario'),
//               pw.Text('Nombre: ${user.nombre}'),
//               pw.Text('Email: ${user.email}'),
//               pw.Text('Teléfono: ${user.telefono}'),
//               pw.Image(pw.MemoryImage(qrImage!.buffer.asUint8List())),
//             ],
//           );
//         },
//       ),
//     );

//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/user_qr.pdf");
//     await file.writeAsBytes(await pdf.save());

//     return file;
//   }
// }