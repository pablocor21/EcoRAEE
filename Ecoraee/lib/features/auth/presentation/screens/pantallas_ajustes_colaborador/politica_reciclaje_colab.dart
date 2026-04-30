import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/router/app_router.dart';

class PoliticaReciclajeColabScreen extends StatelessWidget {
  const PoliticaReciclajeColabScreen({super.key});

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
                      'POLÍTICA DE\nRECICLAJE',
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
                        '3. POLÍTICA DE RECICLAJE (COLABORADOR)',
                        style: TextStyle(
                          color: Color(0xFF19133B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      
                      _buildSectionTitle('1. Compromiso ambiental'),
                      _buildSectionText(
                        'El colaborador se compromete a realizar la gestión de residuos electrónicos de forma responsable y sostenible.'
                      ),

                      _buildSectionTitle('2. Manejo de RAEE'),
                      _buildBulletPoint('Clasificación adecuada de los dispositivos'),
                      _buildBulletPoint('Separación de componentes'),
                      _buildBulletPoint('Disposición en centros autorizados'),
                      const SizedBox(height: 10),
                      _buildSectionText(
                        'Los residuos electrónicos deben ser tratados correctamente para evitar impactos negativos en el medio ambiente',
                        isItalic: true
                      ),

                      _buildSectionTitle('3. Trazabilidad'),
                      _buildBulletPoint('Cada solicitud debe ser registrada'),
                      _buildBulletPoint('El proceso debe ser verificable'),
                      _buildBulletPoint('Se deben actualizar estados en la plataforma'),

                      _buildSectionTitle('4. Prohibiciones'),
                      _buildBulletPoint('Disposición inadecuada de residuos'),
                      _buildBulletPoint('Manipulación ilegal de componentes'),
                      _buildBulletPoint('Desvío de materiales fuera del proceso autorizado'),

                      _buildSectionTitle('5. Validación del proceso'),
                      _buildSectionText('CICLOX podrá:'),
                      _buildBulletPoint('Auditar procesos'),
                      _buildBulletPoint('Validar entregas'),
                      _buildBulletPoint('Solicitar evidencias'),
                      
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

  Widget _buildSectionText(String text, {bool isItalic = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
          height: 1.5,
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
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
