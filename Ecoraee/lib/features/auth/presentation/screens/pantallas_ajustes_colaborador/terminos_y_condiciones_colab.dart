import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TerminosCondicionesColabScreen extends StatelessWidget {
  const TerminosCondicionesColabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF19133B), // Fondo oscuro base
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const SizedBox(
                      width: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'TÉRMINOS Y\nCONDICIONES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        height: 1.1,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 2. Contenedor Blanco de texto
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F6F8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(25, 40, 25, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '1. TÉRMINOS Y CONDICIONES (COLABORADOR)',
                        style: TextStyle(
                          color: Color(0xFF19133B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),

                      _buildSectionTitle('1. Aceptación de los términos'),
                      _buildSectionText(
                        'Al registrarse y utilizar la plataforma CICLOX como colaborador, la empresa acepta cumplir con los presentes términos y condiciones. El uso de la plataforma implica la aceptación total de estas condiciones.',
                      ),

                      _buildSectionTitle('2. Rol del colaborador'),
                      _buildSectionText(
                        'El colaborador es responsable de gestionar las solicitudes de recolección, transporte y disposición de residuos electrónicos (RAEE) dentro de la plataforma.',
                      ),

                      _buildSectionTitle('3. Uso de la plataforma'),
                      _buildSectionText('El colaborador se compromete a:'),
                      _buildBulletPoint(
                        'Gestionar las solicitudes de manera responsable',
                      ),
                      _buildBulletPoint(
                        'Mantener actualizada la información operativa',
                      ),
                      _buildBulletPoint(
                        'Utilizar la plataforma únicamente para fines relacionados con la gestión de RAEE',
                      ),

                      const SizedBox(height: 15),
                      _buildSectionText('Está prohibido:', isBold: true),
                      _buildBulletPoint('Manipular información del sistema'),
                      _buildBulletPoint(
                        'Aceptar solicitudes sin capacidad operativa',
                      ),
                      _buildBulletPoint(
                        'Usar la plataforma con fines fraudulentos',
                      ),

                      _buildSectionTitle('4. Gestión de solicitudes'),
                      _buildSectionText('El colaborador podrá:'),
                      _buildBulletPoint(
                        'Aceptar, rechazar o reprogramar solicitudes',
                      ),
                      _buildBulletPoint('Actualizar el estado del servicio'),
                      _buildBulletPoint(
                        'Cancelar solicitudes cuando sea necesario',
                      ),
                      const SizedBox(height: 10),
                      _buildSectionText(
                        'Todas las acciones deben reflejar el estado real del proceso.',
                      ),

                      _buildSectionTitle('5. Responsabilidad operativa'),
                      _buildSectionText('El colaborador es responsable de:'),
                      _buildBulletPoint(
                        'Cumplir con los tiempos de recolección',
                      ),
                      _buildBulletPoint(
                        'Garantizar la correcta manipulación de los residuos',
                      ),
                      _buildBulletPoint(
                        'Cumplir con normativas ambientales aplicables',
                      ),
                      const SizedBox(height: 10),
                      _buildSectionText(
                        'El manejo adecuado de RAEE es fundamental para reducir impactos ambientales negativos',
                        isItalic: true,
                      ),

                      _buildSectionTitle('6. Suspensión o bloqueo'),
                      _buildSectionText(
                        'CICLOX podrá suspender o bloquear el acceso del colaborador en caso de:',
                      ),
                      _buildBulletPoint('Incumplimiento de procesos'),
                      _buildBulletPoint('Reportes negativos reiterados'),
                      _buildBulletPoint('Uso indebido de la plataforma'),

                      _buildSectionTitle('7. Modificaciones'),
                      _buildSectionText(
                        'CICLOX podrá modificar estos términos en cualquier momento. El uso continuo de la plataforma implica la aceptación de los cambios.',
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF19133B),
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildSectionText(
    String text, {
    bool isBold = false,
    bool isItalic = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
          height: 1.5,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
