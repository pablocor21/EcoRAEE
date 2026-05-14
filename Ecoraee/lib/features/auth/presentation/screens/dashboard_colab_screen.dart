import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/router/app_router.dart';
import '../../../empresas/solicitudes/domain/entities/empresa_solicitud_entity.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_bloc.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_event.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_state.dart';

class DashboardColabScreen extends StatefulWidget {
  const DashboardColabScreen({super.key});

  @override
  State<DashboardColabScreen> createState() => _DashboardColabScreenState();
}

class _DashboardColabScreenState extends State<DashboardColabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<EmpresaSolicitudesBloc>().add(const LoadEmpresaSolicitudes());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text('Dashboard Colaborador'),
        backgroundColor: const Color(0xFF19133B), // Ciclox dark
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFB2F333),
          labelColor: const Color(0xFFB2F333),
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Disponibles'),
            Tab(text: 'Mis Recolecciones'),
          ],
        ),
      ),
      body: BlocConsumer<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
        listener: (context, state) {
          if (state is EmpresaSolicitudesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is EmpresaSolicitudesActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            // Refresh list
            context.read<EmpresaSolicitudesBloc>().add(const LoadEmpresaSolicitudes());
          }
        },
        builder: (context, state) {
          if (state is EmpresaSolicitudesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final solicitudes = state is EmpresaSolicitudesLoaded ? state.solicitudes : <EmpresaSolicitudEntity>[];

          final disponibles = solicitudes.where((s) => s.estado == 'PENDIENTE').toList();
          final misRecolecciones = solicitudes.where((s) => ['ACEPTADA', 'EN_TRANSITO', 'RECOLECTADA'].contains(s.estado)).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _SolicitudesList(
                solicitudes: disponibles,
                isDisponibles: true,
                onRefresh: () async {
                  context.read<EmpresaSolicitudesBloc>().add(const LoadEmpresaSolicitudes());
                },
              ),
              _SolicitudesList(
                solicitudes: misRecolecciones,
                isDisponibles: false,
                onRefresh: () async {
                  context.read<EmpresaSolicitudesBloc>().add(const LoadEmpresaSolicitudes());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SolicitudesList extends StatelessWidget {
  final List<EmpresaSolicitudEntity> solicitudes;
  final bool isDisponibles;
  final Future<void> Function() onRefresh;

  const _SolicitudesList({
    required this.solicitudes,
    required this.isDisponibles,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (solicitudes.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          children: const [
            SizedBox(height: 100),
            Center(child: Text('No hay solicitudes')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: solicitudes.length,
        itemBuilder: (context, index) {
          final solicitud = solicitudes[index];
          return _ColabSolicitudCard(
            solicitud: solicitud,
            isDisponibles: isDisponibles,
          );
        },
      ),
    );
  }
}

class _ColabSolicitudCard extends StatelessWidget {
  final EmpresaSolicitudEntity solicitud;
  final bool isDisponibles;

  const _ColabSolicitudCard({
    required this.solicitud,
    required this.isDisponibles,
  });

  @override
  Widget build(BuildContext context) {
    final fecha = DateFormat('dd/MM/yyyy').format(solicitud.fechaPreferida);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${solicitud.id} - ${solicitud.nombreSolicitante}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(solicitud.estado).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    solicitud.estado,
                    style: TextStyle(
                      color: _getStatusColor(solicitud.estado),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    solicitud.direccionRecoleccion,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  fecha,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isDisponibles) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB2F333),
                    foregroundColor: const Color(0xFF19133B),
                  ),
                  onPressed: () => _showAcceptDialog(context),
                  child: const Text('Aceptar Solicitud', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (solicitud.estado == 'ACEPTADA')
                    ElevatedButton(
                      onPressed: () => _showEnTransitoDialog(context),
                      child: const Text('En camino'),
                    ),
                  if (solicitud.estado == 'EN_TRANSITO')
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB2F333), foregroundColor: Colors.black),
                      onPressed: () => _showRecolectadaDialog(context),
                      child: const Text('Completar'),
                    ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'PENDIENTE':
        return Colors.orange;
      case 'ACEPTADA':
        return Colors.blue;
      case 'EN_TRANSITO':
        return Colors.purple;
      case 'RECOLECTADA':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showAcceptDialog(BuildContext context) {
    final inicioCtrl = TextEditingController(text: '09:00');
    final finCtrl = TextEditingController(text: '12:00');
    
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Aceptar Solicitud'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Se te asignará automáticamente como colaborador.'),
            const SizedBox(height: 10),
            TextField(controller: inicioCtrl, decoration: const InputDecoration(labelText: 'Hora inicio (HH:MM)')),
            TextField(controller: finCtrl, decoration: const InputDecoration(labelText: 'Hora fin (HH:MM)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<EmpresaSolicitudesBloc>().add(
                AceptarEmpresaSolicitud(
                  solicitudId: solicitud.id,
                  horaEstimadaInicio: inicioCtrl.text.trim(),
                  horaEstimadaFin: finCtrl.text.trim(),
                )
              );
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _showEnTransitoDialog(BuildContext context) {
    final tiempoCtrl = TextEditingController(text: '30');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Marcar en tránsito'),
        content: TextField(
          controller: tiempoCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Tiempo estimado (min)'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<EmpresaSolicitudesBloc>().add(
                MarcarSolicitudEnTransito(
                  solicitudId: solicitud.id,
                  tiempoEstimadoMinutos: int.tryParse(tiempoCtrl.text.trim()),
                )
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showRecolectadaDialog(BuildContext context) {
    final puntosCtrl = TextEditingController(text: '150');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Completar Recolección'),
        content: TextField(
          controller: puntosCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Puntos otorgados'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<EmpresaSolicitudesBloc>().add(
                MarcarSolicitudRecolectada(
                  solicitudId: solicitud.id,
                  puntosOtorgados: int.tryParse(puntosCtrl.text.trim()) ?? 150,
                )
              );
            },
            child: const Text('Completar'),
          ),
        ],
      ),
    );
  }
}
