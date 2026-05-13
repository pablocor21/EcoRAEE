import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'profile_header.dart';
import '../widgets/profile_bottom_nav.dart';

class AccesibilidadPage extends StatefulWidget {
  const AccesibilidadPage({super.key});

  @override
  State<AccesibilidadPage> createState() => _AccesibilidadPageState();
}

class _AccesibilidadPageState extends State<AccesibilidadPage> {
  bool darkMode = false;
  double brightness = 0.4;
  double fontSize = 0.6;
  bool vibration = true;
  bool textReading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeader(title: 'Accesibilidad', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  _buildSwitchTile('Modo oscuro', darkMode, (val) => setState(() => darkMode = val)),
                  const SizedBox(height: 15),
                  _buildSliderTile('Brillo', 'Nivel de brillo', brightness, (val) => setState(() => brightness = val)),
                  const SizedBox(height: 15),
                  _buildSliderTile('Tamaño de la fuente', 'Amplia o reduce el texto', fontSize, (val) => setState(() => fontSize = val)),
                  const SizedBox(height: 15),
                  _buildSwitchTile('Vibracion', vibration, (val) => setState(() => vibration = val)),
                  const SizedBox(height: 15),
                  _buildSwitchTile('Lectura de textos', textReading, (val) => setState(() => textReading = val)),
                  const SizedBox(height: 20),
                  const Text(
                    'La APP utiliza estos permisos para mejorar tu experiencia',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement Save Changes
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navy,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Guardar cambios',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
      bottomNavigationBar: const ProfileBottomNav(currentIndex: 0),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.red, // Based on image
          ),
        ],
      ),
    );
  }

  Widget _buildSliderTile(String title, String subtitle, double value, Function(double) onChanged) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Row(
            children: [
              const Icon(Icons.remove, size: 20),
              Expanded(
                child: Slider(
                  value: value,
                  onChanged: onChanged,
                  activeColor: AppColors.navy,
                  inactiveColor: Colors.black12,
                ),
              ),
              const Icon(Icons.add, size: 20),
            ],
          ),
        ],
      ),
    );
  }

}
