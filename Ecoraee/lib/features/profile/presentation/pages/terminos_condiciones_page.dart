import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'profile_header.dart';
import '../widgets/profile_bottom_nav.dart';

class TerminosCondicionesPage extends StatelessWidget {
  const TerminosCondicionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeader(title: 'Términos y condiciones', showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection('1. Aceptación de los términos', 'Al acceder y utilizar esta aplicación, el usuario acepta cumplir con los presentes Términos y Condiciones. Si no está de acuerdo con alguno de ellos, deberá abstenerse de utilizar la plataforma.'),
                    _buildSection('2. Uso de la aplicación', 'El usuario se compromete a utilizar la aplicación de manera responsable, ética y conforme a la ley. Está prohibido:\n• Proporcionar información falsa o incompleta.\n• Usar la plataforma con fines fraudulentos o ilegales.\n• Interferir con el funcionamiento de la aplicación.'),
                    _buildSection('3. Registro e información del usuario', 'Para acceder a ciertas funcionalidades, el usuario deberá proporcionar información personal como:\n• Nombre completo\n• Correo electrónico\n• Número de teléfono\nEl usuario garantiza que la información suministrada es veraz y actualizada.'),
                    _buildSection('4. Privacidad y protección de datos', 'La información personal del usuario será tratada conforme a nuestra Política de Privacidad. Los datos serán utilizados únicamente para:\n• Gestión de la cuenta\n• Envío de notificaciones\n• Mejora del servicio\nNo se compartirán datos con terceros sin autorización, salvo obligación legal.'),
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
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
                            'Aceptar',
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
