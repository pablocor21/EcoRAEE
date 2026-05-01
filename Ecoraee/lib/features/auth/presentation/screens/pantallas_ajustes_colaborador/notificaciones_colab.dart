import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/theme/app_theme.dart';

class NotificacionesColabScreen extends StatelessWidget {
  const NotificacionesColabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
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
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: CicloxColors.dark,
                        size: 18,
                      ),
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
                    width: 40,
                  ), // Balance para el icono de regresar
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                physics: const BouncingScrollPhysics(),
                children: [
                  const _NotificationItem(
                    title: 'Nueva solicitud asignada',
                    message:
                        'Se te ha asignado una nueva solicitud de recolección en Av. Principal #123.',
                    time: 'Hace 5 min',
                    isRead: false,
                    icon: Icons.local_shipping_rounded,
                  ),
                  const _NotificationItem(
                    title: 'Actualización de Perfil',
                    message:
                        'Los datos de tu empresa han sido validados correctamente. Ya puedes operar sin restricciones.',
                    time: 'Hace 2 horas',
                    isRead: true,
                    icon: Icons.business_rounded,
                  ),
                  const _NotificationItem(
                    title: 'Recordatorio de Recolección',
                    message:
                        'Recuerda que tienes 3 recolecciones pendientes para el día de hoy antes de las 6:00 PM.',
                    time: 'Ayer',
                    isRead: true,
                    icon: Icons.calendar_today_rounded,
                  ),

                  const SizedBox(height: 30),

                  // Mensaje informativo sobre el futuro backend
                  Center(
                    child: Text(
                      'Las notificaciones se sincronizarán con el servidor automáticamente.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool isRead;
  final IconData icon;

  const _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isRead
                  ? const Color(0xFFF0F2F5)
                  : CicloxColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: isRead ? Colors.grey[500] : CicloxColors.dark,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: CicloxColors.dark,
                          fontWeight: isRead
                              ? FontWeight.w600
                              : FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (!isRead)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: CicloxColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
