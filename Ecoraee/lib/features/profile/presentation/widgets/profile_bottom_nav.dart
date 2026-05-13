import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_routes.dart';

class ProfileBottomNav extends StatelessWidget {
  final int currentIndex;

  const ProfileBottomNav({
    super.key,
    this.currentIndex = 0, // 0: Settings, 1: Home, 2: Stars
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            Icons.settings_outlined,
            isActive: currentIndex == 0,
            onTap: () {
              if (currentIndex != 0) {
                context.push(AppRoutes.configuracion);
              }
            },
          ),
          _buildNavItem(
            context,
            Icons.home_rounded,
            isActive: currentIndex == 1,
            onTap: () => context.go(AppRoutes.homeUsuario),
          ),
          _buildNavItem(
            context,
            Icons.stars_rounded,
            isActive: currentIndex == 2,
            onTap: () => context.push(AppRoutes.tusPuntos),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon, {
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: isActive
            ? BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Icon(
          icon,
          size: 26,
          color: isActive ? AppColors.navy : const Color(0xFF9E9E9E), // Using textSecondary equivalent
        ),
      ),
    );
  }
}
