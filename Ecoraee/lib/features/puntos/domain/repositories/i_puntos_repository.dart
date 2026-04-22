import '../entities/puntos_entity.dart';

abstract class IPuntosRepository {
  Future<PuntosResumenEntity> obtenerResumen();
  Future<List<RecompensaEntity>> obtenerRecompensas();
  Future<List<HistorialPuntosEntity>> obtenerHistorial();
  Future<void> canjearRecompensa(String recompensaId);
}
