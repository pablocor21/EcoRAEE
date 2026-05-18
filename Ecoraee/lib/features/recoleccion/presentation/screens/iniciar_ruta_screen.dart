import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router.dart';
import '../../../../injection_container.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_bloc.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_event.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_state.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class IniciarRutaScreen extends StatelessWidget {
  final dynamic solicitudes;
  const IniciarRutaScreen({super.key, this.solicitudes});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmpresaSolicitudesBloc>(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Stack(
          children: [
            const _BackgroundPattern(),
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 100, // Approximate height minus bottom bar
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 20),
                      const _LogoHeader(),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _DuracionRutaCard(solicitudes: solicitudes),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: _RecomendacionesCard(),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: _IniciarRutaSlider(solicitudes: solicitudes),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const _CustomBottomNavigationBar(),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES PRIVADOS DE LA PANTALLA
// ──────────────────────────────────────────────────────────────────────────────

/// Patrón de fondo simulando el cielo estrellado o grilla de puntos del diseño
class _BackgroundPattern extends StatelessWidget {
  const _BackgroundPattern();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1,
      child: Container(
        // Generador de puntos como alternativa visual
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 20,
          ),
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                width: 2,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Logo superior compuesto simulando "CX" con el diseño específico
class _LogoHeader extends StatelessWidget {
  const _LogoHeader();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/imagenes/VARIACION 3 VERDE.png',
        height: 80,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            'Logo no encontrado',
            style: TextStyle(color: Colors.white54),
          );
        },
      ),
    );
  }
}

/// Tarjeta que muestra la duración de la ruta dividida en tres columnas
class _DuracionRutaCard extends StatelessWidget {
  final dynamic solicitudes;
  const _DuracionRutaCard({this.solicitudes});

  @override
  Widget build(BuildContext context) {
    String loc1 = 'Edificio residencia\nDoña Ana';
    String loc2 = 'Barrio\nManrique';
    String loc3 = 'Edificio\nSan Sebastián';
    
    if (solicitudes != null && solicitudes is List && solicitudes.isNotEmpty) {
      loc1 = solicitudes[0].direccionRecoleccion;
      if (solicitudes.length > 1) loc2 = solicitudes[1].direccionRecoleccion;
      if (solicitudes.length > 2) loc3 = solicitudes[2].direccionRecoleccion;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A153A),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const Text(
            'DURACIÓN DE LA RUTA',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDurationColumn('01:00:00', loc1),
              _buildDivider(),
              _buildDurationColumn('00:25:00', loc2),
              _buildDivider(),
              _buildDurationColumn('01:30:00', loc3),
            ],
          ),
        ],
      ),
    );
  }

  // Separador vertical entre las columnas de tiempo
  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    );
  }

  // Columna individual de tiempo y ubicación
  Widget _buildDurationColumn(String time, String location) {
    return Expanded(
      child: Column(
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            location,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta con las recomendaciones de seguridad (icono de alerta y lista)
class _RecomendacionesCard extends StatelessWidget {
  const _RecomendacionesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFD4D4D8), // Fondo gris claro
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icono de Alerta Superior
          const Icon(
            Icons.warning_rounded,
            color: Color(0xFFE4574C), // Rojo coral
            size: 60,
          ),
          const SizedBox(height: 10),
          
          // Título
          const Text(
            'RECOMENDACIONES DE SEGURIDAD',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF1E1E2C),
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          
          // Lista de viñetas con iconos verdes
          _buildListItem('Verifica que el vehículo esté en buen estado.'),
          _buildListItem('Confirma batería/carga suficiente del dispositivo.'),
          _buildListItem('Revisa que la ruta esté completa y actualizada.'),
          _buildListItem('Sigue únicamente la ruta asignada.'),
          _buildListItem('Evita zonas no autorizadas o inseguras.'),
          _buildListItem('No manipules el celular mientras conduces.'),
          
          const SizedBox(height: 15),
          
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Elemento individual de la lista de recomendaciones
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.flash_on, // Icono de rayo verde como viñeta
              color: Color(0xFFB2F333), // Verde Ciclox
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF4A4A5A),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IniciarRutaSlider extends StatefulWidget {
  final dynamic solicitudes;
  const _IniciarRutaSlider({this.solicitudes});

  @override
  State<_IniciarRutaSlider> createState() => _IniciarRutaSliderState();
}

class _IniciarRutaSliderState extends State<_IniciarRutaSlider> {
  double _position = 0;
  bool _isFinished = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxPosition = constraints.maxWidth - 65;

        return BlocListener<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
          listener: (context, state) {
            if (state is EmpresaSolicitudesActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: const Color(0xFFB2F333),
                  duration: const Duration(seconds: 2),
                ),
              );
              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) context.go(AppRoutes.dashboardCiudadano);
              });
            } else if (state is EmpresaSolicitudesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
              setState(() {
                _position = 0;
                _isFinished = false;
              });
            }
          },
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.05),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(35),
            ),
            child: Stack(
              children: [
                Center(
                  child: Opacity(
                    opacity: 1 - (_position / maxPosition).clamp(0.0, 1.0),
                    child: const Text(
                      'RECOLECTAR TODO',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: _position,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      if (_isFinished) return;
                      setState(() {
                        _position += details.delta.dx;
                        if (_position < 0) _position = 0;
                        if (_position > maxPosition) _position = maxPosition;
                      });
                    },
                    onPanEnd: (details) {
                      if (_isFinished) return;
                      if (_position > maxPosition * 0.8) {
                        setState(() {
                          _position = maxPosition;
                          _isFinished = true;
                        });
                        
                        // Fire BLoC event to collect the first request as a test, or all if we loop
                        if (widget.solicitudes != null && widget.solicitudes is List && widget.solicitudes.isNotEmpty) {
                          // Collect the first one to test
                          context.read<EmpresaSolicitudesBloc>().add(
                            MarcarSolicitudRecolectada(
                              solicitudId: widget.solicitudes[0].id,
                              puntosOtorgados: 100,
                              evidenciaUrl: '',
                            )
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No hay solicitudes válidas'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() { _position = 0; _isFinished = false; });
                        }
                      } else {
                        setState(() { _position = 0; });
                      }
                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(2, 0),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isFinished ? Icons.check : Icons.chevron_right,
                        color: const Color(0xFF19133B),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Barra de navegación inferior
class _CustomBottomNavigationBar extends StatelessWidget {
  const _CustomBottomNavigationBar();

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
            child: const Icon(Icons.home_filled, color: Color(0xFF19133B), size: 28),
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.soporteColaborador),
            child: Icon(Icons.warning_rounded, color: Color(0xFF19133B), size: 28),
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.solicitudes),
            child: const Icon(Icons.local_shipping, color: Color(0xFF19133B), size: 28),
          ),
          const Icon(
            Icons.notifications_rounded,
            color: Color(0xFF19133B),
            size: 28,
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
