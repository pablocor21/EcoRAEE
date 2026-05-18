import '../../../../config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'preparar_ruta_screen.dart';
import '../../../../injection_container.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_bloc.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_event.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
class RecoleccionScreen extends ConsumerStatefulWidget {
  const RecoleccionScreen({super.key});

  @override
  ConsumerState<RecoleccionScreen> createState() => _RecoleccionScreenState();
}

class _RecoleccionScreenState extends ConsumerState<RecoleccionScreen> {
  String _activeTab = 'En proceso';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmpresaSolicitudesBloc>()
        ..add(LoadEmpresaSolicitudes(estado: _activeTab == 'En proceso' ? 'EN_TRANSITO' : 'ACEPTADA')),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 250,
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
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const _HeaderRow(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4F6F8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4E7EB),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: BlocBuilder<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    _TabItem(
                                      label: 'Pendientes',
                                      isActive: _activeTab == 'Pendientes',
                                      onTap: () {
                                        setState(() => _activeTab = 'Pendientes');
                                        context.read<EmpresaSolicitudesBloc>().add(const LoadEmpresaSolicitudes(estado: 'ACEPTADA'));
                                      },
                                    ),
                                    _TabItem(
                                      label: 'En proceso',
                                      isActive: _activeTab == 'En proceso',
                                      onTap: () {
                                        setState(() => _activeTab = 'En proceso');
                                        context.read<EmpresaSolicitudesBloc>().add(const LoadEmpresaSolicitudes(estado: 'EN_TRANSITO'));
                                      },
                                    ),
                                  ],
                                );
                              }
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: BlocBuilder<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
                              builder: (context, state) {
                                if (state is EmpresaSolicitudesLoading) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (state is EmpresaSolicitudesError) {
                                  return Center(child: Text(state.message));
                                } else if (state is EmpresaSolicitudesLoaded) {
                                  if (state.solicitudes.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'No hay recolecciones en este estado',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: state.solicitudes.length,
                                    itemBuilder: (context, index) {
                                      final sol = state.solicitudes[index];
                                      return _LocationCard(
                                        title: sol.nombreSolicitante,
                                        address: sol.direccionRecoleccion,
                                        time: DateFormat('dd/MM/yyyy HH:mm').format(sol.fechaPreferida),
                                      );
                                    },
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                          BlocBuilder<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
                            builder: (context, state) {
                              dynamic solicitudes = [];
                              if (state is EmpresaSolicitudesLoaded) {
                                solicitudes = state.solicitudes;
                              }
                              
                              // Si no hay solicitudes, ocultamos el botón
                              if (solicitudes.isEmpty) {
                                return const SizedBox();
                              }
                              
                              return _SlideToPrepareRoute(
                                solicitudes: solicitudes, 
                                activeTab: _activeTab,
                              );
                            }
                          ),
                          const SizedBox(height: 20),
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
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES PRIVADOS
// ──────────────────────────────────────────────────────────────────────────────

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Botón atrás
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 6.0,
                  ), // Ajuste visual del icono
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),

          // Título central
          const Column(
            children: [
              Text(
                'PLANIFICACIÓN',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'DE RECOLECCIONES',
                style: TextStyle(
                  color: Color(0xFFB2F333), // Verde Ciclox
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),

          // Logo placeholder (Símil al isotipo de Ciclox)
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

// Removed _TabsSection as it was integrated into _RecoleccionScreenState

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF19133B) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF19133B),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String title;
  final String address;
  final String time;

  const _LocationCard({
    required this.title,
    required this.address,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila del título con el pin
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFFB2F333), size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF19133B),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Fila del contenido con la línea conectora
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Línea conectora verde (forma de L)
              Container(
                width: 28, // Mismo ancho que el icono de pin para alinear
                height: 60, // Alto aproximado de las dos filas
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 13,
                  ), // Centrado bajo el pin
                  width: 18,
                  height: 48, // Baja y gira a la derecha
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Color(0xFFB2F333), width: 1.5),
                      bottom: BorderSide(color: Color(0xFFB2F333), width: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Datos de dirección y hora
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.store,
                          color: Color(0xFF19133B),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          address,
                          style: const TextStyle(
                            color: Color(0xFF19133B),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Color(0xFF19133B),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          time,
                          style: const TextStyle(
                            color: Color(0xFF19133B),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SlideToPrepareRoute extends StatefulWidget {
  final dynamic solicitudes;
  final String activeTab;
  const _SlideToPrepareRoute({this.solicitudes, required this.activeTab});

  @override
  State<_SlideToPrepareRoute> createState() => _SlideToPrepareRouteState();
}

class _SlideToPrepareRouteState extends State<_SlideToPrepareRoute> {
  double _dragValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFB2F333).withOpacity(0.4),
            const Color(0xFFB2F333).withOpacity(0.1),
            Colors.white.withOpacity(0.5),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxDrag =
              constraints.maxWidth - 70; // Ancho máximo restando el thumb

          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    widget.activeTab == 'Pendientes' ? 'INICIAR RUTA' : 'PREPARAR RUTA',
                    style: const TextStyle(
                      color: Color(0xFF19133B),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              // Botón deslizable (thumb)
              Positioned(
                left: _dragValue,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _dragValue += details.delta.dx;
                      if (_dragValue < 0) _dragValue = 0;
                      if (_dragValue > maxDrag) _dragValue = maxDrag;
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      if (_dragValue > maxDrag * 0.8) {
                        _dragValue = maxDrag;

                        if (widget.activeTab == 'Pendientes') {
                          // Marcar todas como EN_TRANSITO
                          if (widget.solicitudes != null && widget.solicitudes is List) {
                            for (var sol in widget.solicitudes) {
                              context.read<EmpresaSolicitudesBloc>().add(
                                MarcarSolicitudEnTransito(
                                  solicitudId: sol.id,
                                ),
                              );
                            }
                          }
                          // Restablecer el slider
                          Future.delayed(const Duration(milliseconds: 300), () {
                            if (mounted) setState(() => _dragValue = 0);
                          });
                        } else {
                          // Navegar a la pantalla de preparar ruta
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrepararRutaScreen(solicitudes: widget.solicitudes),
                            ),
                          ).then((_) {
                            if (mounted) {
                              setState(() {
                                _dragValue = 0;
                              });
                            }
                          });
                        }
                      } else {
                        // Regresar al inicio
                        _dragValue = 0;
                      }
                    });
                  },
                  child: Container(
                    width: 55,
                    height: 55,
                    margin: const EdgeInsets.all(7.5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  const _CustomBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Icon(
            Icons.notifications_rounded,
            color: Color(0xFF19133B),
            size: 28,
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
