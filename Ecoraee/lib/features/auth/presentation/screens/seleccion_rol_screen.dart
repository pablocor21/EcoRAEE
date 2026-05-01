import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../config/router/app_router.dart';

class SeleccionRolScreen extends StatelessWidget {
  const SeleccionRolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.primaryLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // ── Logo ciclox ──────────────────────────
                Image.asset(
                  'assets/imagenes/VARIACION 2 COLOR.png',
                  height: 180,
                ),
                const SizedBox(height: 12),

                // ── Tagline ──────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Transforma',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: CicloxColors.dark.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Recupera',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: CicloxColors.dark.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Reintegra',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: CicloxColors.dark.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),

                // ── Tarjeta Usuarios ─────────────────────
                _RoleCard(
                  onTap: () => context.go(AppRoutes.dashboardCiudadano),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: CicloxColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: CicloxColors.dark,
                        ),
                      ),
                    ),
                  ),
                  title: 'Usuarios',
                  subtitle: 'Clientes',
                  subtitleIcon: Icons.bolt_rounded,
                  backgroundColor: CicloxColors.white,
                  titleColor: CicloxColors.dark,
                  subtitleColor: CicloxColors.dark.withValues(alpha: 0.5),
                  gradientColors: null,
                ),
                const SizedBox(height: 20),

                // ── Tarjeta Colaboradores ─────────────────
                _RoleCard(
                  onTap: () {},
                  icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/iconos/logo-icono VERDE-8.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: 'Colaboradores',
                  subtitle: 'Personal empresarial CICLOX',
                  subtitleIcon: Icons.bolt_rounded,
                  backgroundColor: CicloxColors.dark,
                  titleColor: CicloxColors.white,
                  subtitleColor: CicloxColors.white.withValues(alpha: 0.6),
                  gradientColors: const [
                    Color(0xFF19133B),
                    Color(0xFF2A2356),
                    Color(0xFF6787AE),
                  ],
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TARJETA DE ROL
// ─────────────────────────────────────────────
class _RoleCard extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;
  final String title;
  final String subtitle;
  final IconData subtitleIcon;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final List<Color>? gradientColors;

  const _RoleCard({
    required this.onTap,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.subtitleIcon,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: gradientColors == null ? backgroundColor : null,
          gradient: gradientColors != null
              ? LinearGradient(
                  colors: gradientColors!,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: CicloxColors.dark.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícono + Título en la misma fila
            Row(
              children: [
                icon,
                const SizedBox(width: 14),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Subtítulo con ícono
            Row(
              children: [
                Icon(subtitleIcon, size: 16, color: subtitleColor),
                const SizedBox(width: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
