import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';

/// Barra de progreso hacia la próxima recompensa
class ProgresoPuntosBar extends StatelessWidget {
  final double progreso; // 0.0 a 1.0
  final int puntosFaltantes;

  const ProgresoPuntosBar({
    super.key,
    required this.progreso,
    required this.puntosFaltantes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barra de progreso
        Container(
          height: 14,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(7),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    width: constraints.maxWidth * progreso,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF8BC34A),
                          CicloxColors.primary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Texto descriptivo
        Text(
          'Te faltan $puntosFaltantes puntos para tu próxima recompensa',
          style: const TextStyle(
            fontSize: 12,
            color: CicloxColors.grey,
          ),
        ),
      ],
    );
  }
}
