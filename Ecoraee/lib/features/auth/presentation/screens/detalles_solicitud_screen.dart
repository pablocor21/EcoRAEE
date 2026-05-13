import '../../../../config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'rechazo_solicitud_screen.dart';

class DetallesSolicitudScreen extends StatelessWidget {
  const DetallesSolicitudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // 2. BOTÓN ATRÁS E IMAGEN PRINCIPAL
                  const _HeaderImageSection(),
                  const SizedBox(height: 20),

                  // 3. TÍTULO Y ESTADO
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Laptop Asus ROG',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 5),
                        _StatusPill(label: 'Estado: en proceso'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // 4. CUERPO (Contenedor Gris Claro)
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE9EDF0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Información de la solicitud
                        const _InfoCard(),
                        const SizedBox(height: 30),

                        // Descripción
                        const Text(
                          'DESCRIPCIÓN',
                          style: TextStyle(
                            color: Color(0xFF19133B),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const _DescriptionCard(),
                        const SizedBox(height: 30),

                        // Dispositivos
                        const Text(
                          'DISPOSITIVOS',
                          style: TextStyle(
                            color: Color(0xFF19133B),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const _DevicesCard(),
                        const SizedBox(height: 35),

                        // Slider Interactivo
                        const Center(child: _InteractiveAcceptSlider()),
                        const SizedBox(height: 80), // Espacio para el nav bar
                      ],
                    ),
                  ),
                ],
              ),
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

class _HeaderImageSection extends StatelessWidget {
  const _HeaderImageSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagen del producto
        Center(
          child: Image.network(
            'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=600',
            height: 250,
            fit: BoxFit.contain,
          ),
        ),
        // Botón de retroceso
        Positioned(
          top: 10,
          left: 20,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  const _StatusPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Estado: ',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE9C46A).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE9C46A).withOpacity(0.5)),
          ),
          child: Text(
            'en proceso',
            style: TextStyle(
              color: const Color(0xFFE9C46A).withAlpha(255),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const _InfoRow(
            icon: Icons.location_on,
            text: 'Carrera 55 # 86 - 120',
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              Expanded(
                child: _InfoRow(
                  icon: Icons.calendar_today,
                  text: '14 de marzo 2026',
                ),
              ),
              Expanded(
                child: _InfoRow(icon: Icons.access_time, text: '10:00 am'),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(),
          ),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFE8F2D9),
                child: Icon(Icons.person, color: Color(0xFF19133B)),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Text(
                  'Juan José Gómez Toro',
                  style: TextStyle(
                    color: Color(0xFF19133B),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.black.withOpacity(0.3)),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF19133B), size: 20),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Portátil gamer Asus ROG Strix RTX 5070 Ti, ideal para alto rendimiento y tareas exigentes.',
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Cuenta con:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          const _BulletPoint(text: '32 GB de RAM'),
          const _BulletPoint(text: 'SSD de alta velocidad'),
          const _BulletPoint(text: 'Excelente desempeño gráfico'),
          const SizedBox(height: 15),
          Text(
            'Estado: funcional, en buen estado general\nIncluye: cargador original y mouse',
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: Color(0xFFB2F333), size: 18),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _DevicesCard extends StatelessWidget {
  const _DevicesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          _DeviceRow(text: 'Laptop Asus ROG'),
          Divider(),
          _DeviceRow(text: 'Cargador'),
          Divider(),
          _DeviceRow(text: 'Mouse'),
        ],
      ),
    );
  }
}

class _DeviceRow extends StatelessWidget {
  final String text;
  const _DeviceRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF19133B),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _InteractiveAcceptSlider extends StatefulWidget {
  const _InteractiveAcceptSlider();

  @override
  State<_InteractiveAcceptSlider> createState() =>
      _InteractiveAcceptSliderState();
}

class _InteractiveAcceptSliderState extends State<_InteractiveAcceptSlider> {
  double _position = 0.5;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _position += details.primaryDelta! / 150;
          _position = _position.clamp(0.0, 1.0);
        });
      },
      onHorizontalDragEnd: (details) {
        if (_position > 0.9) {
          showDialog(
            context: context,
            builder: (context) => const RechazoSolicitudDialog(),
          );
          setState(() => _position = 0.5); // Reset slider position
        }
      },
      child: Container(
        width: 200,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFB2F333), Color(0xFFE0E5E9), Color(0xFFE5989B)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Aceptar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    'Rechazar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 50),
              alignment: Alignment(_position * 2 - 1, 0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
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
