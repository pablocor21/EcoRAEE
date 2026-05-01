import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/router/app_router.dart';

class SoporteColabScreen extends StatefulWidget {
  const SoporteColabScreen({super.key});

  @override
  State<SoporteColabScreen> createState() => _SoporteColabScreenState();
}

class _SoporteColabScreenState extends State<SoporteColabScreen> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, escribe tu mensaje')),
      );
      return;
    }

    // Simulamos envío
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mensaje enviado'),
        backgroundColor: Colors.green,
      ),
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF19133B),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 1. Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const SizedBox(
                      width: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'SOPORTE TÉCNICO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 2. Contenedor Blanco
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F6F8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '¿En qué podemos ayudarte?',
                        style: TextStyle(
                          color: Color(0xFF19133B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Caja de texto
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _controller,
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText: 'Escribe aquí tu reporte o duda...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(20),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Explicación
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline, color: Colors.blue, size: 24),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Los mensajes de reporte llegan al correo del administrador y se revisarán lo más rápido posible para dar una solución.',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Botón Enviar
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: _handleSend,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF19133B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'ENVIAR REPORTE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _CustomBottomNavBar(),
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
            offset: const Offset(0, -2),
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
            child: const Icon(Icons.warning_rounded, color: Color(0xFF19133B), size: 28),
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.solicitudes),
            child: const Icon(Icons.local_shipping, color: Color(0xFF19133B), size: 28),
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
            child: const Icon(Icons.settings_rounded, color: Color(0xFF19133B), size: 28),
          ),
        ],
      ),
    );
  }
}
