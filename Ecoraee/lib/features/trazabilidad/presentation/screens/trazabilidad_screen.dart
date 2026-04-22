import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/tipo_movimiento.dart';
import '../../domain/entities/movimiento_entity.dart';
import '../widgets/timeline_tile_widget.dart';

class TrazabilidadScreen extends StatefulWidget {
  const TrazabilidadScreen({super.key});

  @override
  State<TrazabilidadScreen> createState() => _TrazabilidadScreenState();
}

class _TrazabilidadScreenState extends State<TrazabilidadScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  // ── Datos mock ──────────────────────────────────────
  final List<MovimientoEntity> _movimientos = [
    MovimientoEntity(
      id: 1,
      tipo: TipoMovimiento.registro,
      descripcion: 'Dispositivo registrado en la plataforma',
      responsableNombre: 'Andrés López',
      fecha: DateTime(2026, 1, 10, 9, 30),
    ),
    MovimientoEntity(
      id: 2,
      tipo: TipoMovimiento.solicitudCreada,
      descripcion: 'Solicitud de recolección a domicilio',
      ubicacionOrigen: 'Cll 138B Sur #45-12, Bogotá',
      responsableNombre: 'Andrés López',
      fecha: DateTime(2026, 1, 12, 14, 0),
    ),
    MovimientoEntity(
      id: 3,
      tipo: TipoMovimiento.aceptado,
      descripcion: 'Solicitud aceptada por EcoRecicla SAS',
      responsableNombre: 'EcoRecicla SAS',
      fecha: DateTime(2026, 1, 13, 10, 15),
    ),
    MovimientoEntity(
      id: 4,
      tipo: TipoMovimiento.enTransito,
      descripcion: 'Recolector en camino hacia ti',
      ubicacionOrigen: 'Centro de acopio norte',
      ubicacionDestino: 'Cll 138B Sur #45-12',
      latitud: 4.6097,
      longitud: -74.0817,
      responsableNombre: 'Carlos Ramírez',
      fecha: DateTime(2026, 1, 14, 14, 30),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ultimoMovimiento = _movimientos.last;
    final esEnTransito = ultimoMovimiento.tipo == TipoMovimiento.enTransito;

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

            // ── Contenido scrollable ─────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Botón de retroceso + título
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back,
                              color: CicloxColors.dark, size: 28),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Trazabilidad',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              color: CicloxColors.dark,
                              height: 1.05,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: Text(
                        'iPhone 11 · Celular',
                        style: TextStyle(
                          fontSize: 14,
                          color: CicloxColors.grey.withOpacity(0.9),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Tarjeta de estado actual (mapa simulado) ──
                    if (esEnTransito) ...[
                      _buildMapCard(ultimoMovimiento),
                      const SizedBox(height: 32),
                    ],

                    // ── Timeline ──────────────────────
                    const Text(
                      'Historial de movimientos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: CicloxColors.dark,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ..._buildTimeline(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: 1,
        onTap: (i) {
          if (i == 0) context.go('/perfil');
          if (i == 1) context.go('/dashboard');
        },
      ),
    );
  }

  // ── Tarjeta de mapa con estado "En tránsito" ──────
  Widget _buildMapCard(MovimientoEntity movimiento) {
    return Column(
      children: [
        // Header de estado
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              const Text(
                'En camino hacia ti',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: CicloxColors.dark,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Llegada estimada: 20 min',
                style: TextStyle(
                  fontSize: 15,
                  color: CicloxColors.grey.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),

        // Tarjeta de mapa simulado
        Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF5E6D0),
                Color(0xFFEEDCC5),
                Color(0xFFF0E0C8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: CicloxColors.dark.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Líneas de calles simuladas
              ..._buildStreetLines(),

              // Marcadores
              Positioned(
                left: 60,
                top: 120,
                child: _buildMapPin(const Color(0xFFE5392A), Icons.location_on),
              ),
              Positioned(
                left: 150,
                top: 70,
                child: _buildMapPin(CicloxColors.primary, Icons.location_on),
              ),
              Positioned(
                right: 80,
                top: 130,
                child: _buildMapPin(const Color(0xFF4A90D9), Icons.location_on),
              ),

              // Marcador principal animado (recolector)
              Positioned(
                left: 140,
                top: 90,
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 36 + (_pulseController.value * 6),
                      height: 36 + (_pulseController.value * 6),
                      decoration: BoxDecoration(
                        color: CicloxColors.primary.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: CicloxColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.local_shipping,
                            size: 14,
                            color: CicloxColors.dark,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Flecha de navegación
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: CicloxColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: CicloxColors.dark.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.chevron_right,
                      color: CicloxColors.dark,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Botón "Ver detalles"
        SizedBox(
          width: 180,
          height: 46,
          child: ElevatedButton(
            onPressed: () {
              context.push('/seguimiento-recolector');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: CicloxColors.dark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Ver detalles',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: CicloxColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildStreetLines() {
    return [
      // Líneas horizontales
      Positioned(
        left: 20, right: 20, top: 60,
        child: Container(height: 2, color: const Color(0xFFD4C4A8).withOpacity(0.6)),
      ),
      Positioned(
        left: 30, right: 40, top: 110,
        child: Container(height: 2, color: const Color(0xFFD4C4A8).withOpacity(0.6)),
      ),
      Positioned(
        left: 20, right: 30, top: 160,
        child: Container(height: 2, color: const Color(0xFFD4C4A8).withOpacity(0.6)),
      ),
      // Líneas verticales
      Positioned(
        left: 80, top: 20, bottom: 20,
        child: Container(width: 2, color: const Color(0xFFD4C4A8).withOpacity(0.6)),
      ),
      Positioned(
        left: 180, top: 30, bottom: 30,
        child: Container(width: 2, color: const Color(0xFFD4C4A8).withOpacity(0.6)),
      ),
      Positioned(
        right: 60, top: 20, bottom: 20,
        child: Container(width: 2, color: const Color(0xFFD4C4A8).withOpacity(0.6)),
      ),
    ];
  }

  Widget _buildMapPin(Color color, IconData icon) {
    return Icon(icon, color: color, size: 32);
  }

  // ── Construir timeline ────────────────────────────
  List<Widget> _buildTimeline() {
    return List.generate(_movimientos.length, (index) {
      final movimiento = _movimientos[index];
      final isLast = index == _movimientos.length - 1;
      final isFirst = index == 0;

      return TimelineTileWidget(
        movimiento: movimiento,
        isFirst: isFirst,
        isLast: isLast,
        isActive: isLast,
      );
    });
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
          TextSpan(text: 'ci', style: TextStyle(color: CicloxColors.dark)),
          TextSpan(text: 'cl', style: TextStyle(color: CicloxColors.primary)),
          TextSpan(text: 'ox', style: TextStyle(color: CicloxColors.dark)),
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
          _NavItem(icon: Icons.settings_outlined, index: 0, selectedIndex: selectedIndex, onTap: onTap),
          _NavItem(icon: Icons.home_rounded, index: 1, selectedIndex: selectedIndex, onTap: onTap),
          _NavItem(icon: Icons.star_border_rounded, index: 2, selectedIndex: selectedIndex, onTap: onTap),
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
  const _NavItem({required this.icon, required this.index, required this.selectedIndex, required this.onTap});

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
