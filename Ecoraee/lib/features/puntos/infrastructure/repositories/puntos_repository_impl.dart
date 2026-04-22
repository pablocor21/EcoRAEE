import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/puntos_entity.dart';
import '../../domain/repositories/i_puntos_repository.dart';
import '../../../auth/dio_client.dart';

final puntosRepositoryProvider = Provider<IPuntosRepository>((ref) {
  return PuntosRepositoryImpl(ref.read(dioProvider));
});

class PuntosRepositoryImpl implements IPuntosRepository {
  final Dio _dio;

  PuntosRepositoryImpl(this._dio);

  @override
  Future<PuntosResumenEntity> obtenerResumen() async {
    // TODO: Conectar con endpoint real cuando esté disponible
    // final response = await _dio.get('/puntos/resumen');
    await Future.delayed(const Duration(milliseconds: 300));
    return const PuntosResumenEntity(
      puntosActuales: 3500,
      puntosSiguienteRecompensa: 1350,
    );
  }

  @override
  Future<List<RecompensaEntity>> obtenerRecompensas() async {
    // TODO: Conectar con endpoint real cuando esté disponible
    // final response = await _dio.get('/puntos/recompensas');
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      RecompensaEntity(
        id: '1',
        nombre: 'Bono Ciclox',
        descripcion: 'Descuento en tecnología',
        costoPuntos: 600,
        icono: 'celular',
        descripcionDetalle: 'Por cada 600 puntos puedes obtener 30%\nde descuento en productos tecnológicos',
        valorBono: '30%',
        aliados: [
          AliadoEntity(nombre: 'MovilClick', icono: 'movilclick'),
          AliadoEntity(nombre: 'Turing', icono: 'turing'),
        ],
        pasos: [
          'Elige la recompensa que quieres',
          'Da clic en Canjear',
          'Recibe tu código QR o Código',
          'Muéstralo en el punto de pago del aliado',
        ],
      ),
      RecompensaEntity(
        id: '2',
        nombre: 'Mercaditos',
        descripcion: 'Descuentos en supermercados',
        costoPuntos: 5000,
        icono: 'mercado',
        descripcionDetalle: 'Por cada 5000 puntos que acumules,\nPuedes redimir un bono de \$20.000.',
        valorBono: '\$20.000',
        aliados: [
          AliadoEntity(nombre: 'Éxito', icono: 'exito'),
          AliadoEntity(nombre: 'Jumbo', icono: 'jumbo'),
        ],
        pasos: [
          'Elige la recompensa que quieres',
          'Da clic en Canjear',
          'Recibe tu código QR o Código',
          'Muéstralo en el punto de pago del aliado',
        ],
      ),
    ];
  }

  @override
  Future<List<HistorialPuntosEntity>> obtenerHistorial() async {
    // TODO: Conectar con endpoint real cuando esté disponible
    // final response = await _dio.get('/puntos/historial');
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      HistorialPuntosEntity(
        id: '1',
        puntos: 1500,
        descripcion: 'Reciclaje Celular',
        fecha: DateTime.now().subtract(const Duration(days: 2)),
      ),
      HistorialPuntosEntity(
        id: '2',
        puntos: -7000,
        descripcion: 'Bono Ciclox',
        fecha: DateTime.now().subtract(const Duration(days: 5)),
      ),
      HistorialPuntosEntity(
        id: '3',
        puntos: 1600,
        descripcion: 'Reciclaje Televisor',
        fecha: DateTime.now().subtract(const Duration(days: 10)),
      ),
      HistorialPuntosEntity(
        id: '4',
        puntos: 150,
        descripcion: 'Reciclaje Batería',
        fecha: DateTime.now().subtract(const Duration(days: 15)),
      ),
    ];
  }

  @override
  Future<void> canjearRecompensa(String recompensaId) async {
    // TODO: Conectar con endpoint real cuando esté disponible
    // await _dio.post('/puntos/canjear', data: {'recompensaId': recompensaId});
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
