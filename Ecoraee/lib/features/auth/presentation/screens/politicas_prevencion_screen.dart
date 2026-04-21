import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';

// ─────────────────────────────────────────────
// POLÍTICAS DE PREVENCIÓN SCREEN
// ─────────────────────────────────────────────
class PoliticasPrevencionScreen extends StatelessWidget {
  const PoliticasPrevencionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CicloxLogo(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      size: 28,
                      color: CicloxColors.dark,
                    ),
                  ),
                ],
              ),
            ),

            // ── Contenido ─────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título con flecha
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: CicloxColors.dark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Políticas de\nprevención',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: CicloxColors.dark,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // ── Sección 1 ──────────────────────
                    _PolicySection(
                      number: '1',
                      title: 'Objetivo',
                      body: 'Estas políticas buscan prevenir:',
                      bullets: const [
                        'Fraudes',
                        'Uso indebido de la aplicación',
                        'Manipulación del sistema de puntos y beneficios',
                        'Información falsa en los procesos de reciclaje',
                      ],
                      criterion:
                          'Todo comportamiento sospechoso será monitoreado y evaluado automáticamente por el sistema.',
                    ),
                    const SizedBox(height: 20),

                    // ── Sección 2 ──────────────────────
                    _PolicySection(
                      number: '2',
                      title: 'Prevención de información falsa',
                      body: 'El usuario debe ingresar información real en:',
                      bullets: const [
                        'Registro de cuenta',
                        'Datos personales',
                        'Solicitudes de reciclaje',
                      ],
                      criterion:
                          '• Si se detectan datos falsos la solicitud es rechazada.\n'
                          '• Si el comportamiento se repite suspensión de la cuenta.\n'
                          '• Si es grave eliminación permanente.',
                    ),
                    const SizedBox(height: 20),

                    // ── Sección 3 ──────────────────────
                    _PolicySection(
                      number: '3',
                      title: 'Validación del reciclaje',
                      body: 'Para evitar fraudes en el sistema:',
                      bullets: const [
                        'Las solicitudes pueden ser verificadas',
                        'Se puede validar el dispositivo entregado',
                      ],
                      criterion:
                          'Si el dispositivo no coincide con lo registrado no se asignan puntos.\n'
                          'Si hay intento de engaño bloqueo temporal.\n'
                          'Reincidencia cancelación de la cuenta.',
                    ),
                    const SizedBox(height: 36),

                    // ── Botón Reportar ─────────────────
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CicloxColors.dark,
                          foregroundColor: CicloxColors.white,
                          minimumSize: const Size(double.infinity, 54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text('Reportar problema'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SECCIÓN DE POLÍTICA
// ─────────────────────────────────────────────
class _PolicySection extends StatelessWidget {
  final String number;
  final String title;
  final String body;
  final List<String> bullets;
  final String criterion;

  const _PolicySection({
    required this.number,
    required this.title,
    required this.body,
    required this.bullets,
    required this.criterion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado numerado
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 15,
              color: CicloxColors.dark,
            ),
            children: [
              TextSpan(
                text: '$number. ',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text: title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
            fontSize: 14,
            color: CicloxColors.dark,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        // Bullets
        ...bullets.map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              '• $b',
              style: const TextStyle(
                fontSize: 14,
                color: CicloxColors.dark,
                height: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        // Criterio
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              color: CicloxColors.dark,
              height: 1.5,
            ),
            children: [
              const TextSpan(
                text: 'Criterio:\n',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: criterion),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// LOGO CICLOX (reutilizado localmente)
// ─────────────────────────────────────────────
class _CicloxLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
        ),
        children: [
          TextSpan(
            text: 'ci',
            style: TextStyle(color: CicloxColors.dark),
          ),
          TextSpan(
            text: 'cl',
            style: TextStyle(color: CicloxColors.primary),
          ),
          TextSpan(
            text: 'ox',
            style: TextStyle(color: CicloxColors.dark),
          ),
        ],
      ),
    );
  }
}
