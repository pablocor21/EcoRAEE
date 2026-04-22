import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/puntos_entity.dart';
import '../providers/puntos_provider.dart';

class RecompensaDetalleScreen extends ConsumerWidget {
  final RecompensaEntity recompensa;

  const RecompensaDetalleScreen({super.key, required this.recompensa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: CicloxColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────
            _TopBar(),

            // ── Contenido ────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Flecha atrás + Título ──────────
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF1E1E3F),
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              recompensa.nombre,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1E1E3F),
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // ── Icono grande ────────────────────
                      Center(child: _RecompensaIcono(icono: recompensa.icono)),
                      const SizedBox(height: 24),

                      // ── Descripción con puntos en negrita ──
                      Center(
                        child: _DescripcionDetalle(
                          descripcion: recompensa.descripcionDetalle ??
                              recompensa.descripcion,
                          costoPuntos: recompensa.costoPuntos,
                          valorBono: recompensa.valorBono ?? '',
                        ),
                      ),
                      const SizedBox(height: 28),

                      // ── Card "¿Dónde redimir?" ──────────
                      if (recompensa.aliados.isNotEmpty)
                        _DondeRedimirCard(aliados: recompensa.aliados),
                      const SizedBox(height: 28),

                      // ── Instrucciones ───────────────────
                      if (recompensa.pasos.isNotEmpty)
                        _InstruccionesSection(pasos: recompensa.pasos),
                      const SizedBox(height: 32),

                      // ── Botón Canjear ───────────────────
                      Center(
                        child: _CanjearButton(
                          onPressed: () => _canjear(context, ref),
                        ),
                      ),
                    ],
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

  Future<void> _canjear(BuildContext context, WidgetRef ref) async {
    final exito = await ref
        .read(puntosProvider.notifier)
        .canjearRecompensa(recompensa.id);

    if (!context.mounted) return;

    if (!exito) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No se pudo canjear la recompensa'),
          backgroundColor: CicloxColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
    
    context.pushReplacement('/canje-status/$exito');
  }
}

class _TopBar extends StatelessWidget {
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
                  style: TextStyle(color: Color(0xFF1E1E3F)),
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
                  style: TextStyle(color: Color(0xFF1E1E3F)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              size: 28,
              color: Color(0xFF1E1E3F),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecompensaIcono extends StatelessWidget {
  final String icono;
  const _RecompensaIcono({required this.icono});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Center(
        child: Icon(
          icono == 'celular' ? Icons.tablet_mac_rounded : Icons.storefront_rounded,
          size: 100,
          color: const Color(0xFF1E1E3F),
        ),
      ),
    );
  }
}

class _DescripcionDetalle extends StatelessWidget {
  final String descripcion;
  final int costoPuntos;
  final String valorBono;

  const _DescripcionDetalle({
    required this.descripcion,
    required this.costoPuntos,
    required this.valorBono,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF4A4A6A),
          height: 1.4,
        ),
        children: _buildTextSpans(),
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    final parts = descripcion.split('\n');
    final List<TextSpan> spans = [];

    for (int i = 0; i < parts.length; i++) {
      if (i > 0) spans.add(const TextSpan(text: '\n'));
      final text = parts[i];
      // Regex que captura números, puntos y porcentajes
      final regex = RegExp(r'(\d[\d.,]* puntos|obtener \d+%)');
      int lastEnd = 0;

      for (final match in regex.allMatches(text)) {
        if (match.start > lastEnd) {
          spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
        }
        spans.add(TextSpan(
          text: match.group(0),
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E1E3F),
          ),
        ));
        lastEnd = match.end;
      }
      if (lastEnd < text.length) {
        spans.add(TextSpan(text: text.substring(lastEnd)));
      }
    }
    return spans;
  }
}

class _DondeRedimirCard extends StatelessWidget {
  final List<AliadoEntity> aliados;
  const _DondeRedimirCard({required this.aliados});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E3F),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        children: [
          const Text(
            '¿Donde redimir nuestros puntos?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: CicloxColors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: aliados
                .map((aliado) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _AliadoChip(aliado: aliado),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _AliadoChip extends StatelessWidget {
  final AliadoEntity aliado;
  const _AliadoChip({required this.aliado});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: _getBgColor(aliado.icono),
        shape: BoxShape.circle,
        gradient: _getGradient(aliado.icono),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (aliado.icono == 'turing')
              const Icon(Icons.hexagon_outlined, color: Colors.white, size: 24),
            Text(
              aliado.nombre,
              style: TextStyle(
                fontSize: aliado.icono == 'movilclick' ? 10 : 14,
                fontWeight: FontWeight.w900,
                color: _getTextColor(aliado.icono),
                letterSpacing: -0.5,
              ),
            ),
            if (aliado.icono == 'jumbo')
              const Text(
                'cencosud',
                style: TextStyle(fontSize: 7, color: Colors.white),
              ),
            if (aliado.icono == 'exito')
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  LinearGradient? _getGradient(String icono) {
    if (icono == 'movilclick') {
      return const LinearGradient(
        colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    if (icono == 'turing') {
      return const LinearGradient(
        colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
    return null;
  }

  Color _getBgColor(String icono) {
    switch (icono) {
      case 'exito':
        return const Color(0xFFFFD600);
      case 'jumbo':
        return const Color(0xFF009640);
      case 'movilclick':
      case 'turing':
        return Colors.transparent;
      default:
        return CicloxColors.white;
    }
  }

  Color _getTextColor(String icono) {
    switch (icono) {
      case 'exito':
        return Colors.black;
      case 'jumbo':
      case 'movilclick':
      case 'turing':
        return Colors.white;
      default:
        return CicloxColors.dark;
    }
  }
}

class _InstruccionesSection extends StatelessWidget {
  final List<String> pasos;
  const _InstruccionesSection({required this.pasos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '¿Como redimir nuestros puntos?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E1E3F),
          ),
        ),
        const SizedBox(height: 16),
        ...pasos.asMap().entries.map((entry) {
          final numero = entry.key + 1;
          final paso = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              '$numero $paso',
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4A4A6A),
                height: 1.4,
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _CanjearButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _CanjearButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF120E32),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: const Text('Canjear'),
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
