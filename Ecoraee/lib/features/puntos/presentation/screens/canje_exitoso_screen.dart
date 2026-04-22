import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/puntos_entity.dart';

class CanjeExitosoScreen extends StatelessWidget {
  final RecompensaEntity recompensa;
  final String codigo;

  const CanjeExitosoScreen({
    super.key,
    required this.recompensa,
    this.codigo = 'ED24FH',
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ── Título y Subtítulo ────────────────
                        Text(
                          '${recompensa.nombre} ${recompensa.valorBono ?? ''}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${recompensa.costoPuntos} pts.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // ── QR Code Simulado ──────────────────
                        _SimulatedQR(),
                        const SizedBox(height: 40),

                        // ── Código Box ────────────────────────
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F1E1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'Código: $codigo',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1E1E3F),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Vigencia ──────────────────────────
                        const Text(
                          'Vigencia de 30 minutos',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
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

class _SimulatedQR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: CustomPaint(
        painter: _QRPainter(),
      ),
    );
  }
}

class _QRPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final dotSize = size.width / 21;
    final rand = math.Random(123);

    void drawSquare(double x, double y, double s) {
      canvas.drawRect(Rect.fromLTWH(x * dotSize, y * dotSize, s * dotSize, s * dotSize), paint);
      canvas.drawRect(
        Rect.fromLTWH((x + 1) * dotSize, (y + 1) * dotSize, (s - 2) * dotSize, (s - 2) * dotSize),
        Paint()..color = CicloxColors.dark,
      );
      canvas.drawRect(
        Rect.fromLTWH((x + 2) * dotSize, (y + 2) * dotSize, (s - 4) * dotSize, (s - 4) * dotSize),
        paint,
      );
    }

    drawSquare(0, 0, 7);
    drawSquare(14, 0, 7);
    drawSquare(0, 14, 7);

    for (int i = 0; i < 21; i++) {
      for (int j = 0; j < 21; j++) {
        if ((i < 8 && j < 8) || (i > 13 && j < 8) || (i < 8 && j > 13)) continue;
        if (rand.nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(i * dotSize, j * dotSize, dotSize * 0.85, dotSize * 0.85),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
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
            onTap: () => context.go('/perfil'),
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
