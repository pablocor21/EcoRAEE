import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movimiento_entity_ing.dart';

abstract class TrazabilidadRepository {
  Future<Either<Failure, List<MovimientoEntityIng>>> getTrazabilidadDispositivo(
    int dispositivoId,
  );

  Future<Either<Failure, UbicacionRecolectorEntity>> getUbicacionRecolector(
    int solicitudId,
  );
}
