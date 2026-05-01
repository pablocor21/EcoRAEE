import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/router/app_router.dart';

class AjustesNotificacionesColabScreen extends StatefulWidget {
  const AjustesNotificacionesColabScreen({super.key});

  @override
  State<AjustesNotificacionesColabScreen> createState() =>
      _AjustesNotificacionesColabScreenState();
}

class _AjustesNotificacionesColabScreenState
    extends State<AjustesNotificacionesColabScreen> {
  bool _nuevasSolicitudes = true;
  bool _estadoRecoleccion = true;
  bool _problemasReportes = true;
  bool _vibrar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF0),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Customizado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: CicloxColors.dark,
                      size: 20,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'NOTIFICACIONES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CicloxColors.dark,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ), // Balance para el icono de regresar
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Lista de configuraciones de notificaciones (Sliders interactivos)
            _buildNotificationSwitch(
              title: 'Nuevas solicitudes',
              value: _nuevasSolicitudes,
              onChanged: (val) {
                setState(() {
                  _nuevasSolicitudes = val;
                });
              },
            ),

            _buildNotificationSwitch(
              title: 'Estado de recolección',
              value: _estadoRecoleccion,
              onChanged: (val) {
                setState(() {
                  _estadoRecoleccion = val;
                });
              },
            ),

            _buildNotificationSwitch(
              title: 'Problemas / reportes',
              value: _problemasReportes,
              onChanged: (val) {
                setState(() {
                  _problemasReportes = val;
                });
              },
            ),

            _buildNotificationSwitch(
              title: 'Vibrar',
              value: _vibrar,
              onChanged: (val) {
                setState(() {
                  _vibrar = val;
                });
              },
            ),

            const Spacer(),
          ],
        ),
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
              child: const Icon(
                Icons.home_filled,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
            const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFF19133B),
              size: 28,
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.solicitudes),
              child: const Icon(
                Icons.local_shipping,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
            const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF19133B),
              size: 28,
            ),
            GestureDetector(
              onTap: () => context.go(
                AppRoutes.ajustesColaborador,
              ), // Llevando a Ajustes Colaborador
              child: const Icon(
                Icons.settings,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSwitch({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Transform.scale(
            scale: 0.9,
            child: Switch(
              value: value,
              activeThumbColor: Colors.white,
              activeTrackColor: const Color(0xFF34C759), // Verde iOS
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFD1D1D6),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
