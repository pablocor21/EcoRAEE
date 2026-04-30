import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/movimiento_entity.dart';

/// Widget de timeline individual para cada movimiento de trazabilidad.
/// Muestra un círculo de color + línea vertical a la izquierda,
/// y una tarjeta con la info del movimiento a la derecha.
class TimelineTileWidget extends StatelessWidget {
  final MovimientoEntity movimiento;
  final bool isFirst;
  final bool isLast;
  final bool isActive;

  const TimelineTileWidget({
    super.key,
    required this.movimiento,
    required this.isFirst,
    required this.isLast,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? const Color(0xFFFFA726) // ámbar para el activo
        : CicloxColors.primary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Columna izquierda: línea + círculo ──
          SizedBox(
            width: 48,
            child: Column(
              children: [
                // Línea superior
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 12,
                    color: CicloxColors.grey.withOpacity(0.3),
                  )
                else
                  const SizedBox(height: 12),

                // Círculo con icono
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isActive
                        ? color.withOpacity(0.2)
                        : color.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: color.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      movimiento.tipo.icono,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                // Línea inferior
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: CicloxColors.grey.withOpacity(0.3),
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // ── Tarjeta derecha ──
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isActive
                    ? color.withOpacity(0.08)
                    : CicloxColors.greyLight,
                borderRadius: BorderRadius.circular(16),
                border: isActive
                    ? Border(left: BorderSide(color: color, width: 3))
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movimiento.tipo.label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: isActive
                          ? const Color(0xFFE65100)
                          : CicloxColors.dark,
                    ),
                  ),
                  if (movimiento.descripcion != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      movimiento.descripcion!,
                      style: TextStyle(
                        fontSize: 13,
                        color: CicloxColors.grey.withOpacity(0.9),
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 14,
                        color: CicloxColors.grey.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movimiento.responsableNombre,
                        style: TextStyle(
                          fontSize: 12,
                          color: CicloxColors.grey.withOpacity(0.8),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: CicloxColors.grey.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatFecha(movimiento.fecha),
                        style: TextStyle(
                          fontSize: 12,
                          color: CicloxColors.grey.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatFecha(DateTime fecha) {
    final meses = [
      '',
      'ene',
      'feb',
      'mar',
      'abr',
      'may',
      'jun',
      'jul',
      'ago',
      'sep',
      'oct',
      'nov',
      'dic',
    ];
    final hora =
        '${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}';
    return '${fecha.day} ${meses[fecha.month]} · $hora';
  }
}
