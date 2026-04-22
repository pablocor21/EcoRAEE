import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/puntos_entity.dart';
import '../providers/puntos_provider.dart';
import '../widget/progreso_puntos_bar_widget.dart';
import '../widget/recompensa_card_widget.dart';
import '../widget/historial_puntos_item_widget.dart';

class PuntosScreen extends ConsumerWidget {
  const PuntosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(puntosProvider);

    return Scaffold(
      backgroundColor: CicloxColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────
            _TopBar(),

            // ── Contenido ────────────────────────────
            Expanded(
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: CicloxColors.primary,
                      ),
                    )
                  : state.error != null
                      ? _ErrorView(
                          error: state.error!,
                          onRetry: () =>
                              ref.read(puntosProvider.notifier).cargarDatos(),
                        )
                      : RefreshIndicator(
                          color: CicloxColors.primary,
                          onRefresh: () =>
                              ref.read(puntosProvider.notifier).cargarDatos(),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(24, 8, 24, 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ── Puntos totales ──────────
                                  _PuntosHeader(
                                    puntos:
                                        state.resumen?.puntosActuales ?? 0,
                                  ),
                                  const SizedBox(height: 20),

                                  // ── Barra de progreso ───────
                                  if (state.resumen != null)
                                    ProgresoPuntosBar(
                                      progreso: state.resumen!.progreso,
                                      puntosFaltantes: state.resumen!
                                          .puntosSiguienteRecompensa,
                                    ),
                                  const SizedBox(height: 32),

                                  // ── Recompensas ─────────────
                                  const Text(
                                    'Recompensas',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: CicloxColors.dark,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _RecompensasGrid(
                                    recompensas: state.recompensas,
                                  ),
                                  const SizedBox(height: 32),

                                  // ── Historial ───────────────
                                  const Text(
                                    'Historial',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: CicloxColors.dark,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ...state.historial
                                      .map((item) =>
                                          HistorialPuntosItem(item: item))
                                      ,
                                ],
                              ),
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// TOP BAR con logo y campana
// ─────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo "ciclox"
          RichText(
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
          ),
          // Campana
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
    );
  }
}

// ─────────────────────────────────────────────
// HEADER: flecha back + título + puntos grandes
// ─────────────────────────────────────────────
class _PuntosHeader extends StatelessWidget {
  final int puntos;
  const _PuntosHeader({required this.puntos});

  @override
  Widget build(BuildContext context) {
    // Formatear puntos con separador de miles
    final puntosFormateados = _formatearPuntos(puntos);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Flecha atrás + título
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            children: [
              const Icon(Icons.arrow_back, color: CicloxColors.dark, size: 24),
              const SizedBox(width: 8),
              const Text(
                'Tus puntos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Puntos grandes centrados
        Center(
          child: Text(
            '$puntosFormateados pts',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: CicloxColors.dark,
              letterSpacing: -1,
            ),
          ),
        ),
      ],
    );
  }

  String _formatearPuntos(int puntos) {
    final str = puntos.abs().toString();
    final result = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        result.write(',');
      }
      result.write(str[i]);
    }
    return puntos < 0 ? '-${result.toString()}' : result.toString();
  }
}

// ─────────────────────────────────────────────
// GRID DE RECOMPENSAS (2 columnas)
// ─────────────────────────────────────────────
class _RecompensasGrid extends StatelessWidget {
  final List<RecompensaEntity> recompensas;
  const _RecompensasGrid({required this.recompensas});

  @override
  Widget build(BuildContext context) {
    if (recompensas.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'No hay recompensas disponibles',
            style: TextStyle(color: CicloxColors.grey, fontSize: 14),
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.78,
      ),
      itemCount: recompensas.length,
      itemBuilder: (context, index) {
        final recompensa = recompensas[index];
        return RecompensaCard(
          recompensa: recompensa,
          onVerDetalles: () {
            // TODO: Navegar a detalle de recompensa
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Detalle de ${recompensa.nombre}'),
                backgroundColor: CicloxColors.dark,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// VISTA DE ERROR
// ─────────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: CicloxColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CicloxColors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: CicloxColors.primary,
                foregroundColor: CicloxColors.dark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
