import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../profile/presentation/pages/profile_header.dart';
import '../../../profile/presentation/widgets/profile_bottom_nav.dart';
import '../bloc/notificaciones_bloc.dart';
import '../bloc/notificaciones_event.dart';
import '../bloc/notificaciones_state.dart';

class NotificacionesPage extends StatefulWidget {
  const NotificacionesPage({super.key});

  @override
  State<NotificacionesPage> createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificacionesBloc>().add(LoadNotificaciones());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<NotificacionesBloc, NotificacionesState>(
          builder: (context, state) {
            return Column(
              children: [
                const ProfileHeader(title: 'Notificacion', showBack: true),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement Clear All
                      },
                      child: const Text(
                        'Eliminar todo',
                        style: TextStyle(
                          color: AppColors.navy,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator(color: AppColors.navy))
                      : state.items.isEmpty
                          ? const _EmptyNotificaciones()
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                final notificacion = state.items[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: _buildNotificationSection(
                                    notificacion.titulo,
                                    notificacion.mensaje,
                                    _formatTimeAgo(notificacion.fecha),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const ProfileBottomNav(currentIndex: -1),
    );
  }

  Widget _buildNotificationSection(String title, String message, String time) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 1) {
      return 'Hace ${diff.inDays} días';
    } else if (diff.inDays == 1) {
      return 'Ayer';
    } else if (diff.inHours > 0) {
      return 'Hace ${diff.inHours} horas';
    } else if (diff.inMinutes > 0) {
      return 'Hace ${diff.inMinutes} minutos';
    } else {
      return 'Hace un momento';
    }
  }

}

class _EmptyNotificaciones extends StatelessWidget {
  const _EmptyNotificaciones();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No hay notificaciones'),
    );
  }
}

