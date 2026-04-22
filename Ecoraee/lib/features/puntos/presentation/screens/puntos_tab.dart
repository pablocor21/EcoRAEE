import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/puntos_entity.dart';
import '../providers/puntos_provider.dart';
import '../widget/progreso_puntos_bar_widget.dart';
import '../widget/recompensa_card_widget.dart';
import '../widget/historial_puntos_item_widget.dart';

/// Tab de puntos para usar dentro del DashboardScreen (sin Scaffold ni TopBar).
class PuntosTab extends ConsumerWidget {
  const PuntosTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(puntosProvider);

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: CicloxColors.primary),
      );
    }

    if (state.error != null) {
      return _ErrorView(
        error: state.error!,
        onRetry: () => ref.read(puntosProvider.notifier).cargarDatos(),
      );
    }

    return RefreshIndicator(
      color: CicloxColors.primary,
      onRefresh: () => ref.read(puntosProvider.notifier).cargarDatos(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Título ──────────────────────────
              const Text(
                '← Tus puntos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
              const SizedBox(height: 20),

              // ── Puntos grandes centrados ────────
              Center(
                child: Text(
                  '${_formatearPuntos(state.resumen?.puntosActuales ?? 0)} pts',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: CicloxColors.dark,
                    letterSpacing: -1,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Barra de progreso ───────────────
              if (state.resumen != null)
                ProgresoPuntosBar(
                  progreso: state.resumen!.progreso,
                  puntosFaltantes: state.resumen!.puntosSiguienteRecompensa,
                ),
              const SizedBox(height: 32),

              // ── Recompensas ─────────────────────
              const Text(
                'Recompensas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
              const SizedBox(height: 16),
              _RecompensasGrid(recompensas: state.recompensas),
              const SizedBox(height: 32),

              // ── Historial ───────────────────────
              const Text(
                'Historial',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: CicloxColors.dark,
                ),
              ),
              const SizedBox(height: 12),
              ...state.historial.map((item) => HistorialPuntosItem(item: item)),
            ],
          ),
        ),
      ),
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
            context.push('/recompensa-detalle/${recompensa.id}');
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
              style: const TextStyle(color: CicloxColors.grey, fontSize: 14),
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
