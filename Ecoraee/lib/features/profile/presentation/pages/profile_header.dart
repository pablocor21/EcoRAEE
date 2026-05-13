import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBackPressed;

  const ProfileHeader({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Placeholder for the logo - assuming there's an asset or we can use a custom widget
              // The image shows 'ciclox' with a lightning bolt
              Image.asset(
                'assets/imagenes/LOGO PRINCIPAL COLOR.png', // Fallback to existing logo
                height: 40,
                errorBuilder: (context, error, stackTrace) => const Text(
                  'ciclox',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
              ),
              const Icon(Icons.notifications, color: AppColors.navy, size: 30),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              if (showBack)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.navy, size: 30),
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              if (showBack) const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.navy,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
