import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/router/app_router.dart';

class DatosDeLaEmpresaColabScreen extends StatelessWidget {
  const DatosDeLaEmpresaColabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF0),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Customizado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: CicloxColors.dark,
                      size: 20,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'DATOS DE LA EMPRESA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CicloxColors.dark,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ), // Balance para el icono de regresar
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Contenedor principal estilo tarjeta
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Logo de la empresa
                    Center(
                      child: Image.asset(
                        'assets/imagenes/LOGO PRINCIPAL COLOR.png',
                        height: 100, // Ajustado para que se vea bien
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Lista de Información de la Empresa
                    const _CompanyInfoRow(
                      icon: Icons.account_circle,
                      text: 'Razón social: Ciclox',
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E5E5)),

                    const _CompanyInfoRow(
                      icon: Icons.hub, // o Icons.tag
                      text: 'NIT: 2466658789-2',
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E5E5)),

                    const _CompanyInfoRow(
                      icon: Icons.location_on,
                      text: 'Dirección: Av 80 # 2a - 31',
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E5E5)),

                    const _CompanyInfoRow(
                      icon: Icons.smartphone,
                      text: '3125894102 - 604-2568745',
                    ),
                    const Divider(height: 1, color: Color(0xFFE5E5E5)),

                    const _CompanyInfoRow(
                      icon: Icons.alternate_email,
                      text: 'bienestarcx@ciclox.co',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => context.go(AppRoutes.dashboardCiudadano),
              child: const Icon(
                Icons.home_filled,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.soporteColaborador),
              child: const Icon(
                Icons.warning_rounded,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.solicitudes),
              child: const Icon(
                Icons.local_shipping,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.notificacionesColaborador),
              child: const Icon(
                Icons.notifications_rounded,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
            GestureDetector(
              onTap: () => context.go(
                AppRoutes.ajustesColaborador,
              ), // Llevando a Ajustes Colaborador
              child: const Icon(
                Icons.settings_rounded,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _CompanyInfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF19133B), size: 26),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
