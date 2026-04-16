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

class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String resetPassword = '/reset-password';
  static const String dashboardCiudadano = '/dashboard';
  static const String dashboardColaborador = '/dashboard-colaborador';
  static const String registroDispositivo = '/registro-dispositivo';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.onboarding,
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
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboardColaborador,
        builder: (context, state) => const DashboardColabScreen(),
      ),
      GoRoute(
        path: AppRoutes.registroDispositivo,
        builder: (context, state) => const RegistroDispositivoScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Página no encontrada: ${state.error}')),
    ),
  );
});
