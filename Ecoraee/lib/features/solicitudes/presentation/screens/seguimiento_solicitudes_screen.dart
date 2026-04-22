import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_theme.dart';

class SeguimientoSolicitudesScreen extends StatefulWidget {
  const SeguimientoSolicitudesScreen({super.key});

  @override
  State<SeguimientoSolicitudesScreen> createState() => _SeguimientoSolicitudesScreenState();
}

class _SeguimientoSolicitudesScreenState extends State<SeguimientoSolicitudesScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Pendientes', 'Aceptado', 'Recogido', 'Rechazados'];

  final List<Map<String, String>> _solicitudes = [
    {
      'tipo': 'Celular',
      'cantidad': '01 dispositivo',
      'direccion': 'cll 138 b sur 45 12',
      'telefono': '3128304576',
      'fecha': '24 enero 2026',
      'fechaRecoleccion': '26 enero 2026',
      'horaEstimada': 'Entre 2:00 pm - 5:00 pm',
      'motivoRechazo': 'Fuera de zona de cobertura',
      'imagen': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=200&auto=format&fit=crop',
    },
    {
      'tipo': 'Celular',
      'cantidad': '01 dispositivo',
      'direccion': 'cll 138 b sur 45 12',
      'telefono': '3128304576',
      'fecha': '24 enero 2026',
      'fechaRecoleccion': '26 enero 2026',
      'horaEstimada': 'Entre 2:00 pm - 5:00 pm',
      'motivoRechazo': 'Fuera de zona de cobertura',
      'imagen': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=200&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CicloxColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            // ── Título y Tabs ─────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back, color: CicloxColors.dark, size: 28),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Haz seguimiento\na tus recogidas.',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: 
                            FontWeight.w900,
                            color: CicloxColors.dark,
                            height: 1.05,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_tabs.length, (index) {
                        final isSelected = index == _selectedTabIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTabIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? (index == 3 ? const Color(0xFFE5392A) : CicloxColors.dark) 
                                  : CicloxColors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected 
                                    ? (index == 3 ? const Color(0xFFE5392A) : CicloxColors.dark) 
                                    : CicloxColors.grey.withOpacity(0.5),
                              ),
                            ),
                            child: Text(
                              _tabs[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? CicloxColors.white : CicloxColors.dark,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // ── Contenido ─────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // Mensaje de estado
                    if (_selectedTabIndex == 0) ...[
                      const Text(
                        'Recibimos tu solicitud.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: CicloxColors.dark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ahora nuestro equipo la está revisando para programar la recogida',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: CicloxColors.grey.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ] else if (_selectedTabIndex == 1) ...[
                      const Text(
                        '¡Tu solicitud fue aceptada!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: CicloxColors.dark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ya estamos preparando tu recolección',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: CicloxColors.grey.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ] else if (_selectedTabIndex == 2) ...[
                      const Text(
                        '¡Recolección completada!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: CicloxColors.dark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Gracias por reciclar con Ciclox.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: CicloxColors.grey.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ] else if (_selectedTabIndex == 3) ...[
                      const Text(
                        'Solicitud rechazada',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: CicloxColors.dark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'No pudimos procesarla en este momento',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: CicloxColors.grey.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Contenido principal dependiendo de la pestaña
                    if (_selectedTabIndex == 0 || _selectedTabIndex == 1 || _selectedTabIndex == 3) ...[
                      // Lista de tarjetas
                      ..._solicitudes.map((solicitud) => _buildCard(solicitud)),

                      const SizedBox(height: 16),
                      if (_selectedTabIndex == 0 || _selectedTabIndex == 1) ...[
                        // Botón Cancelar solicitud (Rojo)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/solicitud-cancelada');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE5392A), // Rojo
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Cancelar solicitud',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: CicloxColors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'solo se puede cancelar si no se ha notificado la recogida',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: CicloxColors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ] else if (_selectedTabIndex == 3) ...[
                        // Botón Hacer otra solicitud
                        SizedBox(
                          width: 220,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/crear-solicitud');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CicloxColors.dark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Hacer otra solicitud',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: CicloxColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 32),
                    ] else if (_selectedTabIndex == 2) ...[
                      // Tarjeta de recompensa
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                        decoration: BoxDecoration(
                          color: CicloxColors.dark,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              '+6000',
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w900,
                                color: CicloxColors.white,
                                letterSpacing: -2,
                                height: 1.0,
                              ),
                            ),
                            const Text(
                              'Puntos ganados',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: CicloxColors.white,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tus puntos ya fueron añadidos a tu cuenta',
                              style: TextStyle(
                                fontSize: 13,
                                color: CicloxColors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Botón Ver recompensa
                      SizedBox(
                        width: 220,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            // Ir a ver recompensas (ej. cambiar a tab de estrella)
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CicloxColors.dark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Ver recompensa',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: CicloxColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: 1,
        onTap: (i) {
          if (i == 0) {
            context.go('/perfil');
          } else if (i == 1) {
            context.go('/dashboard');
          }
        },
      ),
    );
  }

  Widget _buildCard(Map<String, String> solicitud) {
    final hasImage = solicitud['imagen']!.isNotEmpty;

    return GestureDetector(
      onTap: () {
        context.push('/trazabilidad');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: CicloxColors.dark, // Fondo negro/oscuro por defecto
                image: hasImage
                    ? DecorationImage(
                        image: NetworkImage(solicitud['imagen']!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),

            // Información
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRichText('Tipo de residuo: ', solicitud['tipo']!),
                  _buildRichText('Cantidad: ', solicitud['cantidad']!),
                  _buildRichText('Dirección: ', solicitud['direccion']!),
                  _buildRichText('Teléfono: ', solicitud['telefono']!),
                  _buildRichText('Fecha de solicitud: ', solicitud['fecha']!),
                  if (solicitud.containsKey('fechaRecoleccion'))
                    _buildRichText('Fecha de recolección: ', solicitud['fechaRecoleccion']!),
                  if (solicitud.containsKey('horaEstimada'))
                    _buildRichText('Hora estimada: ', solicitud['horaEstimada']!),
                  if (solicitud.containsKey('motivoRechazo')) ...[
                    const SizedBox(height: 2),
                    const Text(
                      'Motivo del rechazo',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: CicloxColors.dark,
                      ),
                    ),
                    Text(
                      solicitud['motivoRechazo']!,
                      style: TextStyle(
                        fontSize: 13,
                        color: CicloxColors.grey.withOpacity(0.9),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichText(String bold, String normal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 13,
            color: CicloxColors.dark,
            height: 1.2,
          ),
          children: [
            TextSpan(
              text: bold,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            TextSpan(
              text: normal,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: CicloxColors.grey.withOpacity(0.9),
              ),
            ),
          ],
        ),
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
