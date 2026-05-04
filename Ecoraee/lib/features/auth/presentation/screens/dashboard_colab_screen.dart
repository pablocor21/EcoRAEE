// dashboard_colab_screen.dart
// Archivo puente: redirige al dashboard de colaborador (DashboardScreen).
// El app_router.dart lo importa bajo la ruta '/dashboard-colaborador' (legacy).
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/router/app_router.dart';

class DashboardColabScreen extends StatelessWidget {
  const DashboardColabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(AppRoutes.dashboardCiudadano);
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
