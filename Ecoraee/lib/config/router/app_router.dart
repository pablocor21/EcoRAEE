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
import '../../features/auth/presentation/providers/auth_provider.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String resetPassword = '/reset-password';
  static const String dashboardCiudadano = '/dashboard';
  static const String dashboardColaborador = '/dashboard-colaborador';
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    redirect: (context, state) {
      // ← Esperar a que cargue el token del storage antes de redirigir
      if (!(authState.isInitialized ?? false)) return null;

      final isLoggedIn = authState.token != null;
      final path = state.uri.path;

      // Rutas donde un usuario logueado NO debe estar
      final isPublicOnlyRoute =
          path == AppRoutes.login ||
          path == AppRoutes.register ||
          path == AppRoutes.onboarding;

      // Todas las rutas que no requieren autenticación
      final isAuthRoute =
          isPublicOnlyRoute ||
          path == AppRoutes.forgotPassword ||
          path.startsWith(AppRoutes.verifyCode) ||
          path.startsWith(AppRoutes.resetPassword);

      // Si no está logueado e intenta acceder a ruta protegida → login
      if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;

      // Si está logueado e intenta ir a login/register/onboarding → dashboard
      if (isLoggedIn && isPublicOnlyRoute) {
        return authState.rol == 'ADMIN'
            ? AppRoutes.dashboardColaborador
            : AppRoutes.dashboardCiudadano;
      }

      return null;
    },
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
        path: AppRoutes.verifyCode,
        builder: (context, state) {
          final queryEmail = state.uri.queryParameters['email']?.trim();
          final email = queryEmail?.isNotEmpty == true
              ? queryEmail!
              : (state.extra is String ? state.extra as String : '');
          print('VerifyCode route builder: email=$email, uri=${state.uri}');
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
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboardColaborador,
        builder: (context, state) => const DashboardColabScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Página no encontrada: ${state.error}')),
    ),
  );
});
