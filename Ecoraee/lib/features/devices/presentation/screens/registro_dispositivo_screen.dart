import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';

class RegistroDispositivoScreen extends StatefulWidget {
  const RegistroDispositivoScreen({super.key});

  @override
  State<RegistroDispositivoScreen> createState() =>
      _RegistroDispositivoScreenState();
}

class _RegistroDispositivoScreenState extends State<RegistroDispositivoScreen> {
  final _tipoDispositivoCtrl = TextEditingController(text: 'Televisor');
  final _marcaCtrl = TextEditingController();
  final _modeloCtrl = TextEditingController();
  String _estadoDispositivo = 'Funciona';

  @override
  void dispose() {
    _tipoDispositivoCtrl.dispose();
    _marcaCtrl.dispose();
    _modeloCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header con logo y campana
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: CicloxColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.bolt_rounded,
                          color: CicloxColors.dark,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'ciclox',
                        style: TextStyle(
                          color: CicloxColors.dark,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.notifications_outlined,
                    color: CicloxColors.dark,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Botón volver y Título
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back,
                      color: CicloxColors.dark,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Registro del dispositivo',
                    style: TextStyle(
                      color: CicloxColors.dark,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Tipo de dispositivo (Dropdown)
              const Text(
                'Tipo de dispositivo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: CicloxColors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'Televisor',
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: CicloxColors.dark,
                    ),
                    items: ['Televisor', 'Nevera', 'Lavadora', 'Otros']
                        .map(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: CicloxColors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (_) {},
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Marca
              const Text(
                'Marca',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _marcaCtrl,
                decoration: InputDecoration(
                  hintText: 'Samsung',
                  hintStyle: const TextStyle(
                    color: CicloxColors.grey,
                    fontSize: 14,
                  ),
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: CicloxColors.grey.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: CicloxColors.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Modelo Opcional
              const Text(
                'Modelo Opcional',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _modeloCtrl,
                decoration: InputDecoration(
                  hintText: 'Neo QLED 8K',
                  hintStyle: const TextStyle(
                    color: CicloxColors.grey,
                    fontSize: 14,
                  ),
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: CicloxColors.grey.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: CicloxColors.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Estado del dispositivo
              const Text(
                'Estado del dispositivo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Funciona',
                        groupValue: _estadoDispositivo,
                        activeColor: CicloxColors.dark,
                        onChanged: (value) =>
                            setState(() => _estadoDispositivo = value!),
                      ),
                      const Text(
                        'Funciona',
                        style: TextStyle(
                          color: CicloxColors.dark,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Dañado',
                        groupValue: _estadoDispositivo,
                        activeColor: CicloxColors.dark,
                        onChanged: (value) =>
                            setState(() => _estadoDispositivo = value!),
                      ),
                      const Text(
                        'Dañado',
                        style: TextStyle(
                          color: CicloxColors.dark,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Subir foto
              const Text(
                'Subir foto',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 48),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CicloxColors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: CicloxColors.grey.withOpacity(0.5),
                      size: 48,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Subir foto',
                      style: TextStyle(
                        color: CicloxColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Botón Registrar dispositivo
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: CicloxColors.dark,
                  foregroundColor: CicloxColors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Registrar dispositivo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFFE8F2D9), // primaryLight equivalent from image
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.settings_outlined, color: CicloxColors.dark, size: 28),
            Icon(Icons.home_filled, color: CicloxColors.dark, size: 32),
            Icon(
              Icons.star_outline_rounded,
              color: CicloxColors.dark,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
