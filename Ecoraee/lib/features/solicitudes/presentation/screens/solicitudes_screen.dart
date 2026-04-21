import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';

class SolicitudesScreen extends StatelessWidget {
  const SolicitudesScreen({super.key});

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tus\nSolicitudes',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: CicloxColors.dark,
                        height: 1.0,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Gestiona tus recogidas',
                      style: TextStyle(
                        fontSize: 18,
                        color: CicloxColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Tarjeta "Crear Solicitud"
                    GestureDetector(
                      onTap: () {
                        context.push('/crear-solicitud');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: CicloxColors.dark,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Crear\nSolicitud',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: CicloxColors.white,
                                height: 1.1,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tarjeta "Tus Solicitudes"
                    GestureDetector(
                      onTap: () {
                        context.push('/seguimiento-solicitudes');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: CicloxColors.white,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: CicloxColors.dark.withValues(alpha: 0.6),
                            width: 1.2,
                          ),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tus\nSolicitudes',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: CicloxColors.dark,
                                height: 1.1,
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: 1, // Marcar 'Home' como seleccionado, o dejar en -1
        onTap: (i) {
          if (i == 0) {
            context.go('/perfil');
          } else if (i == 1) {
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
            color: CicloxColors.dark.withValues(alpha: 0.08),
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
          color: isSelected ? CicloxColors.dark : CicloxColors.dark.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}
