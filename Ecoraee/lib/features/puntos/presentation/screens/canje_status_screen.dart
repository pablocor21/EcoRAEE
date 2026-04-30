import '../../../../config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';

class CanjeStatusScreen extends StatelessWidget {
  final bool isSuccess;

  const CanjeStatusScreen({
    super.key,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.dark,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────
            _TopBarWhite(),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ── Icono (Check o X) ─────────────────
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: isSuccess ? CicloxColors.primary : CicloxColors.error,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isSuccess ? Icons.check_rounded : Icons.close_rounded,
                        size: 70,
                        color: isSuccess ? CicloxColors.dark : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Título ────────────────────────────
                    Text(
                      isSuccess ? '¡Canjeo Exitoso!' : 'Canjeo rechazado',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ── Subtítulo ─────────────────────────
                    Text(
                      isSuccess
                          ? 'Ahora disfrútalo como se debe'
                          : 'Intentalo mas tarde',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // ── Botones ────────────────────────────
                    Column(
                      children: [
                        if (isSuccess) ...[
                          SizedBox(
                            width: 240,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () => context.pushReplacement('/canje-exitoso/1'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CicloxColors.primary,
                                foregroundColor: CicloxColors.dark,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              child: const Text('Ver código QR'),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        SizedBox(
                          width: 240,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => context.go('/dashboard'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE9F1E1),
                              foregroundColor: const Color(0xFF1E1E3F),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: const Text('Volver al inicio'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

class _TopBarWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
              children: [
                const TextSpan(
                  text: 'cl',
                  style: TextStyle(color: Colors.white),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.bolt_rounded,
                    color: CicloxColors.primary,
                    size: 24,
                  ),
                ),
                const TextSpan(
                  text: 'cl',
                  style: TextStyle(color: CicloxColors.primary),
                ),
                const TextSpan(
                  text: 'ox',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.notifications_outlined,
            size: 28,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFFE9F1E1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.settings_rounded,
            onTap: () => context.push(AppRoutes.ajustesColaborador),
          ),
          _NavItem(
            icon: Icons.home_rounded,
            onTap: () => context.go('/dashboard'),
          ),
          _NavItem(
            icon: Icons.stars_rounded,
            isSelected: true,
            onTap: () => context.go('/puntos'),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Icon(
          icon,
          size: 30,
          color: isSelected
              ? const Color(0xFF1E1E3F)
              : const Color(0xFF1E1E3F).withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
