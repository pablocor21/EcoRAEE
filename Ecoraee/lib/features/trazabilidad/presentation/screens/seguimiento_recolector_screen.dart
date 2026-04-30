import '../../../../config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';

class SeguimientoRecolectorScreen extends StatefulWidget {
  const SeguimientoRecolectorScreen({super.key});

  @override
  State<SeguimientoRecolectorScreen> createState() =>
      _SeguimientoRecolectorScreenState();
}

class _SeguimientoRecolectorScreenState
    extends State<SeguimientoRecolectorScreen> {
  int _selectedEstado = 0;
  int _calificacion = 4; // Estrellas seleccionadas (1-5)

  final List<String> _estados = ['En camino', 'cerca', 'Recogido'];

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

            // ── Contenido scrollable ─────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // ── Header: "En camino hacia ti" ─────
                    const Text(
                      'En camino hacia ti',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: CicloxColors.dark,
                        letterSpacing: -0.5,
                        fontStyle: FontStyle.italic,
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
                    const SizedBox(height: 32),

                    // ── Estado del servicio ───────────────
                    const Text(
                      'Estado del servicio',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: CicloxColors.dark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tabs de estado
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_estados.length, (index) {
                        final isSelected = index == _selectedEstado;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedEstado = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? CicloxColors.dark
                                  : CicloxColors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: isSelected
                                    ? CicloxColors.dark
                                    : CicloxColors.grey.withOpacity(0.4),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              _estados[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? CicloxColors.white
                                    : CicloxColors.dark,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 36),

                    // ── Tarjeta del recolector ────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Foto del recolector
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: CicloxColors.greyLight,
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200&auto=format&fit=crop',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Info del recolector
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Recolector',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: CicloxColors.dark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              _buildInfoRow('Nombre:', 'Juan Jose Gomez'),
                              _buildInfoRow('Empresa:', 'ciclox'),
                              _buildInfoRow('Calificación:', '4.8'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Botón contactar
                    SizedBox(
                      width: 160,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CicloxColors.dark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Contactar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: CicloxColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // ── Calificación ──────────────────────
                    const Text(
                      '¿Cómo fue tu experiencia?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: CicloxColors.dark,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Estrellas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final isFilled = index < _calificacion;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _calificacion = index + 1;
                            });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(
                              isFilled ? Icons.star : Icons.star_border,
                              size: 44,
                              color: const Color(0xFFFFC107),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),

                    // Botón enviar calificación
                    SizedBox(
                      width: 200,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '¡Gracias! Calificaste con $_calificacion estrellas',
                              ),
                              backgroundColor: CicloxColors.dark,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CicloxColors.dark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Enviar calificación',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: CicloxColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
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
          if (i == 0) context.push(AppRoutes.ajustesColaborador);
          if (i == 1) context.go('/dashboard');
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: CicloxColors.dark),
          children: [
            TextSpan(
              text: '$label ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: CicloxColors.grey.withOpacity(0.9),
              ),
            ),
          ],
        ),
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
