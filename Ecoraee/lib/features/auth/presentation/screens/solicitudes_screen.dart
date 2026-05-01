import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/router/app_router.dart';

class SolicitudesScreen extends StatelessWidget {
  const SolicitudesScreen({super.key});

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
            child: Column(
              children: [
                const SizedBox(height: 10),
                // 2. HEADER
                const _HeaderSection(),
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
                        const _FilterChips(),
                        const SizedBox(height: 20),

                        // 6. LISTA DE SOLICITUDES
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    context.push(AppRoutes.detallesSolicitud),
                                child: const _SolicitudCardProgress(
                                  title: 'Laptop Asus ROG',
                                  date: '12 de marzo 2026',
                                  time: '3:00 pm',
                                  currentStep:
                                      2, // 0: Solicitud, 1: Aprobación, 2: En camino, 3: Recolectado
                                  imageUrl:
                                      'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=200',
                                ),
                              ),
                              SizedBox(height: 15),
                              _SolicitudCardSimple(
                                title: 'Monitor LG',
                                date: '12 de marzo 2026',
                                time: '4:00 pm',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=200',
                                onTap: () =>
                                    context.push(AppRoutes.detallesSolicitud),
                              ),
                              SizedBox(height: 15),
                              _SolicitudCardSimple(
                                title: 'Tarjeta gráfica 9060 RTX',
                                date: '12 de marzo 2026',
                                time: '6:00 pm',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1591488320449-011701bb6704?w=200',
                                onTap: () =>
                                    context.push(AppRoutes.detallesSolicitud),
                              ),
                              SizedBox(height: 100),
                            ],
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
                'Tienes 3 activas',
                style: TextStyle(
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

class _FilterChips extends StatefulWidget {
  const _FilterChips();

  @override
  State<_FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<_FilterChips> {
  String selectedFilter = 'En proceso';

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
            onTap: () => setState(() => selectedFilter = 'Todas'),
          ),
          _ChipItem(
            label: 'Pendientes',
            isActive: selectedFilter == 'Pendientes',
            onTap: () => setState(() => selectedFilter = 'Pendientes'),
          ),
          _ChipItem(
            label: 'En proceso',
            isActive: selectedFilter == 'En proceso',
            onTap: () => setState(() => selectedFilter = 'En proceso'),
          ),
          _ChipItem(
            label: 'Finalizadas',
            isActive: selectedFilter == 'Finalizadas',
            onTap: () => setState(() => selectedFilter = 'Finalizadas'),
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
            fontSize: 14,
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
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 13,
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
                fontSize: 10,
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
                    fontSize: 13,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 13,
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
