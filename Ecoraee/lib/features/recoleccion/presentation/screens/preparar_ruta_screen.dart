import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'iniciar_ruta_screen.dart';

/// Pantalla para visualizar y preparar la ruta de recolección.
/// Implementación puramente visual (SIN LÓGICA) como solicitado.
class PrepararRutaScreen extends StatelessWidget {
  const PrepararRutaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF19133B), // Fondo oscuro base
      body: Stack(
        children: [
          // 1. FONDO DEL MAPA (Visualización simulada con CustomPainter)
          // Se dibuja la ruta interconectando 3 puntos simulados
          const _MapBackground(),

          // 2. CONTENIDO SUPERPUESTO (Header + Lista inferior)
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // HEADER (Botón volver, título y logo)
                const _HeaderRow(),

                const Spacer(), // Empuja el panel inferior hacia abajo
                // PANEL INFERIOR (Fondo curvo con opacidad que contiene la lista y el botón)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.92,
                    ), // Opacidad para el efecto glass/capa
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tarjeta Ubicación 1
                      const _RouteLocationCard(
                        title: 'Edificio residencia Doña Ana',
                        time: '10:00 am',
                        pinColor: Color(0xFF5A7CB0), // Azul suave
                      ),
                      const SizedBox(height: 15),

                      // Tarjeta Ubicación 2
                      const _RouteLocationCard(
                        title: 'Barrio manrique La Esmeraldas',
                        time: '12:00 m',
                        pinColor: Color(0xFFB2F333), // Verde brillante Ciclox
                      ),
                      const SizedBox(height: 15),

                      // Tarjeta Ubicación 3
                      const _RouteLocationCard(
                        title: 'Edificio residencia San Sebastián',
                        time: '02:00 pm',
                        pinColor: Color(0xFFB2F333), // Verde brillante Ciclox
                      ),
                      const SizedBox(height: 30),

                      // BOTÓN INICIAR
                      _SwipeToStartButton(
                        onSwipeCompleted: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IniciarRutaScreen(),
                            ),
                          );
                        },
                      ),
                    ],
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

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES PRIVADOS
// ──────────────────────────────────────────────────────────────────────────────

/// Componente para el encabezado (Header)
/// Contiene botón de volver, título central y logo derecho
class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Botón atrás
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 6.0,
                  ), // Ajuste visual para que la flecha quede centrada
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),

          // Título central
          const Text(
            'PREPARAR RUTA',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),

          // Logo placeholder (Basado en recoleccion_screen para consistencia)
          // Logo Ciclox derecha
          Image.asset(
            'assets/iconos/logo-icono VERDE-8.png',
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

/// Componente para cada tarjeta de ubicación en la lista inferior
class _RouteLocationCard extends StatelessWidget {
  final String title;
  final String time;
  final Color pinColor;

  const _RouteLocationCard({
    required this.title,
    required this.time,
    required this.pinColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icono de Pin con color dinámico
          Icon(Icons.location_on, color: pinColor, size: 32),
          const SizedBox(width: 15),

          // Información de la ubicación
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF19133B), // Dark blue de Ciclox
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      color: Color(0xFF19133B),
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Color(0xFF19133B),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Fondo que simula el mapa y la ruta dibujada (Puntos 1, 2 y 3 conectados)
class _MapBackground extends StatelessWidget {
  const _MapBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1A2138), // Color base azul grisáceo (nocturno)
      ),
      child: Stack(
        children: [
          // Patrón cuadriculado suave para dar sensación de calles/mapa
          Opacity(
            opacity: 0.05,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                  ),
                );
              },
            ),
          ),

          // Pintor personalizado para dibujar las líneas curvas y los marcadores
          const Positioned.fill(
            child: CustomPaint(painter: _MapRoutePainter()),
          ),
        ],
      ),
    );
  }
}

/// CustomPainter encargado de dibujar la línea de la ruta estilo neón y los pines 1, 2, 3
class _MapRoutePainter extends CustomPainter {
  const _MapRoutePainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Coordenadas relativas a la pantalla para los pines
    final p1 = Offset(size.width * 0.30, size.height * 0.18);
    final p2 = Offset(size.width * 0.70, size.height * 0.30);
    final p3 = Offset(size.width * 0.35, size.height * 0.44);

