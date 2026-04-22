import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/puntos_entity.dart';
import '../../infrastructure/repositories/puntos_repository_impl.dart';

// ── Estado ──────────────────────────────────────────
class PuntosState {
  final PuntosResumenEntity? resumen;
  final List<RecompensaEntity> recompensas;
  final List<HistorialPuntosEntity> historial;
  final bool isLoading;
  final String? error;

  const PuntosState({
    this.resumen,
    this.recompensas = const [],
    this.historial = const [],
    this.isLoading = false,
    this.error,
  });

  PuntosState copyWith({
    PuntosResumenEntity? resumen,
    List<RecompensaEntity>? recompensas,
    List<HistorialPuntosEntity>? historial,
    bool? isLoading,
    String? error,
  }) {
    return PuntosState(
      resumen: resumen ?? this.resumen,
      recompensas: recompensas ?? this.recompensas,
      historial: historial ?? this.historial,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// ── Notifier ────────────────────────────────────────
class PuntosNotifier extends StateNotifier<PuntosState> {
  final Ref _ref;

  PuntosNotifier(this._ref) : super(const PuntosState()) {
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(puntosRepositoryProvider);
      final results = await Future.wait([
        repo.obtenerResumen(),
        repo.obtenerRecompensas(),
        repo.obtenerHistorial(),
      ]);
      state = state.copyWith(
        resumen: results[0] as PuntosResumenEntity,
        recompensas: results[1] as List<RecompensaEntity>,
        historial: results[2] as List<HistorialPuntosEntity>,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> canjearRecompensa(String recompensaId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(puntosRepositoryProvider);
      await repo.canjearRecompensa(recompensaId);
      await cargarDatos(); // Recargar datos después del canje
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}

// ── Provider ────────────────────────────────────────
final puntosProvider = StateNotifierProvider<PuntosNotifier, PuntosState>((ref) {
  return PuntosNotifier(ref);
});
