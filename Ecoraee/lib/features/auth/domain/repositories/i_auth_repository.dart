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
}
