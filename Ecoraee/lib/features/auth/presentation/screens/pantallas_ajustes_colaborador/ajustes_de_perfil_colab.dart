import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/router/app_router.dart';

class AjustesDePerfilColabScreen extends StatelessWidget {
  const AjustesDePerfilColabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF0),
      body: Stack(
        children: [
          // Background top dark area
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF19133B), // Coincide con el color oscuro principal
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // App Bar Customizado
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                      ),
                      const Expanded(
                        child: Text(
                          'AJUSTES DEL PERFIL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), // Balancea la flecha de atrás
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Contenido Principal
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Contenedor redondeado inferior
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 60),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE9EDF0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 70), // Espacio para la foto de perfil
                            
                            // Nombre
                            const Text(
                              'Juan José',
                              style: TextStyle(
                                color: CicloxColors.dark,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            
                            const SizedBox(height: 30),
                            
                            // Tarjeta de Información
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                                children: [
                                  _ProfileInfoRow(
                                    icon: Icons.account_circle,
                                    text: 'Operador CICLOX',
                                  ),
                                  Divider(height: 1, color: Color(0xFFF0F0F0)),
                                  _ProfileInfoRow(
                                    icon: Icons.hub, // Icono similar al del diseño
                                    text: 'ID: 2466658789-2',
                                  ),
                                  Divider(height: 1, color: Color(0xFFF0F0F0)),
                                  _ProfileInfoRow(
                                    icon: Icons.alternate_email,
                                    text: 'juan.jjperez@ciclox.co',
                                  ),
                                  Divider(height: 1, color: Color(0xFFF0F0F0)),
                                  _ProfileInfoRow(
                                    icon: Icons.smartphone,
                                    text: '3125894102',
                                  ),
                                ],
                              ),
                            ),
                            
                            const Spacer(),
                            
                            // Botón Cerrar Sesión
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF19133B),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 55),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Cerrar sesión',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Foto de Perfil superpuesta
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFE9EDF0), width: 8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => context.go(AppRoutes.dashboardCiudadano),
              child: const Icon(Icons.home_filled, color: Color(0xFF19133B), size: 28),
            ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.soporteColaborador),
            child: const Icon(Icons.warning_rounded, color: Color(0xFF19133B), size: 28),
          ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.solicitudes),
              child: const Icon(Icons.local_shipping, color: Color(0xFF19133B), size: 28),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.notificacionesColaborador),
              child: const Icon(
                Icons.notifications_rounded,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
            const Icon(Icons.settings_rounded, color: Color(0xFF19133B), size: 28), // active
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ProfileInfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF19133B), size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
