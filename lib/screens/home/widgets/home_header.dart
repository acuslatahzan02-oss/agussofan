import 'package:flutter/material.dart';

import '../../../data/demo_data.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/formatters.dart';
import '../../../widgets/nusa_logo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.onNotifications,
    required this.onProfile,
    this.hasUnreadNotifications = true,
  });

  final VoidCallback onNotifications;
  final VoidCallback onProfile;
  final bool hasUnreadNotifications;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final compact = MediaQuery.sizeOf(context).width < 360;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            NusaLogo(markSize: compact ? 36 : 40, showWordmark: !compact),
            const Spacer(),
            Semantics(
              button: true,
              label: 'Notifikasi',
              child: InkWell(
                onTap: onNotifications,
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.line),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        size: 22,
                        color: AppColors.ink,
                      ),
                    ),
                    if (hasUnreadNotifications)
                      Positioned(
                        top: 11,
                        right: 12,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.coral,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surface,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Semantics(
              button: true,
              label: 'Buka profil',
              child: InkWell(
                onTap: onProfile,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFDCEBE4), Color(0xFFC8E0D6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.surface.withValues(alpha: 0.9),
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    'RP',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.brand,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${greeting(now)}, ',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.7,
                  color: AppColors.ink,
                ),
              ),
              TextSpan(
                text: '${DemoData.firstName} 👋',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.7,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              size: 12,
              color: AppColors.inkMuted,
            ),
            const SizedBox(width: 6),
            Text(
              longDate(now),
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.inkSoft,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
