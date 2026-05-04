// home_empresa_page.dart
// Página de home para empresas — redirige al DashboardScreen de colaborador.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';

class HomeEmpresaPage extends StatelessWidget {
  const HomeEmpresaPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Las empresas usan el DashboardScreen principal
      context.go(AppRoutes.homeEmpresa);
    });

    return const Scaffold(
      backgroundColor: Color(0xFF19133B),
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFFB2F333)),
      ),
    );
  }
}
