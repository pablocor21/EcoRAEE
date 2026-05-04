// login_screen.dart
// Archivo puente: redirige a la pantalla de selección de rol.
// El app_router.dart lo importa bajo la ruta '/login' (legacy).
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/router/app_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Si alguien navega a /login directamente, lo llevamos a la selección de rol.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(AppRoutes.seleccionRol);
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
