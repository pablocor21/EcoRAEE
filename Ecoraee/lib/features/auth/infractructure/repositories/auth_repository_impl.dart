import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/constants/api_constants.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../dio_client.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(dioProvider));
});

class AuthRepositoryImpl implements IAuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<String> signIn(String email, String contrasena) async {
    try {
      final response = await _dio.post(
        ApiConstants.signIn,
        data: {'email': email, 'contrasena': contrasena},
      );
      return response.data['jwt'] as String;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> register({
    required String nombre,
    required String email,
    required String contrasena,
    required String direccion,
    required String telefono,
  }) async {
    try {
      await _dio.post(
        ApiConstants.register,
        data: {
          'nombre': nombre,
          'email': email,
          'contrasena': contrasena,
          'direccion': direccion,
          'telefono': telefono,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> signOut(String token) async {
    try {
      await _dio.post(ApiConstants.signOut);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> cambiarContrasena({
    required String email,
    required String contrasenaActual,
    required String contrasenaNueva,
  }) async {
    try {
      await _dio.post(
        ApiConstants.cambiarContrasena,
        data: {
          'email': email,
          'contrasenaActual': contrasenaActual,
          'contrasenaNueva': contrasenaNueva,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return 'Datos inválidos';
      case 401:
        return 'Credenciales incorrectas';
      case 403:
        return 'No tienes permisos';
      case 409:
        return 'El usuario ya existe';
      default:
        return 'Error de conexión. Intenta de nuevo.';
    }
  }
}
