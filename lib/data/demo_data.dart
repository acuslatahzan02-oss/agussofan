import 'package:flutter/material.dart';

import '../models/wallet_models.dart';
import '../theme/app_colors.dart';

/// Data contoh untuk keperluan prototipe UI.
abstract final class DemoData {
  static const userName = 'Raka Pratama';
  static const firstName = 'Raka';
  static const email = 'raka.pratama@mail.com';
  static const accountNumber = '8821';
  static const balance = 12480000;
  static const monthlyIncome = 8950000;
  static const monthlyExpense = 739000;
  static const points = 2480;

  static const quickActions = <QuickAction>[
    QuickAction(
      type: QuickActionType.transfer,
      label: 'Transfer',
      icon: Icons.north_east_rounded,
      background: AppColors.brandSoft,
      foreground: AppColors.brand,
    ),
    QuickAction(
      type: QuickActionType.topUp,
      label: 'Top Up',
      icon: Icons.add_card_rounded,
      background: AppColors.amberSoft,
      foreground: AppColors.amberDeep,
    ),
    QuickAction(
      type: QuickActionType.scan,
      label: 'Scan QR',
      icon: Icons.qr_code_scanner_rounded,
      background: AppColors.lavenderSoft,
      foreground: AppColors.lavender,
    ),
    QuickAction(
      type: QuickActionType.bills,
      label: 'Tagihan',
      icon: Icons.receipt_long_rounded,
      background: AppColors.coralSoft,
      foreground: AppColors.coralDeep,
    ),
    QuickAction(
      type: QuickActionType.mobileData,
      label: 'Pulsa',
      icon: Icons.smartphone_rounded,
      background: AppColors.skySoft,
      foreground: AppColors.sky,
    ),
    QuickAction(
      type: QuickActionType.invest,
      label: 'Investasi',
      icon: Icons.show_chart_rounded,
      background: AppColors.limeSoft,
      foreground: AppColors.limeDeep,
    ),
    QuickAction(
      type: QuickActionType.donate,
      label: 'Donasi',
      icon: Icons.volunteer_activism_rounded,
      background: AppColors.roseSoft,
      foreground: AppColors.rose,
    ),
    QuickAction(
      type: QuickActionType.more,
      label: 'Semua',
      icon: Icons.grid_view_rounded,
      background: Color(0xFFECEDE9),
      foreground: AppColors.inkSoft,
    ),
  ];

  static const promos = <Promo>[
    Promo(
      eyebrow: 'SPESIAL KAMIS',
      title: 'Cashback 50%',
      subtitle: 'Ngopi di Kopi Senja pakai NusaPay, maks. Rp 25.000.',
      cta: 'Klaim promo',
      icon: Icons.local_cafe_rounded,
      colors: [Color(0xFF0F4A40), Color(0xFF1B6B5B)],
      ink: Colors.white,
      terms: [
        'Berlaku setiap Kamis hingga 31 Desember 2026.',
        'Maksimal cashback Rp 25.000 per transaksi.',
        'Kuota terbatas untuk 500 transaksi pertama setiap minggu.',
      ],
    ),
    Promo(
      eyebrow: 'TABUNGAN',
      title: 'Bunga 6% p.a.',
      subtitle: 'Tabungan Impian tanpa biaya admin dan setoran awal.',
      cta: 'Mulai nabung',
      icon: Icons.savings_rounded,
      colors: [Color(0xFFFF8A65), Color(0xFFF06A43)],
      ink: Colors.white,
      terms: [
        'Suku bunga berlaku untuk saldo hingga Rp 50.000.000.',
        'Bunga dihitung harian dan dibayarkan setiap bulan.',
        'Setoran awal mulai dari Rp 10.000.',
      ],
    ),
    Promo(
      eyebrow: 'BEBAS BIAYA',
      title: 'Transfer gratis',
      subtitle: 'Kirim uang ke semua bank, sepuasnya tanpa biaya admin.',
      cta: 'Coba sekarang',
      icon: Icons.swap_horiz_rounded,
      colors: [Color(0xFFEDE8FF), Color(0xFFD9CEFF)],
      ink: AppColors.ink,
      terms: [
        'Gratis biaya transfer ke seluruh bank di Indonesia.',
        'Maksimal 20 transaksi gratis per bulan.',
        'Berlaku untuk pengguna terverifikasi.',
      ],
    ),
  ];

  static const transactions = <WalletTransaction>[
    WalletTransaction(
      title: 'Kopi Senja',
      category: 'Makanan & minuman',
      date: 'Hari ini, 08:42',
      amount: 28000,
      type: TransactionType.outgoing,
      icon: Icons.local_cafe_rounded,
      accent: AppColors.coralDeep,
      reference: 'NSP-1211-0821',
    ),
    WalletTransaction(
      title: 'Gaji November',
      category: 'Pemasukan',
      date: 'Hari ini, 07:10',
      amount: 8500000,
      type: TransactionType.incoming,
      icon: Icons.account_balance_rounded,
      accent: AppColors.brand,
      reference: 'NSP-1211-0710',
      method: 'PT Nusantara Digital',
    ),
    WalletTransaction(
      title: 'Tokopedia',
      category: 'Belanja',
      date: 'Kemarin, 19:22',
      amount: 325000,
      type: TransactionType.outgoing,
      icon: Icons.shopping_bag_rounded,
      accent: AppColors.lavender,
      reference: 'NSP-1111-1922',
    ),
    WalletTransaction(
      title: 'Dinda Ayu',
      category: 'Transfer masuk',
      date: 'Kemarin, 14:05',
      amount: 450000,
      type: TransactionType.incoming,
      icon: Icons.south_west_rounded,
      accent: AppColors.brand,
      reference: 'NSP-1111-1405',
    ),
    WalletTransaction(
      title: 'Netflix',
      category: 'Hiburan',
      date: '10 Nov, 21:00',
      amount: 186000,
      type: TransactionType.outgoing,
      icon: Icons.play_circle_fill_rounded,
      accent: AppColors.sky,
      reference: 'NSP-1011-2100',
    ),
    WalletTransaction(
      title: 'Token Listrik PLN',
      category: 'Tagihan',
      date: '09 Nov, 09:15',
      amount: 200000,
      type: TransactionType.outgoing,
      icon: Icons.bolt_rounded,
      accent: AppColors.amberDeep,
      reference: 'NSP-0911-0915',
    ),
  ];

  static const notifications = <AppNotification>[
    AppNotification(
      title: 'Transfer berhasil',
      message: 'Rp 450.000 dari Dinda Ayu sudah masuk ke saldo kamu.',
      time: '14:05',
      icon: Icons.south_west_rounded,
      accent: AppColors.brand,
      read: true,
    ),
    AppNotification(
      title: 'Cashback masuk',
      message: 'Cashback Rp 14.000 dari Kopi Senja telah ditambahkan.',
      time: '08:45',
      icon: Icons.local_offer_rounded,
      accent: AppColors.coralDeep,
    ),
    AppNotification(
      title: 'Promo spesial untukmu',
      message: 'Nikmati bunga 6% p.a. untuk Tabungan Impian. Cek sekarang!',
      time: 'Kemarin',
      icon: Icons.savings_rounded,
      accent: AppColors.lavender,
    ),
    AppNotification(
      title: 'Keamanan akun',
      message: 'Perangkat baru berhasil masuk ke akun NusaPay kamu.',
      time: '10 Nov',
      icon: Icons.shield_rounded,
      accent: AppColors.amberDeep,
      read: true,
    ),
  ];
}
