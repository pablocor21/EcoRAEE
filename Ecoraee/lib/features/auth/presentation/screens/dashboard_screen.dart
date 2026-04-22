import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'profile_screen.dart';

// ─────────────────────────────────────────────
// HOME TAB
// ─────────────────────────────────────────────
class _HomeTab extends ConsumerWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final nombre = authState.nombre ?? 'Usuario';
    // Tomar solo el primer nombre
    final primerNombre = nombre.split(' ').first;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Saludo ──────────────────────────────
            Text(
              '¡Bienvenida',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: CicloxColors.dark,
              ),
            ),
            Text(
              '$primerNombre!',
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: CicloxColors.dark,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '¿Que quieres hacer hoy?',
              style: TextStyle(
                fontSize: 14,
                color: CicloxColors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),

            // ── Grid de acciones ─────────────────────
            _ActionGrid(context: context),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// GRID DE ACCIONES (2x2)
// ─────────────────────────────────────────────
class _ActionGrid extends StatelessWidget {
  final BuildContext context;
  const _ActionGrid({required this.context});

  @override
  Widget build(BuildContext ctx) {
    const double cardHeight = 155;
    const double spacing = 14;

    return Column(
      children: [
        // Fila 1
        Row(
          children: [
            // Tus Puntos (oscuro - izquierda)
            Expanded(
              child: _DarkPointsCard(height: cardHeight),
            ),
            const SizedBox(width: spacing),
            // Registrar Dispositivo (blanco - derecha)
            Expanded(
              child: _OutlineActionCard(
                label: 'Registrar\nDispositivo',
                height: cardHeight,
                onTap: () => context.push('/registro-dispositivo'),
              ),
            ),
          ],
        ),
        const SizedBox(height: spacing),
        // Fila 2
        Row(
          children: [
            // Tus Solicitudes (blanco - izquierda)
            Expanded(
              child: _OutlineActionCard(
                label: 'Tus\nSolicitudes',
                height: cardHeight,
                onTap: () => context.push('/solicitudes'),
              ),
            ),
            const SizedBox(width: spacing),
            // Sigue tu reciclaje (mapa - derecha)
            Expanded(
              child: _MapActionCard(
                height: cardHeight,
                onTap: () => context.push('/trazabilidad'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// TARJETA "TUS PUNTOS" (fondo oscuro)
// ─────────────────────────────────────────────
class _DarkPointsCard extends StatelessWidget {
  final double height;
  const _DarkPointsCard({required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: CicloxColors.dark,
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Tus\npuntos',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: CicloxColors.white,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TARJETA OUTLINE (fondo blanco con borde)
// ─────────────────────────────────────────────
class _OutlineActionCard extends StatelessWidget {
  final String label;
  final double height;
  final VoidCallback onTap;
  const _OutlineActionCard({
    required this.label,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: CicloxColors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TARJETA "SIGUE TU RECICLAJE" (con mapa)
// ─────────────────────────────────────────────
class _MapActionCard extends StatelessWidget {
  final double height;
  final VoidCallback onTap;
  const _MapActionCard({required this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          // Mapa simulado con gradiente / colores de mapa
          color: const Color(0xFFD6E4AC),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Fondo de mapa simulado con cuadrícula y colores
            Positioned.fill(
              child: CustomPaint(painter: _MapPainter()),
            ),
            // Etiqueta en esquina inferior izquierda
            Positioned(
              bottom: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Sigue\ntu reciclaje',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: CicloxColors.dark,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            // Botones de zoom simulados (esquina superior derecha)
            Positioned(
              top: 10,
              right: 10,
              child: Column(
                children: [
                  _ZoomBtn(label: '+'),
                  const SizedBox(height: 3),
                  _ZoomBtn(label: '−'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BOTÓN DE ZOOM (decorativo)
// ─────────────────────────────────────────────
class _ZoomBtn extends StatelessWidget {
  final String label;
  const _ZoomBtn({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: CicloxColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: CicloxColors.dark,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PINTOR DE MAPA SIMULADO
// ─────────────────────────────────────────────
class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFFF5F0E8)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final roadPaintNarrow = Paint()
      ..color = const Color(0xFFF5F0E8)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // Fondo
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFFD6E4AC),
    );

    // Calles horizontales
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.65),
      Offset(size.width, size.height * 0.65),
      roadPaintNarrow,
    );

    // Calles verticales
    canvas.drawLine(
      Offset(size.width * 0.35, 0),
      Offset(size.width * 0.35, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.7, size.height),
      roadPaintNarrow,
    );

    // Bloque diagonal
    final path = Path()
      ..moveTo(size.width * 0.0, size.height * 0.45)
      ..lineTo(size.width * 0.35, size.height * 0.3)
      ..lineTo(size.width * 0.35, size.height * 0.65)
      ..lineTo(0, size.height * 0.75)
      ..close();
    canvas.drawPath(
      path,
      Paint()..color = const Color(0xFFC8D9A0),
    );

    // Pin de ubicación
    final pinX = size.width * 0.5;
    final pinY = size.height * 0.42;
    canvas.drawCircle(
      Offset(pinX, pinY),
      8,
      Paint()..color = const Color(0xFFFF5252),
    );
    canvas.drawCircle(
      Offset(pinX, pinY),
      4,
      Paint()..color = CicloxColors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────
// PLACEHOLDER TABS
// ─────────────────────────────────────────────
class _PlaceholderTab extends StatelessWidget {
  final String label;
  final IconData icon;
  const _PlaceholderTab({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: CicloxColors.grey.withValues(alpha: 0.4)),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: CicloxColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Próximamente',
            style: TextStyle(color: CicloxColors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DASHBOARD SHELL (ciudadano)
// ─────────────────────────────────────────────
class DashboardScreen extends ConsumerStatefulWidget {
  final int initialIndex;
  const DashboardScreen({super.key, this.initialIndex = 1});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _tabs = const [
    ProfileScreen(),
    _HomeTab(),
    _PlaceholderTab(label: 'Recompensas', icon: Icons.star_border_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────
            if (_selectedIndex == 1)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo "ciclox" personalizado
                    _CicloxLogo(),
                    // Campana de notificaciones
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

            // ── Contenido del tab ─────────────────────
            Expanded(child: _tabs[_selectedIndex]),
          ],
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
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

// ─────────────────────────────────────────────
// ÍTEM DE NAVEGACIÓN INFERIOR
// ─────────────────────────────────────────────
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
