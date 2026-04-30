import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/router/app_router.dart';

class PoliticasPrivacidadColabScreen extends StatelessWidget {
  const PoliticasPrivacidadColabScreen({super.key});

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
                      'POLÍTICAS DE\nPRIVACIDAD',
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
                        '2. POLÍTICAS DE PRIVACIDAD (COLABORADOR)',
                        style: TextStyle(
                          color: Color(0xFF19133B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),

                      _buildSectionTitle('1. Tratamiento de datos'),
                      _buildSectionText(
                        'CICLOX recopila y gestiona datos del colaborador con el fin de operar la plataforma y garantizar el servicio.',
                      ),

                      _buildSectionTitle('2. Información recopilada'),
                      _buildBulletPoint('Datos de la empresa'),
                      _buildBulletPoint('Información de contacto'),
                      _buildBulletPoint(
                        'Datos operativos (zonas, horarios, solicitudes)',
                      ),

                      _buildSectionTitle('3. Uso de la información'),
                      _buildSectionText('Los datos serán utilizados para:'),
                      _buildBulletPoint('Gestionar solicitudes'),
                      _buildBulletPoint('Mejorar la operación del servicio'),
                      _buildBulletPoint('Garantizar trazabilidad del proceso'),

                      _buildSectionTitle('4. Protección de datos'),
                      _buildSectionText(
                        'La información será tratada de forma confidencial y segura, conforme a la normativa vigente en protección de datos en Colombia',
                      ),

                      _buildSectionTitle('5. Derechos del colaborador'),
                      _buildSectionText('El colaborador podrá:'),
                      _buildBulletPoint('Consultar sus datos'),
                      _buildBulletPoint('Actualizar información'),
                      _buildBulletPoint('Solicitar eliminación de datos'),

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

  Widget _buildSectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          height: 1.5,
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
