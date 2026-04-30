import '../../../../config/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class RegistrosScreen extends StatelessWidget {
  const RegistrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. FONDO CON GRADIENTE (Siguiendo el estilo de Dashboard)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0D0B21), // Azul muy oscuro
                  Color(0xFF19133B), // CicloxColors.dark
                  Color(0xFF25214D), // Azul un poco más claro
                ],
              ),
            ),
          ),

          // Patrón de puntos sutil (opcional, para mayor fidelidad a la imagen)
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

                // 3. CUERPO (Contenedor Gris Claro)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE9EDF0), // Gris claro de la imagen
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
                        const SizedBox(height: 20),

                        // 5. LISTA DE REGISTROS
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              _RegistroCard(
                                title: 'Laptop Asus ROG',
                                description:
                                    'Portátil gamer Asus ROG Strix RTX 5070 Ti, ideal para alto rendimiento y tareas exigentes.',
                                detail: '32 GB de RAM',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?w=200',
                              ),
                              SizedBox(height: 20),
                              _RegistroCard(
                                title: 'Monitor LG',
                                description:
                                    'Portátil gamer Asus ROG Strix RTX 5070 Ti, ideal para alto rendimiento y tareas exigentes.',
                                detail: 'Flex led',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=200',
                              ),
                              SizedBox(height: 20),
                              _RegistroCard(
                                title: 'Tarjeta gráfica 9060 RTX',
                                description:
                                    'Portátil gamer Asus ROG Strix RTX 5070 Ti, ideal para alto rendimiento y tareas exigentes.',
                                detail: 'Adaptable',
                                imageUrl:
                                    'https://images.unsplash.com/photo-1591488320449-011701bb6704?w=200',
                              ),
                              SizedBox(height: 100), // Espacio para el nav bar
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
      // 6. BOTTOM NAVIGATION BAR
      bottomNavigationBar: const _CustomBottomNavBar(),
      extendBody: true, // Para que el cuerpo se extienda detrás del nav bar
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES DE LA PANTALLA
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
          // Logo 'C'
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
          // Título Central
          const Text(
            'REGISTRO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          // Logo Ciclox derecha
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
        color: const Color(0xFFDDE1E4), // Gris un poco más oscuro
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

class _RegistroCard extends StatelessWidget {
  final String title;
  final String description;
  final String detail;
  final String imageUrl;

  const _RegistroCard({
    required this.title,
    required this.description,
    required this.detail,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F6),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              // Texto
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
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Detalle inferior izquierdo
              Row(
                children: [
                  const Icon(Icons.bolt, color: Color(0xFFB2F333), size: 20),
                  const SizedBox(width: 5),
                  Text(
                    detail,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              // Slider interactivo
              const _InteractiveSlider(),
            ],
          ),
        ],
      ),
    );
  }
}

class _InteractiveSlider extends StatefulWidget {
  const _InteractiveSlider();

  @override
  State<_InteractiveSlider> createState() => _InteractiveSliderState();
}

class _InteractiveSliderState extends State<_InteractiveSlider> {
  double _position = 0.5; // 0.0 = Aprobar, 1.0 = Rechazar, 0.5 = Centro

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _position += details.primaryDelta! / 150; // Sensibilidad
          _position = _position.clamp(0.0, 1.0);
        });
      },
      onHorizontalDragEnd: (details) {
        // Snap al centro o a los extremos si se desea (opcional)
        /*
        setState(() {
          if (_position < 0.3) _position = 0.0;
          else if (_position > 0.7) _position = 1.0;
          else _position = 0.5;
        });
        */
      },
      child: Container(
        width: 160,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFB2F333), // Verde (Aprobar)
              Color(0xFFE0E5E9), // Centro neutral
              Color(0xFFE5989B), // Rojo/Rosa (Rechazar)
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Textos de fondo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Aprobar',
                    style: TextStyle(
                      color: Color(0xFF19133B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rechazar',
                    style: TextStyle(
                      color: Color(0xFF19133B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Thumb (Círculo blanco)
            AnimatedAlign(
              duration: const Duration(milliseconds: 100),
              alignment: Alignment(_position * 2 - 1, 0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 37,
                height: 37,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.home_filled, color: Color(0xFF19133B), size: 28),
          Icon(Icons.warning_amber_rounded, color: Color(0xFF19133B), size: 28),
          GestureDetector(
            onTap: () => context.push(AppRoutes.solicitudes),
            child: const Icon(Icons.local_shipping, color: Color(0xFF19133B), size: 28),
          ),
          Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFF19133B),
            size: 28,
          ),
          GestureDetector(onTap: () => context.push(AppRoutes.ajustesColaborador), child: Icon(Icons.settings_outlined, color: Color(0xFF19133B), size: 28)),
        ],
      ),
    );
  }
}
