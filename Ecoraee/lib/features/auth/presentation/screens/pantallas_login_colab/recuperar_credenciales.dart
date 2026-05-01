import 'package:flutter/material.dart';
import '../../../../../config/theme/app_theme.dart';

class RecuperarCredencialesScreen extends StatelessWidget {
  const RecuperarCredencialesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const bannerHeight = 180.0;

    return Scaffold(
      backgroundColor: CicloxColors.primaryLight,
      body: Column(
        children: [
          // ── Top Banner ──────────────────────────────
          Stack(
            children: [
              ClipPath(
                clipper: _BannerClipper(),
                child: Container(
                  height: bannerHeight,
                  width: double.infinity,
                  color: CicloxColors.dark,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: Text(
                        'RECUPERAR CREDENCIALES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CicloxColors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Botón de retroceso
              SafeArea(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: CicloxColors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),

          // ── Form Content Centered ───────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                constraints: BoxConstraints(
                  minHeight:
                      size.height -
                      bannerHeight -
                      MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CustomTextField(
                      label: 'Celular',
                      icon: Icons.phone_android_rounded,
                    ),
                    const SizedBox(height: 35),
                    _CustomTextField(
                      label: 'Cédula',
                      icon: Icons.person_rounded,
                    ),
                    const SizedBox(height: 35),
                    _CustomTextField(
                      label: 'Correo corporativo',
                      icon: Icons.alternate_email_rounded,
                    ),

                    const SizedBox(height: 60),

                    // ── Enviar Información Button ────────────
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () => _showConfirmationDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CicloxColors.secondary,
                          foregroundColor: CicloxColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Enviar información',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: CicloxColors.dark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Image.asset(
                  'assets/imagenes/VARIACION 3 VERDE.png',
                  height: 120,
                ),
                const SizedBox(height: 20),
                
                // Texto de información
                const Text(
                  'Si esta información es correcta y se encuentra en nuestra base de datos, en un momento se le enviarán a su correo sus credenciales de ingreso.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CicloxColors.white,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Recuerde que si necesita cambiar uno de sus datos (correo, pin o teléfono), solicite el cambio a su superior.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CicloxColors.white.withOpacity(0.7),
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Botón ENVIAR
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cerrar popup
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Información enviada con éxito, esté pendiente a su correo electrónico',
                            style: TextStyle(color: CicloxColors.dark),
                          ),
                          backgroundColor: CicloxColors.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8F2D9), // Color clarito del botón en la foto
                      foregroundColor: CicloxColors.dark,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'ENVIAR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;

  const _CustomTextField({required this.label, required this.icon});

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
              color: CicloxColors.dark,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: CicloxColors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
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
          const SizedBox(width: 44),
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
