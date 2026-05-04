import 'package:equatable/equatable.dart';

class UsuarioEntityIng extends Equatable {
  final int id;
  final String nombre;
  final String email;
  final String rol; // 'USUARIO' | 'EMPRESA'
  final bool activo;

  const UsuarioEntityIng({
    required this.id,
    required this.nombre,
    required this.email,
    required this.rol,
    required this.activo,
  });

  bool get esEmpresa => rol == 'EMPRESA' || rol == 'COLABORADOR';

  @override
  List<Object?> get props => [id, email, rol];
}
