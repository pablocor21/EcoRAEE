import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../config/constants/app_constants.dart';
import '../../infractructure/repositories/auth_repository_impl.dart';

class AuthState {
  final String? token;
  final String? rol;
  final bool isLoading;
  final String? error;

  const AuthState({this.token, this.rol, this.isLoading = false, this.error});

  AuthState copyWith({
    String? token,
    String? rol,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      token: token ?? this.token,
      rol: rol ?? this.rol,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;
  final _storage = const FlutterSecureStorage();

  AuthNotifier(this._ref) : super(const AuthState()) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await _storage.read(key: AppConstants.jwtKey);
    final rol = await _storage.read(key: AppConstants.rolKey);
    if (state.token == null && token != null) {
      state = state.copyWith(token: token, rol: rol);
    }
  }

  Future<bool> signIn(String email, String contrasena) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(authRepositoryProvider);
      final token = await repo.signIn(email, contrasena);

      // Decodifica el rol del JWT (parte central en base64)
      final parts = token.split('.');
      if (parts.length == 3) {
        final payload = String.fromCharCodes(
          Uri.parse(
            'data:application/octet-stream;base64,${parts[1]}',
          ).data!.contentAsBytes(),
        );
        final rolMatch = RegExp(r'"rol":"(\w+)"').firstMatch(payload);
        final rol = rolMatch?.group(1) ?? AppConstants.rolCiudadano;

        await _storage.write(key: AppConstants.jwtKey, value: token);
        await _storage.write(key: AppConstants.rolKey, value: rol);
        state = state.copyWith(token: token, rol: rol, isLoading: false);
      }
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> register({
    required String nombre,
    required String email,
    required String contrasena,
    required String direccion,
    required String telefono,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(authRepositoryProvider);
      await repo.register(
        nombre: nombre,
        email: email,
        contrasena: contrasena,
        direccion: direccion,
        telefono: telefono,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      final repo = _ref.read(authRepositoryProvider);
      await repo.signOut(state.token ?? '');
    } finally {
      await _storage.deleteAll();
      state = const AuthState();
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
