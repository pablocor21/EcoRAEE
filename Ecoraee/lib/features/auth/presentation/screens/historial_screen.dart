import 'package:flutter/material.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

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
                const SizedBox(height: 25),

                // 3. TARJETAS DE ESTADÍSTICAS SUPERIORES
                const _TopStatsRow(),
                const SizedBox(height: 25),

                // 4. CUERPO PRINCIPAL
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
                        // Sub-header: Actividad reciente
                        const _ActivityHeader(),
                        const SizedBox(height: 25),

                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            physics: const BouncingScrollPhysics(),
                            children: const [
                              // 5. ESTADÍSTICAS MEDIAS
                              _MidStatsRow(),
                              SizedBox(height: 25),

                              // 6. LISTA DE ACTIVIDAD
                              _ActivityItem(
                                title: 'Laptop Asus ROG',
                                location: 'Poblado, Medellín',
                                condition: 'Excelente condición',
                                time: 'Hoy, a las 10:00 am',
                                id: '12',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=200',
                              ),
                              SizedBox(height: 15),
                              _ActivityItem(
                                title: 'Monitor LG',
                                location: 'Manrique, Medellín',
                                condition: 'Excelente condición',
                                time: 'Hoy, a las 12:00 m',
                                id: '13',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=200',
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
          const _CircularLogo(
            child: Text(
              'C',
              style: TextStyle(
                color: Color(0xFF19133B),
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const Text(
            'HISTORIAL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const _CircularLogo(
            child: Icon(Icons.bolt, color: Color(0xFFB2F333), size: 30),
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
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: child,
    );
  }
}

class _TopStatsRow extends StatelessWidget {
  const _TopStatsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: const [
          _TopStatCard(
            value: '120',
            label: 'Dispositivos\nreciclados',
            color: Colors.white,
            textColor: Color(0xFF19133B),
          ),
          SizedBox(width: 10),
          _TopStatCard(
            value: '32',
            label: 'Recolectas',
            color: Color(0xFF7A9BBF),
            textColor: Colors.white,
          ),
          SizedBox(width: 10),
          _TopStatCard(
            value: '45 kg',
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
                fontSize: 32,
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
  const _MidStatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _MidStatCard(value: '120', label: 'Portátiles\nreciclados'),
        SizedBox(width: 10),
        _MidStatCard(value: '40', label: 'Monitores\nreciclados'),
        SizedBox(width: 10),
        _MidStatCard(value: '70', label: 'Otros disp.\nreciclados'),
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
                fontSize: 26,
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
                  style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),
                ),
                Text(
                  condition,
                  style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12),
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
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.home_filled, color: Color(0xFF19133B), size: 28),
          Icon(Icons.warning_amber_rounded, color: Color(0xFF19133B), size: 28),
          Icon(Icons.store_rounded, color: Color(0xFF19133B), size: 28),
          Icon(Icons.notifications_none_rounded, color: Color(0xFF19133B), size: 28),
          Icon(Icons.settings_outlined, color: Color(0xFF19133B), size: 28),
        ],
      ),
    );
  }
}
