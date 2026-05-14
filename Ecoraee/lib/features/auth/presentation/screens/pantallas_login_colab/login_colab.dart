import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/router/app_router.dart';
import '../../../../../injection_container.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

/// Pantalla de login para Colaboradores (rol EMPRESA).
/// Al autenticarse correctamente navega a [DashboardScreen].
class LoginColabScreen extends StatelessWidget {
  const LoginColabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: const _LoginColabBody(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BODY — con acceso al BLoC
// ─────────────────────────────────────────────────────────────────────────────
class _LoginColabBody extends StatefulWidget {
  const _LoginColabBody();

  @override
  State<_LoginColabBody> createState() => _LoginColabBodyState();
}

class _LoginColabBodyState extends State<_LoginColabBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pinCtrl.dispose();
    super.dispose();
  }

  void _submit(BuildContext ctx) {
    if (_formKey.currentState?.validate() ?? false) {
      ctx.read<AuthBloc>().add(LoginRequested(
            email: _emailCtrl.text.trim(),
            contrasena: _pinCtrl.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (ctx, state) {
        if (state is AuthAuthenticated) {
          if (state.usuario.esEmpresa) {
            // ✅ Colaborador autenticado → ir al Dashboard de colaborador
            ctx.go(AppRoutes.dashboardColaborador);
          } else {
            // Usuario ciudadano intentando entrar como colaborador
            ctx.read<AuthBloc>().add(LogoutRequested());
            ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(
                content: Text(
                  'Esta cuenta es de Usuario. Por favor ingresa desde la opción Usuarios.',
                ),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        } else if (state is AuthError) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (ctx, state) {
        final loading = state is AuthLoading;

        return Scaffold(
          backgroundColor: CicloxColors.primaryLight,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ── Top Banner with Wave ──────────────────
                  Stack(
                    children: [
                      ClipPath(
                        clipper: _BannerClipper(),
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          color: CicloxColors.secondary,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'BIENVENIDO',
                                style: TextStyle(
                                  color: CicloxColors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Logo ──────────────────────────────────
                  Image.asset(
                    'assets/iconos/VARIACION 4 COLOR.png',
                    height: 180,
                  ),

                  const SizedBox(height: 40),

                  // ── Form ──────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        // Email / Usuario
                        _CustomTextField(
                          controller: _emailCtrl,
                          label: 'Usuario (correo)',
                          icon: Icons.person_rounded,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Ingresa tu correo';
                            }
                            if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w+$')
                                .hasMatch(v.trim())) {
                              return 'Correo inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        // Pin / Contraseña
                        _CustomTextField(
                          controller: _pinCtrl,
                          label: 'Pin / Contraseña',
                          icon: Icons.lock_rounded,
                          isPassword: true,
                          obscure: _obscure,
                          onToggleObscure: () =>
                              setState(() => _obscure = !_obscure),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Ingresa tu pin' : null,
                        ),
                        const SizedBox(height: 50),

                        // ── Login Button ────────────────────
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: loading ? null : () => _submit(ctx),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CicloxColors.secondary,
                              foregroundColor: CicloxColors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: loading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Ingresar',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // ── Footer Links ────────────────────
                        _FooterLink(
                          label: 'Recuperar credenciales',
                          onTap: () => context
                              .push(AppRoutes.recuperarCredencialesColaborador),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WIDGETS PRIVADOS
// ─────────────────────────────────────────────────────────────────────────────

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isPassword;
  final bool obscure;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _CustomTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.obscure = false,
    this.onToggleObscure,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CicloxColors.secondary.withOpacity(0.5),
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CicloxColors.secondary.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: CicloxColors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: isPassword ? obscure : false,
              textAlign: TextAlign.center,
              keyboardType: keyboardType,
              validator: validator,
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(
                  color: CicloxColors.dark.withOpacity(0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          if (isPassword && onToggleObscure != null)
            IconButton(
              icon: Icon(
                obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: CicloxColors.secondary,
                size: 20,
              ),
              onPressed: onToggleObscure,
            )
          else
            const SizedBox(width: 44),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/iconos/VARIACION 4 AZUL.png',
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: CicloxColors.dark.withOpacity(0.7),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);

    final controlPoint = Offset(size.width / 2, size.height + 20);
    final endPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
