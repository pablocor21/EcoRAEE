class AppConstants {
  // Nombre de la app
  static const String appName = 'Ciclox';
  static const String appSlogan = 'Transforma · Recupera · Reintegra';

  // Storage keys
  static const String jwtKey = 'jwt_token';
  static const String userKey = 'user_data';
  static const String rolKey = 'user_rol';

  // Roles
  static const String rolCiudadano = 'CIUDADANO';
  static const String rolAdmin = 'ADMIN';

  // Timeouts
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;
}
