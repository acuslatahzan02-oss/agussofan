import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../models/wallet_models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/section_header.dart';
import 'widgets/balance_card.dart';
import 'widgets/home_header.dart';
import 'widgets/promo_carousel.dart';
import 'widgets/quick_action_grid.dart';
import 'widgets/security_banner.dart';
import 'widgets/transaction_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.balance,
    required this.onTopUp,
    required this.onTransfer,
    required this.onQuickAction,
    required this.onPromo,
    required this.onSeeAllPromos,
    required this.onNotifications,
    required this.onProfile,
  });

  final int balance;
  final VoidCallback onTopUp;
  final VoidCallback onTransfer;
  final ValueChanged<QuickAction> onQuickAction;
  final ValueChanged<Promo> onPromo;
  final VoidCallback onSeeAllPromos;
  final VoidCallback onNotifications;
  final VoidCallback onProfile;

  Future<void> _refresh(BuildContext context) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!context.mounted) return;
    showNusaSnackBar(
      context,
      'Saldo dan aktivitas sudah diperbarui.',
      icon: Icons.refresh_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -160,
          right: -90,
          child: IgnorePointer(
            child: Container(
              width: 330,
              height: 330,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.brandSoft.withValues(alpha: 0.9),
                    AppColors.brandSoft.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 320,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFEAF2EC).withValues(alpha: 0.75),
                    AppColors.canvas.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: RefreshIndicator(
            color: AppColors.brand,
            backgroundColor: AppColors.surface,
            edgeOffset: 12,
            onRefresh: () => _refresh(context),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 132),
              children: [
                HomeHeader(
                  onNotifications: onNotifications,
                  onProfile: onProfile,
                ),
                const SizedBox(height: 22),
                BalanceCard(
                  balance: balance,
                  onTopUp: onTopUp,
                  onTransfer: onTransfer,
                ),
                const SizedBox(height: 20),
                QuickActionGrid(
                  actions: DemoData.quickActions,
                  onSelected: onQuickAction,
                ),
                const SizedBox(height: 24),
                SectionHeader(
                  title: 'Promo buat kamu',
                  actionLabel: 'Lihat semua',
                  onAction: onSeeAllPromos,
                ),
                const SizedBox(height: 12),
                PromoCarousel(promos: DemoData.promos, onPromoTap: onPromo),
                const SizedBox(height: 24),
                SectionHeader(
                  title: 'Aktivitas terakhir',
                  actionLabel: 'Lihat semua',
                  onAction: () =>
                      showAllTransactions(context, DemoData.transactions),
                ),
                const SizedBox(height: 12),
                TransactionListCard(
                  transactions: DemoData.transactions.take(5).toList(),
                  onTap: (transaction) =>
                      showTransactionDetail(context, transaction),
                ),
                const SizedBox(height: 16),
                SecurityBanner(
                  onTap: () => showNusaSnackBar(
                    context,
                    'Saldo kamu terlindungi LPS hingga Rp 2 miliar.',
                    icon: Icons.verified_user_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
