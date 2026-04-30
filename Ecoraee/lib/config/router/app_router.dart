import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Auth screens ──────────────────────────────────
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/verify_code_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/auth/presentation/screens/dashboard_screen.dart';
import '../../features/auth/presentation/screens/dashboard_colab_screen.dart';
import '../../features/auth/presentation/screens/registros_screen.dart';
import '../../features/auth/presentation/screens/historial_screen.dart';
import '../../features/auth/presentation/screens/detalles_solicitud_screen.dart';
import '../../features/auth/presentation/screens/politicas_prevencion_screen.dart';
import '../../features/auth/presentation/screens/seleccion_rol_screen.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/ajustes_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/ajustes_de_perfil_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/datos_de_la_empresa_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/ajustes_notificaciones_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/accesibilidad_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/politicas_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/terminos_y_condiciones_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/politicas_of_privacidad_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/politica_reciclaje_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/uso_plataforma_colab.dart';
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/soporte_colab.dart';

// ── Devices screens ───────────────────────────────
import '../../features/devices/presentation/screens/registro_dispositivo_screen.dart';
import '../../features/devices/presentation/screens/dispositivo_registrado_screen.dart';

// ── Solicitudes screens ───────────────────────────
import '../../features/auth/presentation/screens/solicitudes_screen.dart';
import '../../features/solicitudes/presentation/screens/crear_solicitud_screen.dart';
import '../../features/solicitudes/presentation/screens/crear_solicitud_paso2_screen.dart';
import '../../features/solicitudes/presentation/screens/crear_solicitud_resumen_screen.dart';
import '../../features/solicitudes/presentation/screens/seguimiento_solicitudes_screen.dart';
import '../../features/solicitudes/presentation/screens/solicitud_cancelada_screen.dart';
import '../../features/solicitudes/presentation/screens/solicitud_enviada_screen.dart';

// ── Recoleccion screens ───────────────────────────
import '../../features/recoleccion/presentation/screens/recoleccion_screen.dart';

// ── Trazabilidad screens ──────────────────────────
import '../../features/trazabilidad/presentation/screens/trazabilidad_screen.dart';
import '../../features/trazabilidad/presentation/screens/seguimiento_recolector_screen.dart';

