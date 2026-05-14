import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/router/app_router.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../injection_container.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_bloc.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_event.dart';
import '../../../empresas/solicitudes/presentation/bloc/empresa_solicitudes_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _nombre = 'Colaborador';
  
  @override
  void initState() {
    super.initState();
    _loadNombre();
  }

  Future<void> _loadNombre() async {
    try {
      final data = await sl<SecureStorage>().getUserData();
      if (data != null) {
        final map = jsonDecode(data) as Map<String, dynamic>;
        if (mounted) {
          setState(() {
            _nombre = map['nombre'] as String? ?? 'Colaborador';
          });
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EmpresaSolicitudesBloc>()..add(const LoadEmpresaSolicitudes()),
      child: Scaffold(
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
                  _HeaderSection(nombre: _nombre),

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
                        _SectionHeader(
                          title: 'SOLICITUDES RECIENTES',
                          onTap: () => context.push(AppRoutes.solicitudes),
                        ),
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
                        _SectionHeader(
                          title: 'RECOLECTAS',
                          onTap: () => context.push(AppRoutes.historial),
                        ),
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
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES PRIVADOS (Siguiendo la guía de mantener widgets pequeños)
// ──────────────────────────────────────────────────────────────────────────────

class _HeaderSection extends StatelessWidget {
  final String nombre;
  const _HeaderSection({required this.nombre});

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hola, $nombre',
                  style: const TextStyle(
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
          GestureDetector(
            onTap: () => context.push(AppRoutes.notificacionesColaborador),
            child: const _HeaderActionBtn(icon: Icons.notifications),
          ),
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
              // Reemplaza 'assets/logo_reciclaje.png' con la ruta de tu imagen
              Image.asset(
                'assets/iconos/logo-icono VERDE-8.png', // <-- PON AQUÍ TU IMAGEN
                width: 50,
                height: 50,
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
          BlocBuilder<EmpresaSolicitudesBloc, EmpresaSolicitudesState>(
            builder: (context, state) {
              int completadasMes = 0;
              int recoleccionesPendientes = 0; // En Transito o Aceptadas
              int activasGlobal = 0; // Pendientes globales

              if (state is EmpresaSolicitudesLoaded) {
                final solicitudes = state.solicitudes;
                
                // Ejemplo simple de calculo:
                completadasMes = solicitudes.where((s) => s.estado == 'RECOLECTADA' || s.estado == 'COMPLETADA').length;
                recoleccionesPendientes = solicitudes.where((s) => s.estado == 'ACEPTADA' || s.estado == 'EN_TRANSITO').length;
                activasGlobal = solicitudes.where((s) => s.estado == 'PENDIENTE').length;
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    value: state is EmpresaSolicitudesLoading ? '-' : '$completadasMes',
                    label: 'Recolectas\nrealizadas en el mes',
                  ),
                  _VerticalDivider(),
                  _StatItem(
                    value: state is EmpresaSolicitudesLoading ? '-' : '$recoleccionesPendientes', 
                    label: 'Tus recolectas\npendientes'
                  ),
                  _VerticalDivider(),
                  _StatItem(
                    value: state is EmpresaSolicitudesLoading ? '-' : '$activasGlobal',
                    label: 'Solicitudes\nactivas globales',
                    valueColor: const Color(0xFFB2F333),
                  ),
                ],
              );
            },
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
              fontSize: 50,
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
            Icon(icon, color: const Color(0xFF19133B), size: 50),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF19133B),
                fontWeight: FontWeight.bold,
                fontSize: 25,
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
  final VoidCallback? onTap;
  const _SectionHeader({required this.title, this.onTap});

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
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                'Ver todas',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(width: 5),
              Icon(Icons.chevron_right, color: Colors.grey[600], size: 18),
            ],
          ),
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
