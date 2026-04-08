import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../config/router/app_router.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/widget/Custom_textfield.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String email;
  final String codigo;

  ResetPasswordScreen({super.key, required this.email, required this.codigo}) {
    print('ResetPasswordScreen creado con email: $email, codigo: $codigo');
  }

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nuevaPassCtrl = TextEditingController();
  final _confirmarPassCtrl = TextEditingController();

  @override
  void dispose() {
    _nuevaPassCtrl.dispose();
    _confirmarPassCtrl.dispose();
    super.dispose();
  }

  Future<void> _cambiarContrasena() async {
    if (!_formKey.currentState!.validate()) return;

    if (_nuevaPassCtrl.text != _confirmarPassCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Las contraseñas no coinciden'),
          backgroundColor: CicloxColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final success = await ref
        .read(authProvider.notifier)
        .establecerNuevaContrasena(
          email: widget.email,
          codigo: widget.codigo,
          contrasenaNueva: _nuevaPassCtrl.text.trim(),
        );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Contraseña cambiada exitosamente!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // Navega al login
      context.go(AppRoutes.login);
    } else {
      final error = ref.read(authProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Error al cambiar contraseña'),
          backgroundColor: CicloxColors.error,
          behavior: SnackBarBehavior.floating,
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
          onPressed: () => context.pop(),
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
                const SizedBox(height: 20),

                // Ícono
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: CicloxColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.lock_open_rounded,
                    color: CicloxColors.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'Nueva contraseña',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Crea una nueva contraseña segura para tu cuenta',
                  style: TextStyle(color: CicloxColors.grey, fontSize: 14),
                ),

                const SizedBox(height: 32),

                CustomTextField(
                  label: 'Nueva contraseña',
                  controller: _nuevaPassCtrl,
                  hint: '••••••••',
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Ingresa una nueva contraseña';
                    }
                    if (v.length < 6) {
                      return 'Mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Confirmar contraseña',
                  controller: _confirmarPassCtrl,
                  hint: '••••••••',
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Confirma tu contraseña';
                    }
                    if (v.length < 6) {
                      return 'Mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Indicador de seguridad
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CicloxColors.primaryLight.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Consejos para una contraseña segura:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: CicloxColors.dark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _Tip(
                        text: 'Al menos 6 caracteres',
                        isValid: _nuevaPassCtrl.text.length >= 6,
                      ),
                      _Tip(
                        text: 'Usa mayúsculas y minúsculas',
                        isValid:
                            _nuevaPassCtrl.text.contains(RegExp(r'[A-Z]')) &&
                            _nuevaPassCtrl.text.contains(RegExp(r'[a-z]')),
                      ),
                      _Tip(
                        text: 'Usa números o símbolos',
                        isValid: _nuevaPassCtrl.text.contains(
                          RegExp(r'[0-9!@#$%^&*]'),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: CicloxColors.primary,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _cambiarContrasena,
                        child: const Text('Cambiar contraseña'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tip extends StatelessWidget {
  final String text;
  final bool isValid;

  const _Tip({required this.text, required this.isValid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: isValid ? Colors.green : CicloxColors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isValid ? CicloxColors.dark : CicloxColors.grey,
              fontWeight: isValid ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
