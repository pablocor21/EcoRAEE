import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/router/app_router.dart';

class PoliticasColabScreen extends StatelessWidget {
  const PoliticasColabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF19133B), // Fondo oscuro base
      body: Stack(
        children: [
          // 1. Fondo decorativo (opcional, para mantener consistencia)
          // const _BackgroundPattern(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // 2. Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Row(
                    children: [
                      // Botón atrás
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: const SizedBox(
                          width: 40,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      // Título central
                      const Expanded(
                        child: Text(
                          'POLÍTICAS\nEMPRESARIALES',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      // Espaciador para balancear el botón de atrás y mantener el texto centrado
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // 3. Contenedor Blanco principal
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F6F8), // Blanco/Gris muy claro
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                    child: Column(
                      children: [
                        // Lista de políticas
                        _PolicyItem(
                          label: 'Términos y condiciones',
                          onTap: () => context.push(
                            AppRoutes.terminosCondicionesColaborador,
                          ),
                        ),
                        const Divider(height: 1, color: Colors.black12),
                        _PolicyItem(
                          label: 'Políticas de privacidad',
                          onTap: () => context.push(AppRoutes.politicasPrivacidadColaborador),
                        ),
                        const Divider(height: 1, color: Colors.black12),
                        _PolicyItem(
                          label: 'Política de reciclaje',
                          onTap: () => context.push(AppRoutes.politicaReciclajeColaborador),
                        ),
                        const Divider(height: 1, color: Colors.black12),
                        _PolicyItem(
                          label: 'Uso de la plataforma',
                          onTap: () => context.push(AppRoutes.usoPlataformaColaborador),
                        ),
                        const Divider(height: 1, color: Colors.black12),

                        const Spacer(),

                        // Logo Variación Azul
                        Image.asset(
                          'assets/imagenes/VARIACION 3 AZUL.png',
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),

                        // Caja de última actualización
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                'Última actualización:',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Mayo 2026',
                                style: TextStyle(
                                  color: Color(0xFF19133B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _CustomBottomNavBar(),
    );
  }
}

class _PolicyItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PolicyItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF19133B),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF19133B), size: 28),
          ],
        ),
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  const _CustomBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2), // Sombra hacia arriba
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => context.go(AppRoutes.dashboardCiudadano),
            child: const Icon(
              Icons.home_filled,
              color: Color(0xFF19133B),
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.soporteColaborador),
            child: const Icon(
              Icons.warning_rounded,
              color: Color(0xFF19133B),
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.solicitudes),
            child: const Icon(
              Icons.local_shipping,
              color: Color(0xFF19133B),
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.notificacionesColaborador),
            child: const Icon(
              Icons.notifications_rounded,
              color: Color(0xFF19133B),
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.ajustesColaborador),
            child: const Icon(
              Icons.settings_rounded,
              color: Color(0xFF19133B),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
