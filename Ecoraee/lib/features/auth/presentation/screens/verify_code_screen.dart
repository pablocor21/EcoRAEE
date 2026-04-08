import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../config/router/app_router.dart';
import '../../presentation/providers/auth_provider.dart';

class VerifyCodeScreen extends ConsumerStatefulWidget {
  final String email;

  const VerifyCodeScreen({super.key, required this.email});

  @override
  ConsumerState<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends ConsumerState<VerifyCodeScreen> {
  late List<TextEditingController> _controllers;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String _getCode() {
    return _controllers.map((c) => c.text).join();
  }

  Future<void> _verificarCodigo() async {
    final code = _getCode();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresa un código de 6 dígitos'),
          backgroundColor: CicloxColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final success = await ref
        .read(authProvider.notifier)
        .validarCodigoRecuperacion(email: widget.email, codigo: code);

    print('validarCodigoRecuperacion success: $success');

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Código verificado correctamente'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      // Navega a la pantalla de nueva contraseña inmediatamente
      final email = Uri.encodeComponent(widget.email);
      final codigo = Uri.encodeComponent(code);
      print('Navegando a reset password con email: $email, codigo: $codigo');
      if (mounted && context.mounted) {
        try {
          context.go('${AppRoutes.resetPassword}/$email/$codigo');
          print('Navigation to reset password executed');
        } catch (e) {
          print('Navigation error: $e');
        }
      }
    } else {
      if (mounted) {
        final error = ref.read(authProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? 'Código inválido'),
            backgroundColor: CicloxColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _onCodeChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        FocusScope.of(context).nextFocus();
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).previousFocus();
      }
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
                  Icons.check_circle_outline_rounded,
                  color: CicloxColors.primary,
                  size: 32,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Verificar código',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Ingresa el código de 6 dígitos enviado a ${widget.email}',
                style: const TextStyle(color: CicloxColors.grey, fontSize: 14),
              ),

              const SizedBox(height: 40),

              // Campos de código
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 45,
                      height: 60,
                      child: TextField(
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: CicloxColors.greyLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: CicloxColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: CicloxColors.dark,
                        ),
                        onChanged: (value) {
                          _onCodeChanged(index, value);
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: CicloxColors.primary,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _verificarCodigo,
                      child: const Text('Verificar código'),
                    ),

              const SizedBox(height: 20),

              // Botón para resolicitar código
              Center(
                child: Column(
                  children: [
                    const Text(
                      '¿No recibiste el código?',
                      style: TextStyle(color: CicloxColors.grey),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // Resolicitar código
                        ref
                            .read(authProvider.notifier)
                            .solicitarCodigoRecuperacion(widget.email);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Código reenviado a tu correo'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: const Text(
                        'Reenviar código',
                        style: TextStyle(
                          color: CicloxColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
