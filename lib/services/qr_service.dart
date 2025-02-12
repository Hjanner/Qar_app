import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gal/gal.dart'; // Importar el paquete gal
import '../models/vehicle_model.dart';

class QrService {
  // Método para capturar el QR como imagen con fondo blanco
  static Future<Uint8List> captureQrImage(Vehicle vehicle) async {
    final qrData = jsonEncode(vehicle.toMap());
    final qrPainter = QrPainter(
      data: qrData,
      version: QrVersions.auto,
      gapless: true, // Eliminar espacios en blanco alrededor del QR
      color: Colors.black, // Color del QR
      emptyColor: Colors.white, // Color de fondo del QR
    );

    // Tamaño del código QR (aumentar la resolución)
    final qrSize = Size(400, 400); // Aumentar el tamaño del QR

    // Margen blanco alrededor del QR (aumentar los márgenes)
    final margin = 40.0; // Aumentar los márgenes

    // Tamaño total de la imagen (QR + margen)
    final imageSize = Size(qrSize.width + 2 * margin, qrSize.height + 2 * margin);

    // Crear un PictureRecorder para capturar la imagen
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, imageSize.width, imageSize.height));

    // Dibujar un fondo blanco
    final backgroundPaint = Paint()..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, imageSize.width, imageSize.height), backgroundPaint);

    // Calcular la posición para centrar el QR en la imagen
    final offset = Offset(
      (imageSize.width - qrSize.width) / 2,
      (imageSize.height - qrSize.height) / 2,
    );

    // Guardar el estado del canvas
    canvas.save();

    // Mover el canvas al offset calculado
    canvas.translate(offset.dx, offset.dy);

    // Dibujar el QR en el Canvas
    qrPainter.paint(canvas, qrSize);

    // Restaurar el estado del canvas
    canvas.restore();

    // Finalizar la grabación y convertirla en una imagen
    final picture = recorder.endRecording();
    final image = await picture.toImage(imageSize.width.toInt(), imageSize.height.toInt());

    // Convertir la imagen a bytes en formato PNG
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  // Método para guardar la imagen en la galería
  static Future<void> saveQrImage(BuildContext context, Vehicle vehicle) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    try {
      final imageBytes = await captureQrImage(vehicle);
      await Gal.putImageBytes(imageBytes, name: "QarApp_${vehicle.plateNumber}_${vehicle.ownerName}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imagen guardada en la galería')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar la imagen: $e')),
      );
    }
  }
}