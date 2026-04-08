abstract class IAuthRepository {
  Future<String> signIn(String email, String contrasena);
  Future<void> register({
    required String nombre,
    required String email,
    required String contrasena,
    required String direccion,
    required String telefono,
  });
  Future<void> signOut(String token);
  Future<void> cambiarContrasena({
    required String email,
    required String contrasenaActual,
    required String contrasenaNueva,
  });

  Future<void> actualizarUsuario({
    required String nombre,
    required String email,
    required String telefono,
    required String direccion,
  });

  // Recuperación de contraseña
  Future<void> solicitarCodigoRecuperacion(String email);
  Future<void> validarCodigoRecuperacion({
    required String email,
    required String codigo,
  });
  Future<void> establecerNuevaContrasena({
    required String email,
    required String codigo,
    required String contrasenaNueva,
  });
}
