import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'profile_header.dart';
import '../widgets/profile_bottom_nav.dart';

class PoliticasPrevencionPage extends StatelessWidget {
  const PoliticasPrevencionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeader(title: 'Politicas de prevencion', showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection('1. Objetivo', 'Estas políticas buscan prevenir:\n• Fraudes\n• Uso indebido de la aplicación\n• Manipulación del sistema de puntos y beneficios\n• Información falsa en los procesos de reciclaje\n\nCriterio:\nTodo comportamiento sospechoso será monitoreado y evaluado automáticamente por el sistema.'),
                    _buildSection('2. Prevención de información falsa', 'El usuario debe ingresar información real en:\n• Registro de cuenta\n• Datos personales\n• Solicitudes de reciclaje\n\nCriterio:\n• Si se detectan datos falsos la solicitud es rechazada.\n• Si el comportamiento se repite suspensión de la cuenta.\n• Si es grave eliminación permanente.'),
                    _buildSection('3. Validación del reciclaje', 'Para evitar fraudes en el sistema:\n• Las solicitudes pueden ser verificadas\n• Se puede validar el dispositivo entregado\n\nCriterio:\n• Si el dispositivo no coincide con lo registrado no se asignan puntos.\n• Si hay intento de engaño bloqueo temporal.\n• Reincidencia cancelación de la cuenta.'),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement Report Problem
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.navy,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Reportar problema',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ProfileBottomNav(currentIndex: 0),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

}