// ── Puntos screens ────────────────────────────────
import '../../features/puntos/presentation/screens/puntos_screen.dart';
import '../../features/puntos/presentation/screens/recompensa_detalle_screen.dart';
import '../../features/puntos/presentation/screens/canje_exitoso_screen.dart';
import '../../features/puntos/presentation/screens/canje_status_screen.dart';
import '../../features/puntos/domain/entities/puntos_entity.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String seleccionRol = '/seleccion-rol';
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
  static const String registros = '/registros';
  static const String historial = '/historial';
  static const String solicitudes = '/solicitudes';
  static const String detallesSolicitud = '/detalles-solicitud';
  static const String crearSolicitud = '/crear-solicitud';
  static const String crearSolicitudPaso2 = '/crear-solicitud-paso2';
  static const String crearSolicitudResumen = '/crear-solicitud-resumen';
  static const String seguimientoSolicitudes = '/seguimiento-solicitudes';
  static const String solicitudCancelada = '/solicitud-cancelada';
  static const String solicitudEnviada = '/solicitud-enviada';
  static const String recoleccion = '/recoleccion';
  static const String politicasPrevencion = '/politicas-prevencion';
  static const String trazabilidad = '/trazabilidad';
  static const String seguimientoRecolector = '/seguimiento-recolector';
  static const String puntos = '/puntos';
  static const String recompensaDetalle = '/recompensa-detalle';
  static const String canjeExitoso = '/canje-exitoso';
  static const String canjeStatus = '/canje-status';
  static const String ajustesColaborador = '/ajustes-colaborador';
  static const String ajustesPerfilColaborador = '/ajustes-perfil-colaborador';
  static const String datosEmpresaColaborador = '/datos-empresa-colaborador';
  static const String ajustesNotificacionesColaborador = '/ajustes-notificaciones-colaborador';
  static const String accesibilidadColaborador = '/accesibilidad-colaborador';
  static const String politicasColaborador = '/politicas-colaborador';
  static const String terminosCondicionesColaborador = '/terminos-condiciones-colaborador';
  static const String politicasPrivacidadColaborador = '/politicas-privacidad-colaborador';
  static const String politicaReciclajeColaborador = '/politica-reciclaje-colaborador';
  static const String usoPlataformaColaborador = '/uso-plataforma-colaborador';
  static const String soporteColaborador = '/soporte-colaborador';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.onboarding,

    /// initialLocation: AppRoutes.dashboardCiudadano, // TODO: Cambiar a AppRoutes.onboarding para producción
    routes: [
      // ── Auth ──────────────────────────────────────
      GoRoute(
        name: 'onboarding',
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: 'seleccionRol',
        path: AppRoutes.seleccionRol,
        builder: (context, state) => const SeleccionRolScreen(),
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

      // ── Dashboard ─────────────────────────────────
      GoRoute(
        path: AppRoutes.dashboardCiudadano,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.perfilCiudadano,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboardColaborador,
        builder: (context, state) => const DashboardColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.ajustesColaborador,
        builder: (context, state) => const AjustesColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.ajustesPerfilColaborador,
        builder: (context, state) => const AjustesDePerfilColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.datosEmpresaColaborador,
        builder: (context, state) => const DatosDeLaEmpresaColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.ajustesNotificacionesColaborador,
        builder: (context, state) => const AjustesNotificacionesColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.accesibilidadColaborador,
        builder: (context, state) => const AccesibilidadColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.politicasColaborador,
        builder: (context, state) => const PoliticasColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.terminosCondicionesColaborador,
        builder: (context, state) => const TerminosCondicionesColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.politicasPrivacidadColaborador,
        builder: (context, state) => const PoliticasPrivacidadColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.politicaReciclajeColaborador,
        builder: (context, state) => const PoliticaReciclajeColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.usoPlataformaColaborador,
        builder: (context, state) => const UsoPlataformaColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.soporteColaborador,
        builder: (context, state) => const SoporteColabScreen(),
      ),

      // ── Devices ───────────────────────────────────
      GoRoute(
        path: AppRoutes.registroDispositivo,
        builder: (context, state) => const RegistroDispositivoScreen(),
      ),
      GoRoute(
        path: AppRoutes.dispositivoRegistrado,
        builder: (context, state) => const DispositivoRegistradoScreen(),
      ),

      // ── Registros / Historial ─────────────────────
      GoRoute(
        path: AppRoutes.registros,
        builder: (context, state) => const RegistrosScreen(),
      ),
      GoRoute(
        path: AppRoutes.historial,
        builder: (context, state) => const HistorialScreen(),
      ),

      // ── Solicitudes ───────────────────────────────
      GoRoute(
        path: AppRoutes.solicitudes,
        builder: (context, state) => const SolicitudesScreen(),
      ),
      GoRoute(
        path: AppRoutes.detallesSolicitud,
        builder: (context, state) => const DetallesSolicitudScreen(),
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

      // ── Recoleccion ───────────────────────────────
      GoRoute(
        path: AppRoutes.recoleccion,
        builder: (context, state) => const RecoleccionScreen(),
      ),

      // ── Políticas ─────────────────────────────────
      GoRoute(
        path: AppRoutes.politicasPrevencion,
        builder: (context, state) => const PoliticasPrevencionScreen(),
      ),

      // ── Trazabilidad ──────────────────────────────
      GoRoute(
        path: AppRoutes.trazabilidad,
        builder: (context, state) => const TrazabilidadScreen(),
      ),
      GoRoute(
        path: AppRoutes.seguimientoRecolector,
        builder: (context, state) => const SeguimientoRecolectorScreen(),
      ),

      // ── Puntos ────────────────────────────────────
      GoRoute(
        path: AppRoutes.puntos,
        builder: (context, state) => const PuntosScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.recompensaDetalle}/:id',
        builder: (context, state) {
          // Se espera que la recompensa se pase vía extra
          final recompensa = state.extra;
          if (recompensa is RecompensaEntity) {
            return RecompensaDetalleScreen(recompensa: recompensa);
          }
          return const Scaffold(
            body: Center(child: Text('Recompensa no encontrada')),
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.canjeStatus}/:success',
        builder: (context, state) {
          final success = state.pathParameters['success'] == 'true';
          return CanjeStatusScreen(isSuccess: success);
        },
      ),
      GoRoute(
        path: '${AppRoutes.canjeExitoso}/:id',
        builder: (context, state) {
          // Se espera que la recompensa se pase vía extra
          final recompensa = state.extra;
          if (recompensa is RecompensaEntity) {
            return CanjeExitosoScreen(recompensa: recompensa);
          }
          return const Scaffold(
            body: Center(child: Text('Datos de canje no encontrados')),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Página no encontrada: ${state.error}')),
    ),
  );
});
