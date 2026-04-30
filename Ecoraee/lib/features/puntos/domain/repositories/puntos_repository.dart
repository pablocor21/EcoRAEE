import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/puntos_entity_ing.dart';

abstract class PuntosRepository {
  Future<Either<Failure, PuntosEntityIng>> getPuntos();
  Future<Either<Failure, List<MovimientoPuntosEntity>>> getHistorialPuntos({
    int page = 1,
    int limit = 20,
  });
}