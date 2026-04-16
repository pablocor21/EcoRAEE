import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../../config/router/app_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'profile_screen.dart';

// ─────────────────────────────────────────────
// HOME TAB
// ─────────────────────────────────────────────
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Banner
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: CicloxColors.dark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Bienvenido!',
                          style: TextStyle(
                            color: CicloxColors.grey,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '¿Qué deseas reciclar hoy?',
                          style: TextStyle(
                            color: CicloxColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.eco_rounded,
                              color: CicloxColors.primary,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Transforma · Recupera · Reintegra',
                              style: TextStyle(
                                color: CicloxColors.primary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: CicloxColors.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.recycling_rounded,
                      color: CicloxColors.primary,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Stats
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: Row(
              children: [
                _StatCard(
                  label: 'Dispositivos',
                  value: '0',
                  icon: Icons.devices_rounded,
                  color: CicloxColors.primary,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'Solicitudes',
                  value: '0',
                  icon: Icons.assignment_rounded,
                  color: CicloxColors.secondary,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'CO₂ ahorrado',
                  value: '0kg',
                  icon: Icons.eco_rounded,
                  color: const Color(0xFF4CAF50),
                ),
              ],
            ),
          ),
        ),

        // Acciones rápidas
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 22, 20, 12),
            child: Text(
              'Acciones rápidas',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: CicloxColors.dark,
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.05,
            ),
            delegate: SliverChildListDelegate([
              _ActionCard(
                icon: Icons.add_circle_rounded,
                label: 'Registrar\ndispositivo',
                color: CicloxColors.primary,
                textColor: CicloxColors.dark,
                onTap: () {
                  context.push('/registro-dispositivo');
                },
              ),
              _ActionCard(
                icon: Icons.local_shipping_rounded,
                label: 'Solicitar\nrecolección',
                color: CicloxColors.dark,
                textColor: CicloxColors.white,
                onTap: () {},
              ),
              _ActionCard(
                icon: Icons.devices_other_rounded,
                label: 'Mis\ndispositivos',
                color: CicloxColors.secondary,
                textColor: CicloxColors.white,
                onTap: () {},
              ),
              _ActionCard(
                icon: Icons.location_on_rounded,
                label: 'Puntos\ncercanos',
                color: CicloxColors.primaryLight,
                textColor: CicloxColors.dark,
                onTap: () {},
              ),
            ]),
          ),
        ),

        // Actividad reciente
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 22, 20, 12),
            child: Text(
              'Actividad reciente',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: CicloxColors.dark,
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: CicloxColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.inbox_rounded,
                    size: 48,
                    color: CicloxColors.grey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sin actividad aún',
                    style: TextStyle(color: CicloxColors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Registra tu primer dispositivo',
                    style: TextStyle(color: CicloxColors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// PLACEHOLDER TABS
// ─────────────────────────────────────────────
class _PlaceholderTab extends StatelessWidget {
  final String label;
  final IconData icon;
  const _PlaceholderTab({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: CicloxColors.grey.withOpacity(0.4)),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: CicloxColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Próximamente',
            style: TextStyle(color: CicloxColors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DASHBOARD SHELL (ciudadano)
// ─────────────────────────────────────────────
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isRefreshing = false;

  final List<Widget> _tabs = const [
    _HomeTab(),
    _PlaceholderTab(label: 'Dispositivos', icon: Icons.devices_other_rounded),
    _PlaceholderTab(label: 'Solicitudes', icon: Icons.assignment_rounded),
    ProfileScreen(),
  ];

  Future<void> _refresh() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isRefreshing = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Datos actualizados'),
          backgroundColor: CicloxColors.dark,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isProfileTab = _selectedIndex == 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar (se oculta en el tab de perfil)
            if (!isProfileTab)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    // Logo
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: CicloxColors.dark,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.bolt_rounded,
                              color: CicloxColors.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'ciclox',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: CicloxColors.dark,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Refresh
                    _isRefreshing
                        ? const SizedBox(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: CicloxColors.dark,
                                ),
                              ),
                            ),
                          )
                        : _IconBtn(
                            icon: Icons.refresh_rounded,
                            onTap: _refresh,
                          ),
                  ],
                ),
              ),

            // Tab content
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                color: CicloxColors.primary,
                child: _tabs[_selectedIndex],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CicloxColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: CicloxColors.dark,
          unselectedItemColor: CicloxColors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices_rounded),
              label: 'Dispositivos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: 'Solicitudes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// WIDGETS COMPARTIDOS
// ─────────────────────────────────────────────
class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: CicloxColors.dark.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: CicloxColors.dark),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CicloxColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: CicloxColors.dark,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: CicloxColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: textColor, size: 24),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: textColor,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
