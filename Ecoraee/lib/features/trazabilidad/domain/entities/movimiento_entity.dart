import 'tipo_movimiento.dart';

/// Entidad de dominio que representa un movimiento en la trazabilidad
/// de un dispositivo RAEE.
class MovimientoEntity {
  final int id;
  final TipoMovimiento tipo;
  final String? descripcion;
  final String? ubicacionOrigen;
  final String? ubicacionDestino;
  final double? latitud;
  final double? longitud;
  final String? evidenciaUrl;
  final String responsableNombre;
  final DateTime fecha;

  const MovimientoEntity({
    required this.id,
    required this.tipo,
    this.descripcion,
    this.ubicacionOrigen,
    this.ubicacionDestino,
    this.latitud,
    this.longitud,
    this.evidenciaUrl,
    required this.responsableNombre,
    required this.fecha,
  });
}
