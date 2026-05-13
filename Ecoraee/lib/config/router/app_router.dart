import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ── Bloc Imports ──────────────────────────────────
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../injection_container.dart';

// ── Core Imports ──
import 'dart:convert';
import '../../core/storage/secure_storage.dart';
import '../../core/router/app_routes.dart' as CoreRoutes;
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/recuperar_contrasena_page.dart';
import '../../features/auth/presentation/pages/verificar_codigo_page.dart';
import '../../features/auth/presentation/pages/cambiar_contrasena_page.dart';
import '../../features/home/presentation/pages/home_usuario_page.dart';
import '../../features/home/presentation/pages/home_empresa_page.dart';
import '../../features/empresas/presentation/pages/empresa_solicitudes_page.dart';
import '../../features/empresas/presentation/pages/empresa_recolectores_page.dart';
import '../../features/empresas/presentation/pages/empresa_reciclajes_page.dart';
import '../../features/empresas/presentation/pages/empresa_reportes_page.dart';
import '../../features/empresas/solicitudes/presentation/bloc/empresa_solicitudes_bloc.dart';
import '../../features/empresas/recolectores/presentation/bloc/recolectores_bloc.dart';
import '../../features/dispositivos/presentation/pages/dispositivos_list_page.dart';
import '../../features/dispositivos/presentation/pages/registro_dispositivo_page.dart';
import '../../features/dispositivos/presentation/pages/registro_exito_page.dart';
import '../../features/solicitudes/presentation/pages/crear_solicitud_page.dart';
import '../../features/solicitudes/presentation/pages/solicitud_enviada_page.dart';
import '../../features/solicitudes/presentation/pages/solicitud_cancelada_page.dart';
import '../../features/solicitudes/presentation/pages/solicitudes_menu_page.dart';
import '../../features/solicitudes/presentation/pages/solicitudes_page.dart';
import '../../features/solicitudes/presentation/bloc/solicitudes_bloc.dart';
import '../../features/puntos/presentation/bloc/puntos_bloc.dart';
import '../../features/puntos/presentation/pages/tus_puntos_page.dart';
import '../../features/notificaciones/presentation/bloc/notificaciones_bloc.dart';
import '../../features/notificaciones/presentation/pages/notificaciones_page.dart';
import '../../features/trazabilidad/presentation/bloc/trazabilidad_bloc.dart';
import '../../features/trazabilidad/presentation/pages/trazabilidad_lista_page.dart';
import '../../features/trazabilidad/presentation/pages/trazabilidad_detalle_page.dart';
import '../../features/trazabilidad/presentation/pages/trazabilidad_mapa_page.dart';
import '../../features/recompensas/presentation/bloc/recompensas_bloc.dart';
import '../../features/recompensas/presentation/pages/bono_ciclox_page.dart';
import '../../features/recompensas/presentation/pages/mercaditos_page.dart';
import '../../features/recompensas/domain/entities/recompensa_entity.dart' as IngRecompensa;
import '../../features/canjes/presentation/bloc/canjes_bloc.dart';
import '../../features/canjes/presentation/pages/qr_bono_ciclox_page.dart';
import '../../features/canjes/presentation/pages/qr_mercaditos_page.dart';
import '../../features/canjes/presentation/pages/canje_exitoso_page.dart';
import '../../features/canjes/presentation/pages/canje_rechazado_page.dart';
import '../../features/profile/presentation/pages/configuracion_page.dart';
import '../../features/profile/presentation/pages/editar_perfil_page.dart';
import '../../features/profile/presentation/pages/accesibilidad_page.dart';
import '../../features/profile/presentation/pages/politicas_prevencion_page.dart';
import '../../features/profile/presentation/pages/terminos_condiciones_page.dart';


