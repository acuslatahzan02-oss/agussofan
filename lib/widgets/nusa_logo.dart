import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NusaLogo extends StatelessWidget {
  const NusaLogo({super.key, this.markSize = 40, this.showWordmark = true});

  final double markSize;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: markSize,
          height: markSize,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.brandLight, AppColors.brandDeep],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(markSize * 0.32),
            boxShadow: [
              BoxShadow(
                color: AppColors.brandDeep.withValues(alpha: 0.22),
                blurRadius: 14,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'n',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: markSize * 0.6,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  letterSpacing: -1,
                ),
              ),
              Positioned(
                right: markSize * 0.2,
                top: markSize * 0.2,
                child: Container(
                  width: markSize * 0.13,
                  height: markSize * 0.13,
                  decoration: const BoxDecoration(
                    color: AppColors.lime,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showWordmark) ...[
          const SizedBox(width: 10),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'nusapay',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.8,
                  ),
                ),
                TextSpan(
                  text: '.',
                  style: TextStyle(
                    color: AppColors.brand.withValues(alpha: 0.9),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
