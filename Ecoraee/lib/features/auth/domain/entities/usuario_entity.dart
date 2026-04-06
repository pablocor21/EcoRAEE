class UsuarioEntity {
  final int? id;
  final String nombre;
  final String email;
  final String? telefono;
  final String? direccion;
  final String? rol;
  final bool? activo;

  const UsuarioEntity({
    this.id,
    required this.nombre,
    required this.email,
    this.telefono,
    this.direccion,
    this.rol,
    this.activo,
  });
}
