import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/puntos_entity.dart';

/// Tarjeta de recompensa individual
class RecompensaCard extends StatelessWidget {
  final RecompensaEntity recompensa;
  final VoidCallback onVerDetalles;

  const RecompensaCard({
    super.key,
    required this.recompensa,
    required this.onVerDetalles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CicloxColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icono
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: CicloxColors.greyLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                _getIconData(recompensa.icono),
                size: 28,
                color: CicloxColors.dark,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Nombre
          Text(
            recompensa.nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: CicloxColors.dark,
            ),
          ),
          const SizedBox(height: 4),
          // Descripción
          Text(
            recompensa.descripcion,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: CicloxColors.grey,
            ),
          ),
          const SizedBox(height: 14),
          // Botón "Ver detalles"
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: onVerDetalles,
              style: ElevatedButton.styleFrom(
                backgroundColor: CicloxColors.dark,
                foregroundColor: CicloxColors.white,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Ver detalles'),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String icono) {
    switch (icono) {
      case 'celular':
        return Icons.phone_android_rounded;
      case 'mercado':
        return Icons.storefront_rounded;
      default:
        return Icons.card_giftcard_rounded;
    }
  }
}
