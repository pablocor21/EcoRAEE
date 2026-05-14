import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../repositories/empresa_solicitudes_repository.dart';

class MarcarEnTransitoEmpresaSolicitudUsecase {
  final EmpresaSolicitudesRepository _repository;

  MarcarEnTransitoEmpresaSolicitudUsecase(this._repository);

  Future<Either<Failure, void>> call({
    required int id,
    double? latitudColaborador,
    double? longitudColaborador,
    int? tiempoEstimadoMinutos,
  }) {
    return _repository.marcarEnTransito(
      id: id,
      latitudColaborador: latitudColaborador,
      longitudColaborador: longitudColaborador,
      tiempoEstimadoMinutos: tiempoEstimadoMinutos,
    );
  }
}