    // 1. Dibujar la línea conectora (Efecto resplandor / Neon Cyan)
    final path = Path();
    path.moveTo(p1.dx, p1.dy);

    // Curva de p1 a p2
    path.cubicTo(p1.dx + 40, p1.dy + 10, p2.dx - 60, p2.dy - 40, p2.dx, p2.dy);

    // Curva de p2 a p3
    path.cubicTo(p2.dx - 20, p2.dy + 60, p3.dx + 60, p3.dy - 10, p3.dx, p3.dy);

    // Pintura del resplandor de la línea
    final neonGlowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..color = Colors.cyanAccent.withOpacity(0.6)
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

    // Pintura de la línea solida central
    final solidLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.cyanAccent
      ..strokeCap = StrokeCap.round;

    // Dibujamos las líneas en el canvas
    canvas.drawPath(path, neonGlowPaint);
    canvas.drawPath(path, solidLinePaint);

    // 2. Dibujar los Pines enumerados
    _drawPin(canvas, p1, '1');
    _drawPin(canvas, p2, '2');
    _drawPin(canvas, p3, '3');
  }

  /// Método auxiliar para dibujar un pin individual
  void _drawPin(Canvas canvas, Offset center, String number) {
    const pinColor = Color(0xFF6DA238); // Verde oscuro mapa

    // Fondo del círculo verde
    final bgPaint = Paint()
      ..color = pinColor
      ..style = PaintingStyle.fill;

    // Borde blanco del círculo
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Triángulo inferior (la punta del pin)
    final path = Path();
    path.moveTo(center.dx - 12, center.dy + 10);
    path.lineTo(center.dx, center.dy + 26);
    path.lineTo(center.dx + 12, center.dy + 10);
    path.close();
    canvas.drawPath(path, bgPaint);

    // Dibujamos el círculo principal del pin
    canvas.drawCircle(center, 18, bgPaint);
    canvas.drawCircle(center, 18, borderPaint);

    // Punto de anclaje (Círculo pequeño blanco en la punta)
    final anchorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final anchorBorderPaint = Paint()
      ..color = Colors.cyanAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(Offset(center.dx, center.dy + 26), 4, anchorPaint);
    canvas.drawCircle(Offset(center.dx, center.dy + 26), 4, anchorBorderPaint);

    // Texto (Número dentro del pin)
    final textSpan = TextSpan(
      text: number,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();

    // Centrar el texto en el pin
    textPainter.paint(
      canvas,
      Offset(
        center.dx - (textPainter.width / 2),
        center.dy - (textPainter.height / 2),
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SwipeToStartButton extends StatefulWidget {
  final VoidCallback onSwipeCompleted;

  const _SwipeToStartButton({required this.onSwipeCompleted});

  @override
  State<_SwipeToStartButton> createState() => _SwipeToStartButtonState();
}

class _SwipeToStartButtonState extends State<_SwipeToStartButton> {
  double _dragPosition = 0;
  bool _isFinished = false;
  final double _buttonHeight = 60.0;
  final double _thumbSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _buttonHeight,
      decoration: BoxDecoration(
        color: const Color(0xFF2A3143), // Fondo oscuro gris azulado
        borderRadius: BorderRadius.circular(_buttonHeight / 2),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonWidth = constraints.maxWidth;
          final maxDrag = buttonWidth - _thumbSize - 10;

          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Texto centrado
              const Center(
                child: Text(
                  'INICIAR RUTA',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              // Thumb desplazable
              Positioned(
                left: _dragPosition,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (_isFinished) return;
                    setState(() {
                      _dragPosition += details.delta.dx;
                      if (_dragPosition < 0) _dragPosition = 0;
                      if (_dragPosition > maxDrag) {
                        _dragPosition = maxDrag;
                      }
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (_isFinished) return;
                    if (_dragPosition > maxDrag * 0.8) {
                      setState(() {
                        _dragPosition = maxDrag;
                        _isFinished = true;
                      });
                      // Pequeño delay visual antes de navegar
                      Future.delayed(const Duration(milliseconds: 200), () {
                        widget.onSwipeCompleted();
                        // Resetear para cuando vuelva
                        setState(() {
                          _dragPosition = 0;
                          _isFinished = false;
                        });
                      });
                    } else {
                      // Vuelve a la posición inicial
                      setState(() {
                        _dragPosition = 0;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
