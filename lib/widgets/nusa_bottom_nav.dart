import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NusaBottomNav extends StatelessWidget {
  const NusaBottomNav({
    super.key,
    required this.index,
    required this.onSelect,
    required this.onScan,
  });

  final int index;
  final ValueChanged<int> onSelect;
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.line.withValues(alpha: 0.9)),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.08),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          _NavItem(
            icon: Icons.home_rounded,
            label: 'Beranda',
            selected: index == 0,
            onTap: () => onSelect(0),
          ),
          _NavItem(
            icon: Icons.credit_card_rounded,
            label: 'Kartu',
            selected: index == 1,
            onTap: () => onSelect(1),
          ),
          SizedBox(
            width: 66,
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, -14),
                child: Semantics(
                  button: true,
                  label: 'Scan QRIS',
                  child: InkWell(
                    onTap: onScan,
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.brandLight, AppColors.brandDeep],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: AppColors.surface,
                          width: 3.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.brandDeep.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 24,
                        color: AppColors.lime,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          _NavItem(
            icon: Icons.pie_chart_rounded,
            label: 'Insight',
            selected: index == 2,
            onTap: () => onSelect(2),
          ),
          _NavItem(
            icon: Icons.person_rounded,
            label: 'Profil',
            selected: index == 3,
            onTap: () => onSelect(3),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.brand : AppColors.inkMuted;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 32,
                height: 27,
                decoration: BoxDecoration(
                  color: selected ? AppColors.brandSoft : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 19, color: color),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 8.5,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: color,
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
