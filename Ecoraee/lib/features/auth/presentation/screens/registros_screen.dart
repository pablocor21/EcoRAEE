import '../../../../config/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../../../empresas/solicitudes/domain/entities/empresa_solicitud_entity.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_bloc.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_event.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_state.dart';

class RegistrosScreen extends StatefulWidget {
  const RegistrosScreen({super.key});

  @override
  State<RegistrosScreen> createState() => _RegistrosScreenState();
}

class _RegistrosScreenState extends State<RegistrosScreen> {
  @override
  void initState() {
    super.initState();
    // Use Future.microtask or read the bloc directly if it's provided higher up
    // But since it's a new screen, we might need to provide it if not provided globally.
    // Assuming it's provided in main or via router, we can just call it:
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmpresaSolicitudesBloc>()..add(const LoadEmpresaSolicitudes()),
      child: Scaffold(
        body: Stack(
          children: [
            // 1. FONDO CON GRADIENTE (Siguiendo el estilo de Dashboard)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0D0B21), // Azul muy oscuro
                    Color(0xFF19133B), // CicloxColors.dark
                    Color(0xFF25214D), // Azul un poco más claro
                  ],
                ),
              ),
            ),

            // Patrón de puntos sutil (opcional, para mayor fidelidad a la imagen)
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
                  const SizedBox(height: 20),

                  // 3. CUERPO (Contenedor Gris Claro)
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE9EDF0), // Gris claro de la imagen
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
                          const SizedBox(height: 20),

                          // 5. LISTA DE REGISTROS DÍNAMICA
                          Expanded(
                            child: BlocConsumer<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
                              listener: (context, state) {
                                if (state is EmpresaSolicitudesActionSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                  context.read<EmpresaSolicitudesBloc>().add(const LoadEmpresaSolicitudes());
                                } else if (state is EmpresaSolicitudesError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is EmpresaSolicitudesLoading) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                
                                List<EmpresaSolicitudEntity> solicitudes = [];
                                if (state is EmpresaSolicitudesLoaded) {
                                  solicitudes = state.solicitudes.where((s) => s.estado == 'PENDIENTE').toList();
                                }

                                if (solicitudes.isEmpty) {
                                  return const Center(child: Text('No hay registros pendientes.'));
                                }

                                return ListView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: solicitudes.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == solicitudes.length) {
                                      return const SizedBox(height: 100); // Espacio para el nav bar
                                    }
                                    final sol = solicitudes[index];
                                    
                                    // Datos de ejemplo mapeados desde la solicitud
                                    final deviceName = 'Dispositivo E-Waste';
                                    final detail = 'Varios items';
                                    
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: _RegistroCard(
                                        solicitudId: sol.id,
                                        title: deviceName,
                                        description: sol.direccionRecoleccion,
                                        detail: detail,
                                        imageUrl: 'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=200',
                                        onAprobar: () {
                                          _mostrarDialogoAprobar(context, sol.id);
                                        },
                                        onRechazar: () {
                                          _mostrarDialogoRechazar(context, sol.id);
                                        },
                                      ),
                                    );
                                  },
                                );
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
        // 6. BOTTOM NAVIGATION BAR
        bottomNavigationBar: const _CustomBottomNavBar(),
        extendBody: true, // Para que el cuerpo se extienda detrás del nav bar
      ),
    );
  }

  void _mostrarDialogoAprobar(BuildContext context, int solicitudId) {
    final inicioCtrl = TextEditingController(text: '09:00');
    final finCtrl = TextEditingController(text: '12:00');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Aprobar Solicitud'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                  solicitudId: solicitudId,
                  horaEstimadaInicio: inicioCtrl.text.trim(),
                  horaEstimadaFin: finCtrl.text.trim(),
                )
              );
            },
            child: const Text('Aprobar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoRechazar(BuildContext context, int solicitudId) {
    final motivoCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Rechazar Solicitud'),
        content: TextField(
          controller: motivoCtrl,
          decoration: const InputDecoration(labelText: 'Motivo de rechazo'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<EmpresaSolicitudesBloc>().add(
                RechazarEmpresaSolicitud(
                  solicitudId: solicitudId,
                  motivo: motivoCtrl.text.trim().isEmpty ? 'Sin motivo' : motivoCtrl.text.trim(),
                )
              );
            },
            child: const Text('Rechazar'),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES DE LA PANTALLA
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
          const SizedBox(width: 50),
          // Título Central
          const Text(
            'REGISTRO',
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
        color: const Color(0xFFDDE1E4), // Gris un poco más oscuro
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

class _RegistroCard extends StatelessWidget {
  final int solicitudId;
  final String title;
  final String description;
  final String detail;
  final String imageUrl;
  final VoidCallback onAprobar;
  final VoidCallback onRechazar;

  const _RegistroCard({
    required this.solicitudId,
    required this.title,
    required this.description,
    required this.detail,
    required this.imageUrl,
    required this.onAprobar,
    required this.onRechazar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F6),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              // Texto
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
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Detalle inferior izquierdo
              Row(
                children: [
                  const Icon(Icons.bolt, color: Color(0xFFB2F333), size: 20),
                  const SizedBox(width: 5),
                  Text(
                    detail,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              // Slider interactivo
              _InteractiveSlider(
                onAprobar: onAprobar,
                onRechazar: onRechazar,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InteractiveSlider extends StatefulWidget {
  final VoidCallback onAprobar;
  final VoidCallback onRechazar;

  const _InteractiveSlider({
    required this.onAprobar,
    required this.onRechazar,
  });

  @override
  State<_InteractiveSlider> createState() => _InteractiveSliderState();
}

class _InteractiveSliderState extends State<_InteractiveSlider> {
  double _position = 0.5; // 0.0 = Aprobar, 1.0 = Rechazar, 0.5 = Centro

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _position += details.primaryDelta! / 150; // Sensibilidad
          _position = _position.clamp(0.0, 1.0);
        });
      },
      onHorizontalDragEnd: (details) {
        if (_position < 0.2) {
          widget.onAprobar();
          setState(() => _position = 0.5);
        } else if (_position > 0.8) {
          widget.onRechazar();
          setState(() => _position = 0.5);
        } else {
          // Snap al centro
          setState(() => _position = 0.5);
        }
      },
      child: Container(
        width: 160,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFB2F333), // Verde (Aprobar)
              Color(0xFFE0E5E9), // Centro neutral
              Color(0xFFE5989B), // Rojo/Rosa (Rechazar)
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Textos de fondo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Aprobar',
                    style: TextStyle(
                      color: Color(0xFF19133B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rechazar',
                    style: TextStyle(
                      color: Color(0xFF19133B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Thumb (Círculo blanco)
            AnimatedAlign(
              duration: const Duration(milliseconds: 100),
              alignment: Alignment(_position * 2 - 1, 0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 37,
                height: 37,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
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
