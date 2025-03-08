  import 'package:flutter/material.dart';
import 'package:qar/componets/app_button_styles.dart';
import 'package:qar/models/user_model.dart';
  import '../models/vehicle_model.dart';
  import '../services/storage_service.dart';
  import 'qr_screen.dart';

  class RegisterVehicleScreen extends StatefulWidget {
    final User user;
    const RegisterVehicleScreen({super.key, required this.user});

    @override
    _RegisterVehicleScreenState createState() => _RegisterVehicleScreenState();
  }

  class _RegisterVehicleScreenState extends State<RegisterVehicleScreen> {
    final _formKey = GlobalKey<FormState>();
    final _plateNumberController = TextEditingController();
    final _ownerNameController = TextEditingController();
    final _ownerPhoneController = TextEditingController();
    final _vehicleTypeController = TextEditingController();
    final _colorController = TextEditingController();
    final _notesController = TextEditingController();

    // Validaciones existentes
    Future<bool> _isPlateNumberUnique(String plateNumber) async {
      final vehicles = await StorageService.loadVehicles();
      return !vehicles.any((vehicle) => vehicle.plateNumber == plateNumber);
    }

    String? _validatePlateNumber(String? value) {
      if (value == null || value.isEmpty) {
        return 'Por favor ingrese el número de placa';
      }
      if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
        return 'La placa solo puede contener letras y números';
      }
      return null;
    }

    String? _validateOwnerName(String? value) {
      if (value == null || value.isEmpty) {
        return 'Por favor ingrese el nombre del propietario';
      }
    if (!RegExp(r'^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$').hasMatch(value)) {
      return 'El nombre solo puede contener letras, espacios y caracteres acentuados';
    }
      return null;
    }

    String? _validateOwnerPhone(String? value) {
      if (value == null || value.isEmpty) {
        return 'Por favor ingrese el teléfono del propietario';
      }
      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return 'El teléfono solo puede contener números';
      }
      if (value.length < 10) {
        return 'El teléfono debe tener al menos 10 dígitos';
      }
      return null;
    }

    String? _validateVehicleType(String? value) {
      if (value == null || value.isEmpty) {
        return 'Por favor ingrese el tipo de vehículo';
      }
      return null;
    }

    String? _validateColor(String? value) {
      if (value == null || value.isEmpty) {
        return 'Por favor ingrese el color del vehículo';
      }
      return null;
    }

    void _showCustomAlert(String message, bool isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(
                  isError ? Icons.error_outline : Icons.check_circle_outline,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text(
            'Registrar Vehículo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.blue.shade700,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de la sección
                  Text(
                    'Información del Vehículo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Campos del formulario
                  _buildTextField(
                    controller: _plateNumberController,
                    label: 'Número de Placa',
                    icon: Icons.confirmation_number_outlined,
                    validator: _validatePlateNumber,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildTextField(
                    controller: _ownerNameController,
                    label: 'Nombre del Propietario',
                    icon: Icons.person_outline,
                    validator: _validateOwnerName,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildTextField(
                    controller: _ownerPhoneController,
                    label: 'Teléfono del Propietario',
                    icon: Icons.phone_outlined,
                    validator: _validateOwnerPhone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildTextField(
                    controller: _vehicleTypeController,
                    label: 'Marca de Vehículo',
                    icon: Icons.directions_car_outlined,
                    validator: _validateVehicleType,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildTextField(
                    controller: _colorController,
                    label: 'Color del Vehículo',
                    icon: Icons.color_lens_outlined,
                    validator: _validateColor,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildTextField(
                    controller: _notesController,
                    label: 'Notas Adicionales',
                    icon: Icons.note_outlined,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 32),
                  
                  // Botón de registro
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final plateNumber = _plateNumberController.text;

                          if (!await _isPlateNumberUnique(plateNumber)) {
                            _showCustomAlert(
                              'El número de placa ya está registrado',
                              true,
                            );
                            return;
                          }

                          final vehicle = Vehicle(
                            plateNumber: plateNumber,
                            ownerName: _ownerNameController.text,
                            ownerPhone: _ownerPhoneController.text,
                            vehicleType: _vehicleTypeController.text,
                            color: _colorController.text,
                            entryDate: DateTime.now(),
                            notes: _notesController.text,
                          );

                          final vehicles = await StorageService.loadVehicles();
                          vehicles.add(vehicle);
                          await StorageService.saveVehicles(vehicles);

                          _formKey.currentState!.reset();
                          
                          _showCustomAlert(
                            'Vehículo registrado exitosamente',
                            false,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QrScreen(vehicle: vehicle, user: widget.user,),
                            ),
                          );
                        }
                      },
                      style: AppButtonStyles.blueWithWhiteText,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_outline, size: 24),
                          SizedBox(width: 12),
                          Text(
                            'Registrar Vehículo',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildTextField({
      required TextEditingController controller,
      required String label,
      required IconData icon,
      String? Function(String?)? validator,
      TextInputType? keyboardType,
      int maxLines = 1,
    }) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          cursorColor: Colors.blue.shade700,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.blue.shade700),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade50),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade300),
            ),
            filled: true,
            fillColor: Colors.white,
            labelStyle: TextStyle(color: Colors.blue.shade700),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      );
    }
  }