import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../config/router/app_router.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/widget/Custom_textfield.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _dirCtrl = TextEditingController();

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _telCtrl.dispose();
    _dirCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref
        .read(authProvider.notifier)
        .register(
          nombre: _nombreCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          contrasena: _passCtrl.text.trim(),
          direccion: _dirCtrl.text.trim(),
          telefono: _telCtrl.text.trim(),
        );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Registro exitoso! Inicia sesión'),
          backgroundColor: Colors.green,
        ),
      );
      context.go(AppRoutes.login);
    } else {
      final error = ref.read(authProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Error al registrarse'),
          backgroundColor: CicloxColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go(AppRoutes.login),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crear cuenta',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Únete a la comunidad Ciclox',
                  style: TextStyle(color: CicloxColors.grey),
                ),
                const SizedBox(height: 32),

                CustomTextField(
                  label: 'Nombre completo',
                  controller: _nombreCtrl,
                  hint: 'Juan Pérez',
                  prefixIcon: Icons.person_outline,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Ingresa tu nombre' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Correo electrónico',
                  controller: _emailCtrl,
                  hint: 'ejemplo@correo.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Ingresa tu correo' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Contraseña',
                  controller: _passCtrl,
                  hint: '••••••••',
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Ingresa una contraseña';
                    if (v.length < 6) return 'Mínimo 6 caracteres';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Teléfono',
                  controller: _telCtrl,
                  hint: '3001234567',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Ingresa tu teléfono' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Dirección',
                  controller: _dirCtrl,
                  hint: 'Calle 123 #45-67',
                  prefixIcon: Icons.location_on_outlined,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Ingresa tu dirección' : null,
                ),
                const SizedBox(height: 32),

                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: CicloxColors.primary,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _register,
                        child: const Text('Registrarme'),
                      ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Ya tienes cuenta? ',
                      style: TextStyle(color: CicloxColors.grey),
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.login),
                      child: const Text(
                        'Inicia sesión',
                        style: TextStyle(
                          color: CicloxColors.dark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
