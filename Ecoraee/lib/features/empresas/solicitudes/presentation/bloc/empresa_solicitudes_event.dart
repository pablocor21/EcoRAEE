import 'package:equatable/equatable.dart';

abstract class EmpresaSolicitudesEvent extends Equatable {
  const EmpresaSolicitudesEvent();

  @override
  List<Object?> get props => [];
}

class LoadEmpresaSolicitudes extends EmpresaSolicitudesEvent {
  final String? estado;

  const LoadEmpresaSolicitudes({this.estado});

  @override
  List<Object?> get props => [estado];
}

class AceptarEmpresaSolicitud extends EmpresaSolicitudesEvent {
  final int solicitudId;
  final int? colaboradorId;
  final String horaEstimadaInicio;
  final String horaEstimadaFin;
  final String? comentarioEmpresa;

  const AceptarEmpresaSolicitud({
    required this.solicitudId,
    this.colaboradorId,
    required this.horaEstimadaInicio,
    required this.horaEstimadaFin,
    this.comentarioEmpresa,
  });

  @override
  List<Object?> get props => [
        solicitudId,
        colaboradorId,
        horaEstimadaInicio,
        horaEstimadaFin,
        comentarioEmpresa,
      ];
}

class RechazarEmpresaSolicitud extends EmpresaSolicitudesEvent {
  final int solicitudId;
  final String motivo;

  const RechazarEmpresaSolicitud({
    required this.solicitudId,
    required this.motivo,
  });

  @override
  List<Object?> get props => [solicitudId, motivo];
}

class MarcarSolicitudEnTransito extends EmpresaSolicitudesEvent {
  final int solicitudId;
  final double? latitudColaborador;
  final double? longitudColaborador;
  final int? tiempoEstimadoMinutos;

  const MarcarSolicitudEnTransito({
    required this.solicitudId,
    this.latitudColaborador,
    this.longitudColaborador,
    this.tiempoEstimadoMinutos,
  });

  @override
  List<Object?> get props => [
        solicitudId,
        latitudColaborador,
        longitudColaborador,
        tiempoEstimadoMinutos,
      ];
}

class MarcarSolicitudRecolectada extends EmpresaSolicitudesEvent {
  final int solicitudId;
  final int puntosOtorgados;
  final String? evidenciaUrl;

  const MarcarSolicitudRecolectada({
    required this.solicitudId,
    required this.puntosOtorgados,
    this.evidenciaUrl,
  });

  @override
  List<Object?> get props => [solicitudId, puntosOtorgados, evidenciaUrl];
}
