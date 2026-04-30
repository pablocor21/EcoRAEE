import 'package:flutter/material.dart';
import '../../domain/entities/puntos_entity.dart';

/// Ítem individual del historial de puntos
class HistorialPuntosItem extends StatelessWidget {
  final HistorialPuntosEntity item;

  const HistorialPuntosItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final esPositivo = item.esPositivo;
    final signo = esPositivo ? '+' : '';
    final color = esPositivo
        ? const Color(0xFF2E7D32)
        : const Color(0xFFD32F2F);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        '$signo${item.puntos} pts ${item.descripcion}',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
