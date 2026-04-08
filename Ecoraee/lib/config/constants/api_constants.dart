class ApiConstants {
  //static const String baseUrl = 'http://10.0.2.2:8080'; // Android emulator

  static const String baseUrl = 'http://localhost:8080'; // iOS / web

  // Auth
  static const String register = '/auth/register';
  static const String signIn = '/auth/sign-in';
  static const String signOut = '/auth/sign-out';
  static const String cambiarContrasena = '/auth/cambiar-contrasena';

  // Recuperación de contraseña
  static const String solicituarRecuperacion = '/auth/recuperacion/solicitar';
  static const String validarCodigoRecuperacion = '/auth/recuperacion/validar';
  static const String nuevaContrasenaRecuperacion =
      '/auth/recuperacion/nueva-contrasena';

  // Usuarios
  static const String customers = '/customers';
  static const String actualizarCustomer = '/customers/actualizar';

  // Dispositivos
  static const String dispositivos = '/dispositivos';

  // Solicitudes
  static const String solicitudes = '/solicitudes';

  // Puntos de recolección
  static const String puntos = '/puntos';

  // Archivos
  static const String archivos = '/archivos/subir';
}
