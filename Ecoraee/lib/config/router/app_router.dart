import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/verify_code_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/dashboard_screen.dart';
import '../../features/auth/presentation/screens/dashboard_colab_screen.dart';
import '../../features/devices/presentation/screens/registro_dispositivo_screen.dart';
import '../../features/devices/presentation/screens/dispositivo_registrado_screen.dart';
import '../../features/auth/presentation/screens/politicas_prevencion_screen.dart';
import '../../features/solicitudes/presentation/screens/crear_solicitud_screen.dart';
import '../../features/solicitudes/presentation/screens/crear_solicitud_paso2_screen.dart';
import '../../features/solicitudes/presentation/screens/crear_solicitud_resumen_screen.dart';
import '../../features/solicitudes/presentation/screens/seguimiento_solicitudes_screen.dart';
import '../../features/solicitudes/presentation/screens/solicitud_cancelada_screen.dart';
import '../../features/solicitudes/presentation/screens/solicitud_enviada_screen.dart';
import '../../features/solicitudes/presentation/screens/solicitudes_screen.dart';
import '../../features/trazabilidad/presentation/screens/trazabilidad_screen.dart';
import '../../features/trazabilidad/presentation/screens/seguimiento_recolector_screen.dart';
import '../../features/puntos/presentation/screens/recompensa_detalle_screen.dart';
import '../../features/puntos/presentation/screens/canje_exitoso_screen.dart';
import '../../features/puntos/presentation/screens/canje_status_screen.dart';
import '../../features/puntos/presentation/providers/puntos_provider.dart';


class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String resetPassword = '/reset-password';
  static const String dashboardCiudadano = '/dashboard';
  static const String perfilCiudadano = '/perfil';
  static const String dashboardColaborador = '/dashboard-colaborador';
  static const String registroDispositivo = '/registro-dispositivo';
  static const String dispositivoRegistrado = '/dispositivo-registrado';
  static const String politicasPrevencion = '/politicas-prevencion';
  static const String solicitudes = '/solicitudes';
  static const String crearSolicitud = '/crear-solicitud';
  static const String crearSolicitudPaso2 = '/crear-solicitud-paso2';
  static const String crearSolicitudResumen = '/crear-solicitud-resumen';
  static const String seguimientoSolicitudes = '/seguimiento-solicitudes';
  static const String solicitudCancelada = '/solicitud-cancelada';
  static const String solicitudEnviada = '/solicitud-enviada';
  static const String trazabilidad = '/trazabilidad';
  static const String seguimientoRecolector = '/seguimiento-recolector';
  static const String puntos = '/puntos';
  static const String recompensaDetalle = '/recompensa-detalle';
  static const String canjeExitoso = '/canje-exitoso';
  static const String canjeStatus = '/canje-status';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    /// initialLocation: AppRoutes.dashboardCiudadano, // TODO: Cambiar a AppRoutes.onboarding para producción
    routes: [
      GoRoute(
        name: 'onboarding',
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: 'login',
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'register',
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: 'forgotPassword',
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        name: 'verifyCode',
        path: '/verify-code',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          print(
            'VerifyCode route builder: email=$email, path=${state.uri.path}',
          );
          if (email.isEmpty) {
            return const Scaffold(
              body: Center(
                child: Text('No se recibió el correo para verificar.'),
              ),
            );
          }
          return VerifyCodeScreen(email: email);
        },
      ),
      GoRoute(
        name: 'resetPassword',
        path: '${AppRoutes.resetPassword}/:email/:codigo',
        builder: (context, state) {
          final email = Uri.decodeComponent(
            state.pathParameters['email'] ?? '',
          );
          final codigo = Uri.decodeComponent(
            state.pathParameters['codigo'] ?? '',
          );
          print(
            'Router: creando ResetPasswordScreen con email: $email, codigo: $codigo',
          );
          return ResetPasswordScreen(email: email, codigo: codigo);
        },
      ),
      GoRoute(
        path: AppRoutes.dashboardCiudadano,
        builder: (context, state) => const DashboardScreen(initialIndex: 1),
      ),
      GoRoute(
        path: AppRoutes.perfilCiudadano,
        builder: (context, state) => const DashboardScreen(initialIndex: 0),
      ),
      GoRoute(
        path: AppRoutes.dashboardColaborador,
        builder: (context, state) => const DashboardColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.registroDispositivo,
        builder: (context, state) => const RegistroDispositivoScreen(),
      ),
      GoRoute(
        path: AppRoutes.dispositivoRegistrado,
        builder: (context, state) => const DispositivoRegistradoScreen(),
      ),
      GoRoute(
        path: AppRoutes.politicasPrevencion,
        builder: (context, state) => const PoliticasPrevencionScreen(),
      ),
      GoRoute(
        path: AppRoutes.solicitudes,
        builder: (context, state) => const SolicitudesScreen(),
      ),
      GoRoute(
        path: AppRoutes.crearSolicitud,
        builder: (context, state) => const CrearSolicitudScreen(),
      ),
      GoRoute(
        path: AppRoutes.crearSolicitudPaso2,
        builder: (context, state) => const CrearSolicitudPaso2Screen(),
      ),
      GoRoute(
        path: AppRoutes.crearSolicitudResumen,
        builder: (context, state) => const CrearSolicitudResumenScreen(),
      ),
      GoRoute(
        path: AppRoutes.seguimientoSolicitudes,
        builder: (context, state) => const SeguimientoSolicitudesScreen(),
      ),
      GoRoute(
        path: AppRoutes.solicitudCancelada,
        builder: (context, state) => const SolicitudCanceladaScreen(),
      ),
      GoRoute(
        path: AppRoutes.solicitudEnviada,
        builder: (context, state) => const SolicitudEnviadaScreen(),
      ),
      GoRoute(
        path: AppRoutes.trazabilidad,
        builder: (context, state) => const TrazabilidadScreen(),
      ),
      GoRoute(
        path: AppRoutes.seguimientoRecolector,
        builder: (context, state) => const SeguimientoRecolectorScreen(),
      ),
      GoRoute(
        path: AppRoutes.puntos,
        builder: (context, state) => const DashboardScreen(initialIndex: 2),
      ),
      GoRoute(
        path: '${AppRoutes.recompensaDetalle}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final puntosState = ProviderScope.containerOf(context).read(puntosProvider);
          final recompensa = puntosState.recompensas.firstWhere(
            (r) => r.id == id,
            orElse: () => puntosState.recompensas.first,
          );
          return RecompensaDetalleScreen(recompensa: recompensa);
        },
      ),
      GoRoute(
        path: '${AppRoutes.canjeExitoso}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final puntosState = ProviderScope.containerOf(context).read(puntosProvider);
          final recompensa = puntosState.recompensas.firstWhere(
            (r) => r.id == id,
            orElse: () => puntosState.recompensas.first,
          );
          return CanjeExitosoScreen(recompensa: recompensa);
        },
      ),
      GoRoute(
        path: '${AppRoutes.canjeStatus}/:success',
        builder: (context, state) {
          final isSuccess = state.pathParameters['success'] == 'true';
          return CanjeStatusScreen(isSuccess: isSuccess);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Página no encontrada: ${state.error}')),
    ),
  );
});
