import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/puntos_entity_ing.dart';
import '../repositories/puntos_repository.dart';

class GetPuntosUsecase {
  final PuntosRepository _repository;
  GetPuntosUsecase(this._repository);

  Future<Either<Failure, PuntosEntityIng>> call() {
    return _repository.getPuntos();
  }
}