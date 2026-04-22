class PuntosResumenEntity {
  final int puntosActuales;
  final int puntosSiguienteRecompensa;

  const PuntosResumenEntity({
    required this.puntosActuales,
    required this.puntosSiguienteRecompensa,
  });

  double get progreso {
    if (puntosSiguienteRecompensa <= 0) return 1.0;
    final total = puntosActuales + puntosSiguienteRecompensa;
    return (puntosActuales / total).clamp(0.0, 1.0);
  }
}

class RecompensaEntity {
  final String id;
  final String nombre;
  final String descripcion;
  final int costoPuntos;
  final String icono; // 'celular', 'mercado', etc.
  // Campos para la pantalla de detalle
  final String? descripcionDetalle;
  final String? valorBono;
  final List<AliadoEntity> aliados;
  final List<String> pasos;

  const RecompensaEntity({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.costoPuntos,
    this.icono = 'default',
    this.descripcionDetalle,
    this.valorBono,
    this.aliados = const [],
    this.pasos = const [],
  });
}

class AliadoEntity {
  final String nombre;
  final String icono; // 'exito', 'jumbo', etc.

  const AliadoEntity({
    required this.nombre,
    this.icono = 'default',
  });
}


class HistorialPuntosEntity {
  final String id;
  final int puntos; // positivo = ganado, negativo = canjeado
  final String descripcion;
  final DateTime fecha;

  const HistorialPuntosEntity({
    required this.id,
    required this.puntos,
    required this.descripcion,
    required this.fecha,
  });

  bool get esPositivo => puntos >= 0;
}
