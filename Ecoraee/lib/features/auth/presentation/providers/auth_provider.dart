import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../config/constants/app_constants.dart';
import '../../infractructure/repositories/auth_repository_impl.dart';

class AuthState {
  final String? token;
  final String? rol;
  final String? nombre;
  final String? email;
  final String? telefono;
  final String? direccion;
  final bool isLoading;
  final bool? _isInitialized;
  final String? error;

  bool get isInitialized => _isInitialized ?? false;

  const AuthState({
    this.token,
    this.rol,
    this.nombre,
    this.email,
    this.telefono,
    this.direccion,
    this.isLoading = false,
    bool? isInitialized,
    this.error,
  }) : _isInitialized = isInitialized;

  AuthState copyWith({
    String? token,
    String? rol,
    String? nombre,
    String? email,
    String? telefono,
    String? direccion,
    bool? isLoading,
    bool? isInitialized, // ← NUEVO
    String? error,
  }) {
    return AuthState(
      token: token ?? this.token,
      rol: rol ?? this.rol,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      direccion: direccion ?? this.direccion,
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this._isInitialized ?? false, // ← NUEVO
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
    final nombre = await _storage.read(key: 'nombre');
    final email = await _storage.read(key: 'email');
    final telefono = await _storage.read(key: 'telefono');
    final direccion = await _storage.read(key: 'direccion');

    // Siempre marca como inicializado, con o sin token
    state = state.copyWith(
      token: token,
      rol: rol,
      nombre: nombre,
      email: email,
      telefono: telefono,
      direccion: direccion,
      isInitialized: true, // ← NUEVO
    );
  }

  Future<bool> cambiarContrasena({
    required String email,
    required String contrasenaActual,
    required String contrasenaNueva,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(authRepositoryProvider);
      await repo.cambiarContrasena(
        email: email,
        contrasenaActual: contrasenaActual,
        contrasenaNueva: contrasenaNueva,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> actualizarUsuario({
    required String nombre,
    required String email,
    required String telefono,
    required String direccion,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(authRepositoryProvider);
      await repo.actualizarUsuario(
        nombre: nombre,
        email: email,
        telefono: telefono,
        direccion: direccion,
      );
      state = state.copyWith(
        nombre: nombre,
        email: email,
        telefono: telefono,
        direccion: direccion,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> signIn(String email, String contrasena) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(authRepositoryProvider);
      final token = await repo.signIn(email, contrasena);

      final parts = token.split('.');
      if (parts.length == 3) {
        final payload = String.fromCharCodes(
          Uri.parse(
            'data:application/octet-stream;base64,${parts[1]}',
          ).data!.contentAsBytes(),
        );
        final rolMatch = RegExp(r'"rol":"(\w+)"').firstMatch(payload);
        final rol = rolMatch?.group(1) ?? AppConstants.rolCiudadano;
        final nombreMatch = RegExp(r'"nombre":"([^"]+)"').firstMatch(payload);
        final nombre = nombreMatch?.group(1) ?? '';

        await _storage.write(key: AppConstants.jwtKey, value: token);
        await _storage.write(key: AppConstants.rolKey, value: rol);
        await _storage.write(key: 'nombre', value: nombre);
        await _storage.write(key: 'email', value: email);

        state = state.copyWith(
          token: token,
          rol: rol,
          nombre: nombre,
          email: email,
          isLoading: false,
        );
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
      state = const AuthState(isInitialized: true); // ← mantener inicializado
    }
  }

  Future<bool> solicitarCodigoRecuperacion(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(authRepositoryProvider);
      await repo.solicitarCodigoRecuperacion(email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> validarCodigoRecuperacion({
    required String email,
    required String codigo,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(authRepositoryProvider);
      await repo.validarCodigoRecuperacion(email: email, codigo: codigo);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> establecerNuevaContrasena({
    required String email,
    required String codigo,
    required String contrasenaNueva,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(authRepositoryProvider);
      await repo.establecerNuevaContrasena(
        email: email,
        codigo: codigo,
        contrasenaNueva: contrasenaNueva,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
