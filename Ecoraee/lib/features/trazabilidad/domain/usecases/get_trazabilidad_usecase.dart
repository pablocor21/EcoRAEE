import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/movimiento_entity_ing.dart';
import '../repositories/trazabilidad_repository.dart';

class GetTrazabilidadUsecase {
  final TrazabilidadRepository _repository;
  GetTrazabilidadUsecase(this._repository);

  Future<Either<Failure, List<MovimientoEntityIng>>> call(int dispositivoId) {
    return _repository.getTrazabilidadDispositivo(dispositivoId);
  }
}
