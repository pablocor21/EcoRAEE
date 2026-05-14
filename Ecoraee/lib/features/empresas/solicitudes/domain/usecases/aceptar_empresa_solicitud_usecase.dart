import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../repositories/empresa_solicitudes_repository.dart';

class AceptarEmpresaSolicitudUsecase {
  final EmpresaSolicitudesRepository _repository;

  AceptarEmpresaSolicitudUsecase(this._repository);

  Future<Either<Failure, void>> call({
    required int id,
    int? colaboradorId,
    required String horaEstimadaInicio,
    required String horaEstimadaFin,
    String? comentarioEmpresa,
  }) {
    return _repository.aceptarSolicitud(
      id: id,
      colaboradorId: colaboradorId,
      horaEstimadaInicio: horaEstimadaInicio,
      horaEstimadaFin: horaEstimadaFin,
      comentarioEmpresa: comentarioEmpresa,
    );
  }
}