// ── Auth screens ──────────────────────────────────
import '../../features/auth/presentation/screens/pantallas_login_colab/login_colab.dart';
import '../../features/auth/presentation/screens/pantallas_login_colab/recuperar_credenciales.dart';
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
import '../../features/auth/presentation/screens/pantallas_ajustes_colaborador/notificaciones_colab.dart';

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
  static const String loginUsuario = '/login-usuario';
  static const String dashboardCiudadano = '/dashboard';
  static const String perfilCiudadano = '/perfil';
  static const String dashboardColaborador = '/dashboard-colaborador';
  static const String registroDispositivo = '/registro-dispositivo';
  static const String dispositivoRegistrado = '/dispositivo-registrado';
  static const String registros = '/registros';
  static const String historial = '/historial';
  static const String solicitudes = '/solicitudes-colaborador';
  static const String detallesSolicitud = '/detalles-solicitud';
  static const String crearSolicitud = '/crear-solicitud';
  static const String crearSolicitudPaso2 = '/crear-solicitud-paso2';
  static const String crearSolicitudResumen = '/crear-solicitud-resumen';
  static const String seguimientoSolicitudes = '/seguimiento-solicitudes';
  static const String solicitudCancelada = '/solicitud-cancelada';
  static const String solicitudEnviada = '/solicitud-enviada';
  static const String recoleccion = '/recoleccion';
  static const String politicasPrevencion = '/politicas-prevencion';
  static const String trazabilidad = '/trazabilidad-colaborador';
  static const String seguimientoRecolector = '/seguimiento-recolector';
  static const String puntos = '/puntos-colaborador';
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
  static const String loginColaborador = '/login-colaborador';
  static const String recuperarCredencialesColaborador = '/recuperar-credenciales-colaborador';
  static const String notificacionesColaborador = '/notificaciones-colaborador';
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
        name: 'loginColaborador',
        path: AppRoutes.loginColaborador,
        // LoginColabScreen gestiona su propio BlocProvider internamente
        builder: (context, state) => const LoginColabScreen(),
      ),
      GoRoute(
        name: 'recuperarCredencialesColaborador',
        path: AppRoutes.recuperarCredencialesColaborador,
        builder: (context, state) => const RecuperarCredencialesScreen(),
      ),
      GoRoute(
        name: 'login',
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'loginUsuario',
        path: AppRoutes.loginUsuario,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const LoginPage(),
        ),
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
      GoRoute(
        path: AppRoutes.notificacionesColaborador,
        builder: (context, state) => const NotificacionesColabScreen(),
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
    
      // ── Core Routes ──




      // ── AUTH ────────────────────────────────────────────────────
      GoRoute(
        path: CoreRoutes.AppRoutes.login,
        builder: (ctx, _) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.registro,
        builder: (ctx, _) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const RegisterPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.recuperarContrasena,
        builder: (ctx, _) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const RecuperarContrasenaPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.verificarCodigo,
        builder: (ctx, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: VerificarCodigoPage(email: email),
          );
        },
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.cambiarContrasena,
        builder: (ctx, state) {
          final extra =
              (state.extra as Map?)?.cast<String, String>() ?? {};
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: CambiarContrasenaPage(
              email: extra['email'] ?? '',
              codigo: extra['codigo'] ?? '',
            ),
          );
        },
      ),

      // ── HOME ─────────────────────────────────────────────────────
      GoRoute(
        path: CoreRoutes.AppRoutes.homeUsuario,
        builder: (ctx, _) => _HomeUsuarioWrapper(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.homeEmpresa,
        builder: (_, __) => const HomeEmpresaPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.empresaSolicitudes,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<EmpresaSolicitudesBloc>(),
          child: const EmpresaSolicitudesPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.empresaRecolectores,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<RecolectoresBloc>(),
          child: const EmpresaRecolectoresPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.empresaReciclajes,
        builder: (_, __) => const EmpresaReciclajesPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.empresaReportes,
        builder: (_, __) => const EmpresaReportesPage(),
      ),

      // ── DISPOSITIVOS ─────────────────────────────────────────────
      GoRoute(
        path: CoreRoutes.AppRoutes.dispositivos,
        builder: (_, __) => const DispositivosListPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.registroDispositivo,
        builder: (_, __) => const RegistroDispositivoPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.registroDispositivoExito,
        builder: (_, __) => const RegistroExitoPage(),
      ),

      // ── SOLICITUDES ──────────────────────────────────────────────
      GoRoute(
        path: CoreRoutes.AppRoutes.solicitudes,
        builder: (_, __) => const SolicitudesMenuPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.misSolicitudes,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<SolicitudesBloc>(),
          child: const SolicitudesPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.crearSolicitud,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<SolicitudesBloc>(),
          child: const CrearSolicitudPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.solicitudEnviada,
        builder: (_, __) => const SolicitudEnviadaPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.solicitudCancelada,
        builder: (_, __) => const SolicitudCanceladaPage(),
      ),

      // ── PUNTOS ───────────────────────────────────────────────────
      GoRoute(
        path: CoreRoutes.AppRoutes.tusPuntos,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<PuntosBloc>(),
          child: const TusPuntosPage(),
        ),
      ),

      // ── RECOMPENSAS ──────────────────────────────────────────────
      GoRoute(
        path: CoreRoutes.AppRoutes.bonoCiclox,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<RecompensasBloc>(),
          child: const BonoCicloxPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.mercaditos,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<RecompensasBloc>(),
          child: const MercaditosPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.qrBonoCiclox,
        builder: (_, state) {
          final recompensa = state.extra as IngRecompensa.RecompensaEntity?;
          if (recompensa == null) return const CanjeRechazadoPage();
          return BlocProvider(
            create: (_) => sl<CanjesBloc>(),
            child: QrBonoCicloxPage(recompensa: recompensa),
          );
        },
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.qrMercaditos,
        builder: (_, state) {
          final recompensa = state.extra as IngRecompensa.RecompensaEntity?;
          if (recompensa == null) return const CanjeRechazadoPage();
          return BlocProvider(
            create: (_) => sl<CanjesBloc>(),
            child: QrMercaditosPage(recompensa: recompensa),
          );
        },
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.canjeExitoso,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<CanjesBloc>(),
          child: const CanjeExitosoPage(),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.canjeRechazado,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<CanjesBloc>(),
          child: const CanjeRechazadoPage(),
        ),
      ),

      // ── TRAZABILIDAD ─────────────────────────────────────────────
      GoRoute(
        path: CoreRoutes.AppRoutes.trazabilidad,
        builder: (_, __) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<SolicitudesBloc>()),
            BlocProvider(create: (_) => sl<TrazabilidadBloc>()),
          ],
          child: const TrazabilidadListaPage(),
        ),
      ),
      GoRoute(
        path: '/trazabilidad/detalle',
        builder: (_, state) => BlocProvider(
          create: (_) => sl<TrazabilidadBloc>(),
          child: TrazabilidadDetallePage(
            dispositivoId: (state.extra as int?) ?? 0,
          ),
        ),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.trazabilidadMapa,
        builder: (_, state) => BlocProvider(
          create: (_) => sl<TrazabilidadBloc>(),
          child: TrazabilidadMapaPage(
            solicitudId: (state.extra as int?) ?? 0,
          ),
        ),
      ),

      // ── NOTIFICACIONES ───────────────────────────────────────────
      GoRoute(
        path: CoreRoutes.AppRoutes.notificaciones,
        builder: (_, __) => BlocProvider(
          create: (_) => sl<NotificacionesBloc>(),
          child: const NotificacionesPage(),
        ),
      ),

      // ── PERFIL / CONFIGURACION ─────────────────────────────────
      GoRoute(
        path: CoreRoutes.AppRoutes.configuracion,
        builder: (_, __) => const ConfiguracionPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.editarPerfil,
        builder: (_, __) => const EditarPerfilPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.accesibilidad,
        builder: (_, __) => const AccesibilidadPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.politicasPrevencion,
        builder: (_, __) => const PoliticasPrevencionPage(),
      ),
      GoRoute(
        path: CoreRoutes.AppRoutes.terminosCondiciones,
        builder: (_, __) => const TerminosCondicionesPage(),
      ),
    
],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Página no encontrada: ${state.error}')),
    ),
  );
});

class _HomeUsuarioWrapper extends StatefulWidget {
  @override
  State<_HomeUsuarioWrapper> createState() => _HomeUsuarioWrapperState();
}

class _HomeUsuarioWrapperState extends State<_HomeUsuarioWrapper> {
  String _nombre = 'Usuario';
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadNombre();
  }

  Future<void> _loadNombre() async {
    try {
      final data = await sl<SecureStorage>().getUserData();
      if (data != null) {
        final map = jsonDecode(data) as Map<String, dynamic>;
        if (mounted) {
          setState(() {
            _nombre = map['nombre'] as String? ?? 'Usuario';
            _loaded = true;
          });
          return;
        }
      }
    } catch (_) {}
    if (mounted) setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1F3C),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFB4E614),
          ),
        ),
      );
    }
    return HomeUsuarioPage(nombreUsuario: _nombre);
  }
}
