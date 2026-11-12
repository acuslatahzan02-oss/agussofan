import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/section_header.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  static const _categories = [
    (
      label: 'Makan & minum',
      amount: 'Rp 280.000',
      percent: 0.38,
      icon: Icons.restaurant_rounded,
      color: AppColors.coral,
    ),
    (
      label: 'Belanja',
      amount: 'Rp 325.000',
      percent: 0.32,
      icon: Icons.shopping_bag_rounded,
      color: AppColors.lavender,
    ),
    (
      label: 'Hiburan',
      amount: 'Rp 186.000',
      percent: 0.18,
      icon: Icons.play_circle_fill_rounded,
      color: AppColors.sky,
    ),
    (
      label: 'Tagihan',
      amount: 'Rp 200.000',
      percent: 0.12,
      icon: Icons.bolt_rounded,
      color: AppColors.amber,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 132),
        children: [
          PageHeader(
            title: 'Insight',
            subtitle: 'Pahami ke mana uang kamu pergi bulan ini.',
            trailing: InkWell(
              onTap: () => showNusaSnackBar(
                context,
                'Filter periode akan segera hadir.',
                icon: Icons.calendar_month_rounded,
              ),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.line),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Nov 2026',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.inkSoft,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 15,
                      color: AppColors.inkSoft,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.line.withValues(alpha: 0.8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Total pengeluaran',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.inkSoft,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.brandSoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.south_east_rounded,
                            size: 11,
                            color: AppColors.brand,
                          ),
                          SizedBox(width: 3),
                          Text(
                            '12,4%',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.brand,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Rp 739.000',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.3,
                    height: 1.2,
                  ),
                ),
                const Text(
                  'Lebih hemat dari bulan lalu. Kerja bagus!',
                  style: TextStyle(fontSize: 9.5, color: AppColors.inkMuted),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 94,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (var i = 0; i < _weekBars.length; i++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  height: 66 * _weekBars[i],
                                  decoration: BoxDecoration(
                                    color: i == 5
                                        ? AppColors.brand
                                        : AppColors.brandSoft,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  _weekLabels[i],
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: i == 5
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: i == 5
                                        ? AppColors.brand
                                        : AppColors.inkMuted,
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
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Kategori pengeluaran'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.line.withValues(alpha: 0.8)),
            ),
            child: Column(
              children: [
                for (var i = 0; i < _categories.length; i++) ...[
                  _CategoryRow(category: _categories[i]),
                  if (i != _categories.length - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Divider(height: 1),
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [AppColors.amberSoft, Color(0xFFFFF9EB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: AppColors.amber.withValues(alpha: 0.14),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.lightbulb_rounded,
                    size: 19,
                    color: AppColors.amberDeep,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tips hemat untukmu',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Pengeluaran hiburan naik 8%. Kurangi satu langganan '
                        'dan kamu bisa hemat Rp 186.000 per bulan.',
                        style: TextStyle(
                          fontSize: 9.5,
                          height: 1.5,
                          color: AppColors.inkSoft,
                        ),
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

const _weekBars = [0.35, 0.58, 0.42, 0.76, 0.5, 1.0, 0.68];
const _weekLabels = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.category});

  final ({
    String label,
    String amount,
    double percent,
    IconData icon,
    Color color,
  })
  category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(category.icon, size: 17, color: category.color),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.label,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${(category.percent * 100).round()}% dari total',
                    style: const TextStyle(
                      fontSize: 8.5,
                      color: AppColors.inkMuted,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              category.amount,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: category.percent,
            minHeight: 6,
            backgroundColor: AppColors.canvas,
            valueColor: AlwaysStoppedAnimation(category.color),
          ),
        ),
      ],
    );
  }
}
