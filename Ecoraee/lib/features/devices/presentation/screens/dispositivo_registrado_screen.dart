import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../config/router/app_router.dart';

class DispositivoRegistradoScreen extends StatelessWidget {
  const DispositivoRegistradoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.dark,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo ciclox
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: CicloxColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.bolt_rounded,
                          color: CicloxColors.dark,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'ciclox',
                        style: TextStyle(
                          color: CicloxColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.notifications_outlined,
                    color: CicloxColors.white,
                    size: 28,
                  ),
                ],
              ),
            ),

            // ── Contenido centrado ─────────────────────
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Ícono de check verde
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: CicloxColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: CicloxColors.dark,
                        size: 60,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Título
                    const Text(
                      '¡Dispositivo registrado\ncon éxito!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CicloxColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subtítulo
                    const Text(
                      'Has obtenido 150 puntos por reciclar tecnología.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CicloxColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Botón "Volver al inicio"
                    OutlinedButton(
                      onPressed: () {
                        context.go(AppRoutes.dashboardCiudadano);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: CicloxColors.grey,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        'Volver al inicio',
                        style: TextStyle(
                          color: CicloxColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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

      // ── Bottom Navigation Bar ──────────────────
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFFE8F2D9),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => context.go(AppRoutes.perfilCiudadano),
              icon: const Icon(
                Icons.settings_outlined,
                color: CicloxColors.dark,
                size: 28,
              ),
            ),
            IconButton(
              onPressed: () => context.go(AppRoutes.dashboardCiudadano),
              icon: const Icon(
                Icons.home_filled,
                color: CicloxColors.dark,
                size: 32,
              ),
            ),
            IconButton(
              onPressed: () => context.go(AppRoutes.puntos),
              icon: const Icon(
                Icons.star_outline_rounded,
                color: CicloxColors.dark,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
