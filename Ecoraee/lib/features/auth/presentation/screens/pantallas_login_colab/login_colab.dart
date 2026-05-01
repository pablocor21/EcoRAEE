import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/router/app_router.dart';

class LoginColabScreen extends StatelessWidget {
  const LoginColabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.primaryLight,
      body: SingleChildScrollView(
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
                  _CustomTextField(
                    label: 'Usuario',
                    icon: Icons.person_rounded,
                  ),
                  const SizedBox(height: 30),
                  _CustomTextField(
                    label: 'Pin',
                    icon: Icons.lock_rounded,
                    isPassword: true,
                  ),
                  const SizedBox(height: 50),

                  // ── Login Button ────────────────────
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => context.go(AppRoutes.dashboardCiudadano),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CicloxColors.secondary,
                        foregroundColor: CicloxColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
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
                    onTap: () => context.push(AppRoutes.recuperarCredencialesColaborador),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;

  const _CustomTextField({
    required this.label,
    required this.icon,
    this.isPassword = false,
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
            child: TextField(
              obscureText: isPassword,
              textAlign: TextAlign.center,
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
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 44), // To balance the icon on the left
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
