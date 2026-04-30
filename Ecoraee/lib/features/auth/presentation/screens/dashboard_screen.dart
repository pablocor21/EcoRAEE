import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/router/app_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // Usamos un Stack para manejar el fondo con gradiente y el contenido encima
      body: Stack(
        children: [
          // 1. FONDO CON GRADIENTE (Efecto espacial/oscuro de la imagen)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0D0B21), // Azul muy oscuro arriba
                  Color(0xFF19133B), // CicloxColors.dark
                  Color(0xFF25214D), // Azul un poco más claro abajo
                ],
              ),
            ),
          ),

          // 2. CONTENIDO PRINCIPAL SCROLLABLE
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // 3. HEADER: Perfil, Nombre y Botones de Acción
                  const _HeaderSection(),

                  const SizedBox(height: 25),

                  // 4. TARJETA DE ESTADÍSTICAS: Dispositivos Reciclados
                  const _StatsSummaryCard(),

                  const SizedBox(height: 20),

                  // 5. BOTONES DE ACCIÓN RÁPIDA (Grid 2x2)
                  const _QuickActionsGrid(),

                  const SizedBox(height: 25),

                  // 6. SECCIÓN INFERIOR (Fondo gris claro/blanco para contraste)
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4F6F8), // Gris muy claro
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 7. BANNER DE ALERTA: Solicitudes pendientes
                        const _AlertBanner(),

                        const SizedBox(height: 30),

                        // 8. SOLICITUDES RECIENTES
                        const _SectionHeader(title: 'SOLICITUDES RECIENTES'),
                        const SizedBox(height: 15),
                        const _RecentRequestItem(
                          title: 'Monitor LG',
                          status: 'en proceso',
                          statusColor: Color(0xFFE9C46A), // Amarillo
                          imageUrl:
                              'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=200',
                        ),
                        const SizedBox(height: 12),
                        const _RecentRequestItem(
                          title: 'Laptop Asus ROG',
                          status: 'recolectado',
                          statusColor: Color(0xFFB2F333), // Verde Ciclox
                          imageUrl:
                              'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=200',
                        ),

                        const SizedBox(height: 35),

                        // 9. RECOLECTAS
                        const _SectionHeader(title: 'RECOLECTAS'),
                        const SizedBox(height: 15),
                        const _CollectionItem(date: '12 de marzo', count: 3),
                        const _CollectionItem(date: '10 de marzo', count: 1),

                        const SizedBox(height: 20), // Espacio extra abajo
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // 10. BOTTOM NAVIGATION BAR (Estilo moderno)
      bottomNavigationBar: _CustomBottomNavBar(),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES PRIVADOS (Siguiendo la guía de mantener widgets pequeños)
// ──────────────────────────────────────────────────────────────────────────────

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Foto de Perfil
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F2D9),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?u=juan'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Saludo y Ciclo Activo
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hola, Juan José',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Ciclo activo',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.recycling, color: Color(0xFFB2F333), size: 14),
                  ],
                ),
              ],
            ),
          ),
          // Botones Notificación y Configuración
          const _HeaderActionBtn(icon: Icons.notifications),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => context.push(AppRoutes.ajustesColaborador),
            child: const _HeaderActionBtn(icon: Icons.settings),
          ),
        ],
      ),
    );
  }
}

class _HeaderActionBtn extends StatelessWidget {
  final IconData icon;
  const _HeaderActionBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}

class _StatsSummaryCard extends StatelessWidget {
  const _StatsSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B143F), // Azul muy oscuro
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Título de la tarjeta
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.bolt_rounded,
                color: Color(0xFFB2F333),
                size: 28,
              ),
              const SizedBox(width: 10),
              Text(
                'DISPOSITIVOS RECICLADOS',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          // Fila de estadísticas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                value: '128',
                label: 'Recolectas\nrealizadas en el mes',
              ),
              _VerticalDivider(),
              _StatItem(value: '32', label: 'Recolectas\npendientes'),
              _VerticalDivider(),
              _StatItem(
                value: '5',
                label: 'Solicitudes\nactivas',
                valueColor: const Color(0xFFB2F333),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;
  const _StatItem({required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.1),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 2.1,
        children: [
          _ActionButton(
            icon: Icons.recycling,
            label: 'Registros',
            onTap: () => context.push(AppRoutes.registros),
          ),
          _ActionButton(
            icon: Icons.bar_chart,
            label: 'Historial',
            onTap: () => context.push(AppRoutes.historial),
          ),
          _ActionButton(
            icon: Icons.local_shipping,
            label: 'Solicitudes',
            onTap: () => context.push(AppRoutes.solicitudes),
          ),
          _ActionButton(
            icon: Icons.inventory_2,
            label: 'Recolección',
            onTap: () => context.push(AppRoutes.recoleccion),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _ActionButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF8B9BB1).withOpacity(0.5),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF19133B), size: 28),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF19133B),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertBanner extends StatelessWidget {
  const _AlertBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_rounded, color: Color(0xFFF4A261), size: 28),
          const SizedBox(width: 15),
          const Text(
            'Tienes 2 solicitudes pendientes',
            style: TextStyle(
              color: Color(0xFF19133B),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF19133B),
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        Row(
          children: [
            Text(
              'Ver todas',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(width: 5),
            Icon(Icons.chevron_right, color: Colors.grey[600], size: 18),
          ],
        ),
      ],
    );
  }
}

class _RecentRequestItem extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final String imageUrl;

  const _RecentRequestItem({
    required this.title,
    required this.status,
    required this.statusColor,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Imagen del dispositivo
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF19133B),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Estado: $status',
                  style: TextStyle(color: Colors.grey[500], fontSize: 13),
                ),
              ],
            ),
          ),
          // Tag de Estado
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              status[0].toUpperCase() + status.substring(1),
              style: TextStyle(
                color: statusColor.withAlpha(255),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.chevron_right, color: Color(0xFFB2F333), size: 24),
        ],
      ),
    );
  }
}

class _CollectionItem extends StatelessWidget {
  final String date;
  final int count;
  const _CollectionItem({required this.date, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.inventory_2, color: Color(0xFFB2F333), size: 20),
          const SizedBox(width: 12),
          Text(
            '$date: ',
            style: const TextStyle(
              color: Color(0xFF19133B),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '$count dispositivos',
            style: const TextStyle(
              color: Color(0xFFB2F333),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home_filled, color: Color(0xFF19133B), size: 28),
          Icon(Icons.warning_amber_rounded, color: Color(0xFF19133B), size: 28),
          GestureDetector(
            onTap: () => context.push(AppRoutes.solicitudes),
            child: const Icon(
              Icons.local_shipping,
              color: Color(0xFF19133B),
              size: 28,
            ),
          ),
          Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFF19133B),
            size: 28,
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.ajustesColaborador),
            child: Icon(
              Icons.settings_outlined,
              color: Color(0xFF19133B),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
