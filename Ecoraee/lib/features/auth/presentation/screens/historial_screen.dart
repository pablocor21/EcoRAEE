import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../config/router/app_router.dart';
import '../../../../injection_container.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_bloc.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_event.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_state.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
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
                const _HeaderSection(),
                const SizedBox(height: 55),

                // 3. TARJETAS DE ESTADÍSTICAS SUPERIORES Y CUERPO
                Expanded(
                  child: BlocBuilder<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
                    builder: (context, state) {
                      int totalReciclados = 0;
                      int totalRecolectas = 0;
                      int totalCO2 = 0;
                      
                      int portatiles = 0;
                      int monitores = 0;
                      int otros = 0;

                      List<dynamic> solicitudesFinalizadas = [];

                      if (state is EmpresaSolicitudesLoaded) {
                        solicitudesFinalizadas = state.solicitudes.where((s) => s.estado == 'RECOLECTADA' || s.estado == 'COMPLETADA').toList();
                        totalRecolectas = solicitudesFinalizadas.length;
                        
                        // Fake calculation based on requests count since we don't have devices detail in list API usually
                        totalReciclados = totalRecolectas * 3; 
                        totalCO2 = totalRecolectas * 15;
                        
                        portatiles = totalRecolectas * 1;
                        monitores = totalRecolectas * 1;
                        otros = totalRecolectas * 1;
                      }

                      return Column(
                        children: [
                          _TopStatsRow(
                            reciclados: '$totalReciclados',
                            recolectas: '$totalRecolectas',
                            co2: '$totalCO2 kg',
                          ),
                          const SizedBox(height: 25),
                          
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
                                  const _ActivityHeader(),
                                  const SizedBox(height: 25),

                                  Expanded(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: state is EmpresaSolicitudesLoaded ? solicitudesFinalizadas.length + 2 : 2,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 25),
                                            child: _MidStatsRow(
                                              portatiles: '$portatiles',
                                              monitores: '$monitores',
                                              otros: '$otros',
                                            ),
                                          );
                                        }
                                        if (state is! EmpresaSolicitudesLoaded) {
                                          return const Center(child: CircularProgressIndicator());
                                        }
                                        if (index == solicitudesFinalizadas.length + 1) {
                                          return const SizedBox(height: 100);
                                        }
                                        
                                        final sol = solicitudesFinalizadas[index - 1];
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 15),
                                          child: _ActivityItem(
                                            title: 'Dispositivos #${sol.id}',
                                            location: sol.direccionRecoleccion,
                                            condition: 'Recolectado',
                                            time: DateFormat('dd MMM yyyy, hh:mm a').format(sol.fechaPreferida),
                                            id: '${sol.id}',
                                            imageUrl: 'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=200',
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _CustomBottomNavBar(),
      extendBody: true,
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES
// ──────────────────────────────────────────────────────────────────────────────

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Espacio para mantener el título centrado (reemplaza al logo 'C')
          const SizedBox(width: 40),
          const Text(
            'HISTORIAL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          // Logo Ciclox derecha
          Image.asset(
            'assets/iconos/logo-icono VERDE-8.png',
            width: 40,
            height: 40,
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

class _TopStatsRow extends StatelessWidget {
  final String reciclados;
  final String recolectas;
  final String co2;

  const _TopStatsRow({
    required this.reciclados,
    required this.recolectas,
    required this.co2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          _TopStatCard(
            value: reciclados,
            label: 'Dispositivos\nreciclados',
            color: Colors.white,
            textColor: Color(0xFF19133B),
          ),
          SizedBox(width: 10),
          _TopStatCard(
            value: recolectas,
            label: 'Recolectas',
            color: Color(0xFF7A9BBF),
            textColor: Colors.white,
          ),
          SizedBox(width: 10),
          _TopStatCard(
            value: co2,
            label: 'CO2\nAhorrado',
            color: Color(0xFF19133B),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _TopStatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final Color textColor;

  const _TopStatCard({
    required this.value,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 42,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityHeader extends StatelessWidget {
  const _ActivityHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFDDE1E4),
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      child: const Text(
        'Actividad reciente',
        style: TextStyle(
          color: Color(0xFF19133B),
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _MidStatsRow extends StatelessWidget {
  final String portatiles;
  final String monitores;
  final String otros;

  const _MidStatsRow({
    required this.portatiles,
    required this.monitores,
    required this.otros,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MidStatCard(value: portatiles, label: 'Portátiles\nreciclados'),
        SizedBox(width: 10),
        _MidStatCard(value: monitores, label: 'Monitores\nreciclados'),
        SizedBox(width: 10),
        _MidStatCard(value: otros, label: 'Otros disp.\nreciclados'),
      ],
    );
  }
}

class _MidStatCard extends StatelessWidget {
  final String value;
  final String label;

  const _MidStatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF19133B),
                fontSize: 36,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF19133B).withOpacity(0.7),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String title;
  final String location;
  final String condition;
  final String time;
  final String id;
  final String imageUrl;

  const _ActivityItem({
    required this.title,
    required this.location,
    required this.condition,
    required this.time,
    required this.id,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F6),
        borderRadius: BorderRadius.circular(25),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF19133B),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      id,
                      style: const TextStyle(
                        color: Color(0xFF19133B),
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                Text(
                  condition,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
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
