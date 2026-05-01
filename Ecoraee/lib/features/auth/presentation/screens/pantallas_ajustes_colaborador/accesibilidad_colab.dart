import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/router/app_router.dart';

class AccesibilidadColabScreen extends StatefulWidget {
  const AccesibilidadColabScreen({super.key});

  @override
  State<AccesibilidadColabScreen> createState() =>
      _AccesibilidadColabScreenState();
}

class _AccesibilidadColabScreenState extends State<AccesibilidadColabScreen> {
  String _tamaNoTexto = 'Mediano';
  bool _altoContraste = false;
  String _tamaNoBotones = 'Mediano';
  bool _modoOscuro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF0),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Customizado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: CicloxColors.dark,
                      size: 20,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'ACCESIBILIDAD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CicloxColors.dark,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Tarjeta 1: Tamaño de texto y Alto contraste
                    _buildContainerCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Tamaño del texto',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildOptionButton(
                                label: 'Pequeño',
                                isSelected: _tamaNoTexto == 'Pequeño',
                                onTap: () =>
                                    setState(() => _tamaNoTexto = 'Pequeño'),
                              ),
                              const SizedBox(width: 10),
                              _buildOptionButton(
                                label: 'Mediano',
                                isSelected: _tamaNoTexto == 'Mediano',
                                onTap: () =>
                                    setState(() => _tamaNoTexto = 'Mediano'),
                              ),
                              const SizedBox(width: 10),
                              _buildOptionButton(
                                label: 'Grande',
                                isSelected: _tamaNoTexto == 'Grande',
                                onTap: () =>
                                    setState(() => _tamaNoTexto = 'Grande'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Divider(height: 1, color: Color(0xFFE0E0E0)),
                          const SizedBox(height: 10),
                          _buildSwitchRow(
                            title: 'Modo alto de contraste',
                            value: _altoContraste,
                            onChanged: (val) =>
                                setState(() => _altoContraste = val),
                          ),
                        ],
                      ),
                    ),

                    // Tarjeta Omitida: Lectura de pantalla (tal como se solicitó omitir)

                    // Tarjeta 2: Tamaño de botones
                    _buildContainerCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Tamaño de botones',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildOptionButton(
                                label: 'Pequeño',
                                isSelected: _tamaNoBotones == 'Pequeño',
                                onTap: () =>
                                    setState(() => _tamaNoBotones = 'Pequeño'),
                              ),
                              const SizedBox(width: 10),
                              _buildOptionButton(
                                label: 'Mediano',
                                isSelected: _tamaNoBotones == 'Mediano',
                                onTap: () =>
                                    setState(() => _tamaNoBotones = 'Mediano'),
                              ),
                              const SizedBox(width: 10),
                              _buildOptionButton(
                                label: 'Grande',
                                isSelected: _tamaNoBotones == 'Grande',
                                onTap: () =>
                                    setState(() => _tamaNoBotones = 'Grande'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Tarjeta 3: Modo oscuro
                    _buildContainerCard(
                      child: _buildSwitchRow(
                        title: 'Modo oscuro',
                        value: _modoOscuro,
                        onChanged: (val) => setState(() => _modoOscuro = val),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => context.go(AppRoutes.dashboardColaborador),
              child: const Icon(
                Icons.home_filled,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.soporteColaborador),
              child: const Icon(
                Icons.warning_rounded,
                color: Color(0xFF19133B),
                size: 28,
              ),
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
              onTap: () => context.go(AppRoutes.ajustesColaborador),
              child: const Icon(
                Icons.settings_rounded,
                color: Color(0xFF19133B),
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _buildOptionButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    double fontSize = 13;
    if (label == 'Mediano') fontSize = 15;
    if (label == 'Grande') fontSize = 18;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6584A8)
                : const Color(0xFFF2F0ED),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: fontSize,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Transform.scale(
          scale: 0.9,
          child: Switch(
            value: value,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF34C759), // Verde iOS activo
            inactiveThumbColor: const Color(0xFFC7C7CC),
            inactiveTrackColor: const Color(0xFFE5E5EA),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
