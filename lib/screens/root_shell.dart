import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../features/money/money_sheet.dart';
import '../features/notifications/notifications_sheet.dart';
import '../features/promos/promos_sheet.dart';
import '../features/scan/scan_sheet.dart';
import '../models/wallet_models.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/nusa_bottom_nav.dart';
import 'cards/cards_screen.dart';
import 'home/home_screen.dart';
import 'insights/insights_screen.dart';
import 'profile/profile_screen.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;
  int _balance = DemoData.balance;

  Future<void> _openMoneyFlow(MoneyFlow flow) async {
    final amount = await showMoneySheet(context, flow: flow, balance: _balance);

    if (!mounted || amount == null) return;

    setState(() {
      _balance += flow == MoneyFlow.topUp ? amount : -amount;
    });

    showNusaSnackBar(
      context,
      flow == MoneyFlow.topUp
          ? 'Top up ${formatRupiah(amount)} berhasil.'
          : 'Transfer ${formatRupiah(amount)} berhasil dikirim.',
      icon: flow == MoneyFlow.topUp
          ? Icons.add_card_rounded
          : Icons.north_east_rounded,
    );
  }

  void _handleQuickAction(QuickAction action) {
    switch (action.type) {
      case QuickActionType.transfer:
        _openMoneyFlow(MoneyFlow.send);
      case QuickActionType.topUp:
        _openMoneyFlow(MoneyFlow.topUp);
      case QuickActionType.scan:
        showScanSheet(context);
      case QuickActionType.bills:
        _comingSoon('Tagihan & pembayaran');
      case QuickActionType.mobileData:
        _comingSoon('Pulsa & paket data');
      case QuickActionType.invest:
        _comingSoon('Investasi');
      case QuickActionType.donate:
        _comingSoon('Donasi');
      case QuickActionType.more:
        _comingSoon('Semua layanan');
    }
  }

  void _comingSoon(String feature) {
    showNusaSnackBar(
      context,
      '$feature akan segera hadir.',
      icon: Icons.auto_awesome_rounded,
    );
  }

  void _openTab(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        balance: _balance,
        onTopUp: () => _openMoneyFlow(MoneyFlow.topUp),
        onTransfer: () => _openMoneyFlow(MoneyFlow.send),
        onQuickAction: _handleQuickAction,
        onPromo: (promo) => showPromoDetail(context, promo),
        onSeeAllPromos: () => showPromosSheet(context, DemoData.promos),
        onNotifications: () =>
            showNotificationsSheet(context, DemoData.notifications),
        onProfile: () => _openTab(3),
      ),
      const CardsScreen(),
      const InsightsScreen(),
      ProfileScreen(
        onLogout: () {
          setState(() => _index = 0);
          showNusaSnackBar(
            context,
            'Kamu berhasil keluar (mode demo).',
            icon: Icons.logout_rounded,
          );
        },
      ),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.canvas,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: SizedBox.expand(
            child: IndexedStack(index: _index, children: pages),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 508),
            child: NusaBottomNav(
              index: _index,
              onSelect: _openTab,
              onScan: () => showScanSheet(context),
            ),
          ),
        ),
      ),
    );
  }
}
