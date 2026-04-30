import '../../../../config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';

class CrearSolicitudScreen extends StatefulWidget {
  const CrearSolicitudScreen({super.key});

  @override
  State<CrearSolicitudScreen> createState() => _CrearSolicitudScreenState();
}

class _CrearSolicitudScreenState extends State<CrearSolicitudScreen> {
  int _selectedDeviceIndex = 0;

  final List<Map<String, String>> _dispositivos = [
    {
      'marca': 'iPhone 11',
      'tipo': 'Celular',
      'estado': 'Enciende',
      'imagen': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=200&auto=format&fit=crop',
    },
    {
      'marca': 'Portatil HP',
      'tipo': 'Computador',
      'estado': 'Dañado',
      'imagen': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=200&auto=format&fit=crop',
    },
    {
      'marca': 'iPhone 11',
      'tipo': 'Celular',
      'estado': 'Dañado',
      'imagen': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=200&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CicloxLogo(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      size: 28,
                      color: CicloxColors.dark,
                    ),
                  ),
                ],
              ),
            ),

            // ── Contenido ─────────────────────
            Expanded(
              child: Column(
                children: [
                  // Título con botón de retroceso
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back, color: CicloxColors.dark),
                        ),
                        const Expanded(
                          child: Text(
                            'Dispositivos registrados', // Corregido de "Dispositvos"
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: CicloxColors.dark,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Subtítulo
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Text(
                      '1. Elige qué deseas entregar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: CicloxColors.dark,
                      ),
                    ),
                  ),

                  // Lista de dispositivos
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _dispositivos.length,
                      itemBuilder: (context, index) {
                        final dispositivo = _dispositivos[index];
                        final isSelected = index == _selectedDeviceIndex;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDeviceIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            child: Row(
                              children: [
                                // Checkbox (custom)
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? CicloxColors.dark : CicloxColors.grey.withOpacity(0.5),
                                      width: 1.5,
                                    ),
                                    color: isSelected ? CicloxColors.dark : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check, size: 18, color: CicloxColors.white)
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                
                                // Imagen del dispositivo
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: CicloxColors.grey.withOpacity(0.2),
                                    image: DecorationImage(
                                      image: NetworkImage(dispositivo['imagen']!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                
                                // Detalles
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildDetailRow('Marca:', dispositivo['marca']!),
                                      const SizedBox(height: 4),
                                      _buildDetailRow('Tipo:', dispositivo['tipo']!),
                                      const SizedBox(height: 4),
                                      _buildDetailRow('Estado:', dispositivo['estado']!),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Botón Siguiente paso
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/crear-solicitud-paso2');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CicloxColors.dark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Siguiente paso',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CicloxColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: 1,
        onTap: (i) {
          if (i == 0) { context.push(AppRoutes.ajustesColaborador); } else if (i == 1) {
            context.go('/dashboard');
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 15,
          color: CicloxColors.dark,
          height: 1.3,
        ),
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LOGO CICLOX PERSONALIZADO
// ─────────────────────────────────────────────
class _CicloxLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
        ),
        children: [
          TextSpan(
            text: 'ci',
            style: TextStyle(color: CicloxColors.dark),
          ),
          TextSpan(
            text: 'cl',
            style: TextStyle(color: CicloxColors.primary),
          ),
          TextSpan(
            text: 'ox',
            style: TextStyle(color: CicloxColors.dark),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BOTTOM NAVIGATION BAR
// ─────────────────────────────────────────────
class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _BottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: CicloxColors.white,
        border: Border(
          top: BorderSide(
            color: CicloxColors.dark.withOpacity(0.08),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.settings_outlined,
            index: 0,
            selectedIndex: selectedIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.home_rounded,
            index: 1,
            selectedIndex: selectedIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: Icons.star_border_rounded,
            index: 2,
            selectedIndex: selectedIndex,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _NavItem({
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? CicloxColors.dark : CicloxColors.dark.withOpacity(0.45),
        ),
      ),
    );
  }
}
