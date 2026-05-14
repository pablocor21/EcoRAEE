import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../config/router/app_router.dart';
import '../../../../injection_container.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_bloc.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_event.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_state.dart';

class SolicitudesScreen extends StatefulWidget {
  const SolicitudesScreen({super.key});

  @override
  State<SolicitudesScreen> createState() => _SolicitudesScreenState();
}

class _SolicitudesScreenState extends State<SolicitudesScreen> {
  String selectedFilter = 'Todas';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmpresaSolicitudesBloc>()..add(const LoadEmpresaSolicitudes()),
      child: Scaffold(
      body: Stack(
        children: [
          // 1. FONDO CON GRADIENTE
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0D0B21),
                  Color(0xFF19133B),
                  Color(0xFF25214D),
                ],
              ),
            ),
          ),

          // Patrón de puntos sutil
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.network(
                'https://www.transparenttextures.com/patterns/stardust.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // 2. HEADER
                BlocBuilder<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
                  builder: (context, state) {
                    int activas = 0;
                    if (state is EmpresaSolicitudesLoaded) {
                      activas = state.solicitudes.where((s) => s.estado == 'ACEPTADA' || s.estado == 'EN_TRANSITO').length;
                    }
                    return _HeaderSection(activas: activas);
                  },
                ),
                const SizedBox(height: 20),

                // 3. CUERPO PRINCIPAL
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE9EDF0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        // 4. BARRA DE BÚSQUEDA
                        const _SearchBar(),
                        const SizedBox(height: 15),

                        // 5. FILTROS (Chips)
                        _FilterChips(
                          selectedFilter: selectedFilter,
                          onFilterChanged: (filter) => setState(() => selectedFilter = filter),
                        ),
                        const SizedBox(height: 20),

                        // 6. LISTA DE SOLICITUDES
                        Expanded(
                          child: BlocBuilder<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
                            builder: (context, state) {
                              if (state is EmpresaSolicitudesLoading) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              
                              if (state is EmpresaSolicitudesLoaded) {
                                final allSolicitudes = state.solicitudes;
                                final filtered = allSolicitudes.where((s) {
                                  if (selectedFilter == 'Todas') return true;
                                  if (selectedFilter == 'Pendientes' && s.estado == 'PENDIENTE') return true;
                                  if (selectedFilter == 'En proceso' && (s.estado == 'ACEPTADA' || s.estado == 'EN_TRANSITO')) return true;
                                  if (selectedFilter == 'Finalizadas' && s.estado == 'RECOLECTADA') return true;
                                  return false;
                                }).toList();

                                if (filtered.isEmpty) {
                                  return const Center(child: Text('No hay solicitudes para mostrar.'));
                                }

                                return ListView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: filtered.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == filtered.length) {
                                      return const SizedBox(height: 100);
                                    }
                                    
                                    final sol = filtered[index];
                                    final date = DateFormat('dd MMM yyyy').format(sol.fechaPreferida);
                                    final time = DateFormat('hh:mm a').format(sol.fechaPreferida);
                                    
                                    // Calcular step progress
                                    int step = 0;
                                    if (sol.estado == 'PENDIENTE') step = 0;
                                    if (sol.estado == 'ACEPTADA') step = 1;
                                    if (sol.estado == 'EN_TRANSITO') step = 2;
                                    if (sol.estado == 'RECOLECTADA' || sol.estado == 'COMPLETADA') step = 3;

                                    if (selectedFilter == 'En proceso' || sol.estado == 'ACEPTADA' || sol.estado == 'EN_TRANSITO') {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: GestureDetector(
                                          onTap: () => context.push(AppRoutes.detallesSolicitud, extra: sol),
                                          child: _SolicitudCardProgress(
                                            title: 'Dispositivos #${sol.id}',
                                            date: date,
                                            time: time,
                                            currentStep: step,
                                            imageUrl: 'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=200',
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: _SolicitudCardSimple(
                                          title: 'Dispositivos #${sol.id}',
                                          date: date,
                                          time: time,
                                          imageUrl: 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=200',
                                          onTap: () => context.push(AppRoutes.detallesSolicitud, extra: sol),
                                        ),
                                      );
                                    }
                                  },
                                );
                              }

                              return const Center(child: Text('Error cargando solicitudes.'));
                            },
                          ),
                        ),
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
      extendBody: true,
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES
// ──────────────────────────────────────────────────────────────────────────────

class _HeaderSection extends StatelessWidget {
  final int activas;
  const _HeaderSection({required this.activas});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Espacio para mantener el título centrado (reemplaza al logo 'C')
          const SizedBox(width: 50),
          Column(
            children: [
              Text(
                'SOLICITUDES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'Tienes $activas activas',
                style: const TextStyle(
                  color: Color(0xFFB2F333),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Logo Ciclox derecha
          Image.asset(
            'assets/iconos/logo-icono VERDE-8.png',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

class _CircularLogo extends StatelessWidget {
  final Widget child;
  const _CircularLogo({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFDDE1E4),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.black.withOpacity(0.6), size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar solicitud...',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;
  
  const _FilterChips({
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _ChipItem(
            label: 'Todas',
            isActive: selectedFilter == 'Todas',
            onTap: () => onFilterChanged('Todas'),
          ),
          _ChipItem(
            label: 'Pendientes',
            isActive: selectedFilter == 'Pendientes',
            onTap: () => onFilterChanged('Pendientes'),
          ),
          _ChipItem(
            label: 'En proceso',
            isActive: selectedFilter == 'En proceso',
            onTap: () => onFilterChanged('En proceso'),
          ),
          _ChipItem(
            label: 'Finalizadas',
            isActive: selectedFilter == 'Finalizadas',
            onTap: () => onFilterChanged('Finalizadas'),
          ),
        ],
      ),
    );
  }
}

class _ChipItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ChipItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF19133B) : const Color(0xFFDDE1E4),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF19133B),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _SolicitudCardProgress extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final int currentStep;
  final String imageUrl;

  const _SolicitudCardProgress({
    required this.title,
    required this.date,
    required this.time,
    required this.currentStep,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF19133B),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _StepProgress(currentStep: currentStep),
        ],
      ),
    );
  }
}

class _StepProgress extends StatelessWidget {
  final int currentStep;
  const _StepProgress({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = ['Solicitud', 'Aprobación', 'En camino', 'Recolectado'];
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 2,
              color: Colors.grey.withOpacity(0.3),
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                final isActive = index <= currentStep;
                final isCurrent = index == currentStep;
                return Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? const Color(0xFF19133B)
                        : (isActive
                              ? const Color(0xFF19133B)
                              : Colors.grey.withOpacity(0.3)),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            final isCurrent = index == currentStep;
            return Text(
              steps[index],
              style: TextStyle(
                color: isCurrent ? const Color(0xFF19133B) : Colors.grey,
                fontSize: 12,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _SolicitudCardSimple extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String imageUrl;
  final VoidCallback? onTap;

  const _SolicitudCardSimple({
    required this.title,
    required this.date,
    required this.time,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF19133B),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 15,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.chevron_right,
              color: Color(0xFF19133B),
              size: 30,
            ),
          ),
        ],
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
            child: Icon(Icons.home_filled, color: Color(0xFF19133B), size: 28),
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.soporteColaborador),
            child: Icon(Icons.warning_rounded, color: Color(0xFF19133B), size: 28),
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
            child: Icon(
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
