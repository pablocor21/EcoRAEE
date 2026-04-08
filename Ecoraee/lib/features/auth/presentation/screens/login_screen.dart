import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../config/router/app_router.dart';
import '../../../../config/constants/app_constants.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/widget/Custom_textfield.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref
        .read(authProvider.notifier)
        .signIn(_emailCtrl.text.trim(), _passCtrl.text.trim());

    if (!mounted) return;

    if (success) {
      final rol = ref.read(authProvider).rol;
      context.go(
        rol == AppConstants.rolAdmin
            ? AppRoutes.dashboardColaborador
            : AppRoutes.dashboardCiudadano,
      );
    } else {
      final error = ref.read(authProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Error al iniciar sesión'),
          backgroundColor: CicloxColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Logo
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: CicloxColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: CicloxColors.dark,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'ciclox',
                      style: TextStyle(
                        color: CicloxColors.dark,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 48),

                Text(
                  'Bienvenido de nuevo',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Inicia sesión para continuar',
                  style: TextStyle(color: CicloxColors.grey, fontSize: 14),
                ),

                const SizedBox(height: 36),

                CustomTextField(
                  label: 'Correo electrónico',
                  controller: _emailCtrl,
                  hint: 'ejemplo@correo.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Ingresa tu correo' : null,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Contraseña',
                  controller: _passCtrl,
                  hint: '••••••••',
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Ingresa tu contraseña' : null,
                ),

                const SizedBox(height: 12),

                // Enlace ¿Olvidaste tu contraseña?
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => context.go(AppRoutes.forgotPassword),
                    child: const Text(
                      '¿Olvidaste tu contraseña?',

                      style: TextStyle(
                        color: CicloxColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: CicloxColors.primary,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text('Iniciar sesión'),
                      ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta? ',
                      style: TextStyle(color: CicloxColors.grey),
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.register),
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                          color: CicloxColors.dark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
