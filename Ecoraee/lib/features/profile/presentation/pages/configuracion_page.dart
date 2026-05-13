import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'profile_header.dart';
import 'editar_perfil_page.dart';
import 'accesibilidad_page.dart';
import 'terminos_condiciones_page.dart';
import 'politicas_prevencion_page.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../widgets/profile_bottom_nav.dart';

class ConfiguracionPage extends StatefulWidget {
  const ConfiguracionPage({super.key});

  @override
  State<ConfiguracionPage> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  bool gpsPermission = true;
  bool notificationPermission = false;
  bool contactPermission = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7E9),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const ProfileHeader(title: 'Configuracion', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  _buildMenuCard([
                    _buildMenuItem(
                      'Editar datos personales',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EditarPerfilPage()),
                      ),
                    ),
                    _buildMenuItem(
                      'Accesibilidad',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AccesibilidadPage()),
                      ),
                    ),
                    _buildMenuItem(
                      'Términos y condiciones',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TerminosCondicionesPage()),
                      ),
                    ),
                    _buildMenuItem(
                      'Políticas de prevención',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PoliticasPrevencionPage()),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Permisos de la app'),
                  _buildPermissionsCard(),
                  const SizedBox(height: 10),
                  const Text(
                    'La APP utiliza estos permisos para mejorar tu experiencia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement Logout
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navy,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Cerrar Sesión',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ProfileBottomNav(currentIndex: 0),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Text(
        title,
        style: AppTextStyles.heading2.copyWith(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildMenuItem(String title, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.navy,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.navy),
          ],
        ),
      ),
    );
  }


  Widget _buildPermissionsCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildPermissionItem('Ubicacion GPS', gpsPermission, (val) => setState(() => gpsPermission = val)),
          _buildPermissionItem('Notificaciones', notificationPermission, (val) => setState(() => notificationPermission = val)),
          _buildPermissionItem('Contactos', contactPermission, (val) => setState(() => contactPermission = val)),
        ],
      ),
    );
  }

  Widget _buildPermissionItem(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: AppColors.navy),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.orange, // Based on image colors
          ),
        ],
      ),
    );
  }

}
