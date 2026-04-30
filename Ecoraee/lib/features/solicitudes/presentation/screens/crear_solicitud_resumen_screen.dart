import '../../../../config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';

class CrearSolicitudResumenScreen extends StatelessWidget {
  const CrearSolicitudResumenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CicloxLogo(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      size: 28,
                      color: CicloxColors.dark,
                    ),
                  ),
                ],
              ),
            ),

            // ── Contenido ─────────────────────
            Expanded(
              child: Column(
                children: [
                  // Título con botón de retroceso
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back, color: CicloxColors.dark),
                        ),
                        const Expanded(
                          child: Text(
                            'Dispositivos registrados',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: CicloxColors.dark,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          // Icono de alerta
                          const Icon(
                            Icons.warning_rounded,
                            color: Color(0xFFE5392A), // Rojo similar a la imagen
                            size: 100,
                          ),
                          const SizedBox(height: 20),
                          
                          // Mensaje de verificación
                          const Text(
                            'Verifica que toda la información\nesté correcta antes de enviar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: CicloxColors.dark,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Dispositivos seleccionados
                          const Text(
                            'Dispositivos seleccionados',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: CicloxColors.dark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Iphone11',
                            style: TextStyle(
                              fontSize: 16,
                              color: CicloxColors.dark.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Información de contacto
                          const Text(
                            'Información',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: CicloxColors.dark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Dirección: Cra 45 #10-23\nCiudad: Medellín\nTeléfono: 300 xxx xxxx\nCorreo: ejemplo@gmail.com',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: CicloxColors.dark.withOpacity(0.8),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),

                  // Botón Confirmar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 10, 60, 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/solicitud-enviada');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CicloxColors.dark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CicloxColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: 1,
        onTap: (i) {
          if (i == 0) { context.push(AppRoutes.ajustesColaborador); } else if (i == 1) {
            context.go('/dashboard');
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LOGO CICLOX PERSONALIZADO
// ─────────────────────────────────────────────
class _CicloxLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
        ),
        children: [
          TextSpan(
            text: 'ci',
            style: TextStyle(color: CicloxColors.dark),
          ),
          TextSpan(
            text: 'cl',
            style: TextStyle(color: CicloxColors.primary),
          ),
          TextSpan(
            text: 'ox',
            style: TextStyle(color: CicloxColors.dark),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BOTTOM NAVIGATION BAR
// ─────────────────────────────────────────────
class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _BottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: CicloxColors.white,
        border: Border(
          top: BorderSide(
            color: CicloxColors.dark.withOpacity(0.08),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.settings_outlined,
            index: 0,
            selectedIndex: selectedIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.home_rounded,
            index: 1,
            selectedIndex: selectedIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.star_border_rounded,
            index: 2,
            selectedIndex: selectedIndex,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _NavItem({
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? CicloxColors.dark : CicloxColors.dark.withOpacity(0.45),
        ),
      ),
    );
  }
}
