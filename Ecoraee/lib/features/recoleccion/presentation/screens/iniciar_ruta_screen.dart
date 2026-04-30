import '../../../../config/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

/// Pantalla para iniciar la ruta de recolección.
/// Implementación puramente visual (SIN LÓGICA) según requerimientos,
/// siguiendo la arquitectura definida en Agents.md.
class IniciarRutaScreen extends StatelessWidget {
  const IniciarRutaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo oscuro principal de la aplicación
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // Fondo decorativo con puntos simulando el patrón visual
          const _BackgroundPattern(),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // 1. Logo superior central (CX)
                const _LogoHeader(),
                
                const SizedBox(height: 50),

                // 2. Tarjeta: Duración de la Ruta
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _DuracionRutaCard(),
                ),
                
                const SizedBox(height: 20),

                // 3. Tarjeta: Recomendaciones de Seguridad
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _RecomendacionesCard(),
                ),

                const Spacer(),

                // 4. Componente visual interactivo (Slider: Iniciar Ruta)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: _IniciarRutaSlider(),
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
      // 5. Barra de navegación inferior
      bottomNavigationBar: const _CustomBottomNavigationBar(),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// COMPONENTES PRIVADOS DE LA PANTALLA
// ──────────────────────────────────────────────────────────────────────────────

/// Patrón de fondo simulando el cielo estrellado o grilla de puntos del diseño
class _BackgroundPattern extends StatelessWidget {
  const _BackgroundPattern();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/stars_bg.png'), // Placeholder por si existe
            fit: BoxFit.cover,
          ),
        ),
        // Generador de puntos como alternativa visual si no hay imagen
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 20,
          ),
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                width: 2,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Logo superior compuesto simulando "CX" con el diseño específico
class _LogoHeader extends StatelessWidget {
  const _LogoHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Representación de la 'C'
        const Text(
          'C',
          style: TextStyle(
            color: Color(0xFFE2E8F0),
            fontSize: 70,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: -5,
          ),
        ),
        // Representación abstracta de la 'X' / Logo
        Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              'X',
              style: TextStyle(
                color: Color(0xFFE2E8F0),
                fontSize: 70,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
            // Detalles verdes del logo
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFFB2F333),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flash_on,
                  size: 14,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 5,
              child: Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: Color(0xFFB2F333),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Tarjeta que muestra la duración de la ruta dividida en tres columnas
class _DuracionRutaCard extends StatelessWidget {
  const _DuracionRutaCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A153A), // Fondo morado/azul oscuro
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const Text(
            'DURACIÓN DE LA RUTA',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDurationColumn('01:00:00', 'Edificio residencia\nDoña Ana'),
              _buildDivider(),
              _buildDurationColumn('00:25:00', 'Barrio\nManrique'),
              _buildDivider(),
              _buildDurationColumn('01:30:00', 'Edificio\nSan Sebastián'),
            ],
          ),
        ],
      ),
    );
  }

  // Separador vertical entre las columnas de tiempo
  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    );
  }

  // Columna individual de tiempo y ubicación
  Widget _buildDurationColumn(String time, String location) {
    return Expanded(
      child: Column(
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            location,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta con las recomendaciones de seguridad (icono de alerta y lista)
class _RecomendacionesCard extends StatelessWidget {
  const _RecomendacionesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFD4D4D8), // Fondo gris claro
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icono de Alerta Superior
          const Icon(
            Icons.warning_rounded,
            color: Color(0xFFE4574C), // Rojo coral
            size: 60,
          ),
          const SizedBox(height: 10),
          
          // Título
          const Text(
            'RECOMENDACIONES DE SEGURIDAD',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF1E1E2C),
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          
          // Lista de viñetas con iconos verdes
          _buildListItem('Verifica que el vehículo esté en buen estado.'),
          _buildListItem('Confirma batería/carga suficiente del dispositivo.'),
          _buildListItem('Revisa que la ruta esté completa y actualizada.'),
          _buildListItem('Sigue únicamente la ruta asignada.'),
          _buildListItem('Evita zonas no autorizadas o inseguras.'),
          _buildListItem('No manipules el celular mientras conduces.'),
          
          const SizedBox(height: 15),
          
          // Texto "Ver más >"
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Ver más',
                style: TextStyle(
                  color: Color(0xFF1E1E2C),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Color(0xFF1E1E2C),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Elemento individual de la lista de recomendaciones
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.flash_on, // Icono de rayo verde como viñeta
              color: Color(0xFFB2F333), // Verde Ciclox
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF4A4A5A),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Slider interactivo falso para iniciar la ruta
class _IniciarRutaSlider extends StatelessWidget {
  const _IniciarRutaSlider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        children: [
          // Círculo blanco que simula el botón deslizable
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          // Texto central
          const Expanded(
            child: Text(
              'INICIAR RUTA',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 65), // Balance visual por el círculo de la izquierda
        ],
      ),
    );
  }
}

/// Barra de navegación inferior
class _CustomBottomNavigationBar extends StatelessWidget {
  const _CustomBottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.home, color: Color(0xFF19133B), size: 30),
          Icon(Icons.warning_amber_rounded, color: Color(0xFF19133B), size: 30),
          Icon(Icons.inbox, color: Color(0xFF19133B), size: 30),
          Icon(Icons.notifications, color: Color(0xFF19133B), size: 30),
          GestureDetector(onTap: () => context.push(AppRoutes.ajustesColaborador), child: Icon(Icons.settings, color: Color(0xFF19133B), size: 30)),
        ],
      ),
    );
  }
}
