import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/router/app_router.dart';

class AjustesColabScreen extends StatelessWidget {
  const AjustesColabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF0),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Logo area
            Center(
              child: Image.asset(
                'assets/imagenes/LOGO PRINCIPAL AZUL.png',
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),

            // Title
            const Text(
              'CONFIGURACIÓN',
              style: TextStyle(
                color: CicloxColors.dark,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 20),

            // List of items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                children: [
                  _SettingsItem(
                    icon: Icons.account_circle,
                    label: 'Ajustes del perfil',
                    onTap: () =>
                        context.push(AppRoutes.ajustesPerfilColaborador),
                  ),
                  _SettingsItem(
                    icon: Icons.work,
                    label: 'Datos de la empresa',
                    onTap: () =>
                        context.push(AppRoutes.datosEmpresaColaborador),
                  ),
                  _SettingsItem(
                    icon: Icons.location_on,
                    label: 'Zonas de cobertura',
                    onTap: () {},
                  ),
                  _SettingsItem(
                    icon: Icons.notifications,
                    label: 'Notificaciones',
                    onTap: () => context.push(
                      AppRoutes.ajustesNotificacionesColaborador,
                    ),
                  ),
                  _SettingsItem(
                    icon: Icons.warning_rounded,
                    label: 'Soporte',
                    onTap: () => context.push(AppRoutes.soporteColaborador),
                  ),
                  _SettingsItem(
                    icon: Icons.lock,
                    label: 'Políticas',
                    onTap: () => context.push(AppRoutes.politicasColaborador),
                  ),

                  const SizedBox(height: 30),

                  // Accessibility button
                  ElevatedButton(
                    onPressed: () =>
                        context.push(AppRoutes.accesibilidadColaborador),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: CicloxColors.dark,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Accesibilidad',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
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
            const Icon(
              Icons.settings_rounded,
              color: Color(0xFF19133B),
              size: 28,
            ), // active
          ],
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          leading: Icon(icon, color: CicloxColors.dark, size: 24),
          title: Text(
            label,
            style: const TextStyle(
              color: CicloxColors.dark,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: CicloxColors.dark,
            size: 24,
          ),
          onTap: onTap,
        ),
        Divider(color: Colors.grey.withOpacity(0.3), height: 1),
      ],
    );
  }
}
