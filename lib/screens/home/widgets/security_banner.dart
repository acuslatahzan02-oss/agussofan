import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class SecurityBanner extends StatelessWidget {
  const SecurityBanner({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                AppColors.brandSoft,
                AppColors.brandSoft.withValues(alpha: 0.35),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border.all(color: AppColors.brand.withValues(alpha: 0.08)),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.verified_user_rounded,
                  size: 19,
                  color: AppColors.brand,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dana kamu aman',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Saldo terlindungi LPS hingga Rp 2 miliar.',
                      style: TextStyle(
                        fontSize: 9.5,
                        height: 1.4,
                        color: AppColors.inkSoft,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 19,
                color: AppColors.inkSoft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
