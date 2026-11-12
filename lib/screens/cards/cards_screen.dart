import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/section_header.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  bool _frozen = false;

  void _notify(String message, IconData icon) {
    showNusaSnackBar(context, message, icon: icon);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 132),
        children: [
          PageHeader(
            title: 'Kartu',
            subtitle: 'Kelola kartu, limit, dan keamanan transaksi.',
            trailing: InkWell(
              onTap: () => _notify(
                'Fitur tambah kartu akan segera hadir.',
                Icons.add_card_rounded,
              ),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.line),
                ),
                child: const Icon(Icons.add_rounded, size: 21),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _VirtualCard(frozen: _frozen),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _CardQuickAction(
                  icon: Icons.tune_rounded,
                  label: 'Atur limit',
                  onTap: () => _notify(
                    'Pengaturan limit kartu dibuka.',
                    Icons.tune_rounded,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CardQuickAction(
                  icon: _frozen
                      ? Icons.lock_open_rounded
                      : Icons.ac_unit_rounded,
                  label: _frozen ? 'Aktifkan' : 'Bekukan',
                  active: _frozen,
                  onTap: () {
                    setState(() => _frozen = !_frozen);
                    _notify(
                      _frozen
                          ? 'Kartu berhasil dibekukan sementara.'
                          : 'Kartu kamu sudah aktif kembali.',
                      _frozen
                          ? Icons.ac_unit_rounded
                          : Icons.check_circle_rounded,
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CardQuickAction(
                  icon: Icons.visibility_rounded,
                  label: 'Detail',
                  onTap: () => _notify(
                    'Nomor kartu disalin ke clipboard.',
                    Icons.copy_rounded,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.line.withValues(alpha: 0.8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Limit harian',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2,
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
                      child: const Text(
                        '65% terpakai',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.brand,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Rp 6.500.000',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
                const Text(
                  'dari total limit Rp 10.000.000',
                  style: TextStyle(fontSize: 10, color: AppColors.inkSoft),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 8,
                    backgroundColor: AppColors.canvas,
                    valueColor: const AlwaysStoppedAnimation(AppColors.brand),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 13,
                      color: AppColors.inkMuted,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Sisa limit hari ini Rp 3.500.000',
                        style: TextStyle(
                          fontSize: 9.5,
                          color: AppColors.inkMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Kelola kartu'),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.line.withValues(alpha: 0.8)),
            ),
            child: Column(
              children: [
                _MenuTile(
                  icon: Icons.pin_rounded,
                  label: 'Ubah PIN kartu',
                  description: 'Terakhir diubah 3 bulan lalu',
                  onTap: () =>
                      _notify('Alur ubah PIN dibuka.', Icons.pin_rounded),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 58),
                  child: Divider(height: 1),
                ),
                _MenuTile(
                  icon: Icons.local_shipping_rounded,
                  label: 'Kartu fisik',
                  description: 'Dalam pengiriman • estimasi 2 hari',
                  badge: 'Dikirim',
                  onTap: () => _notify(
                    'Lacak pengiriman kartu fisik.',
                    Icons.local_shipping_rounded,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 58),
                  child: Divider(height: 1),
                ),
                _MenuTile(
                  icon: Icons.contactless_rounded,
                  label: 'Pembayaran nirsentuh',
                  description: 'Aktif untuk transaksi di mesin EDC',
                  badge: 'Aktif',
                  onTap: () => _notify(
                    'Pengaturan pembayaran nirsentuh dibuka.',
                    Icons.contactless_rounded,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => _notify(
              'Fitur tambah kartu baru akan segera hadir.',
              Icons.add_rounded,
            ),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('Tambah kartu baru'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              foregroundColor: AppColors.brand,
              side: const BorderSide(color: AppColors.line),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VirtualCard extends StatelessWidget {
  const _VirtualCard({required this.frozen});

  final bool frozen;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.62,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [Color(0xFF0A312B), Color(0xFF145548), Color(0xFF1E6C5B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandDeep.withValues(alpha: 0.3),
              blurRadius: 26,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              Positioned(
                right: -40,
                top: -50,
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
              Positioned(
                right: -20,
                bottom: -70,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lime.withValues(alpha: 0.07),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'nusapay',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.7,
                                ),
                              ),
                              TextSpan(
                                text: '.',
                                style: TextStyle(
                                  color: AppColors.lime.withValues(alpha: 0.9),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            frozen ? 'DIBEKUKAN' : 'DEBIT',
                            style: TextStyle(
                              fontSize: 7.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.7,
                              color: frozen
                                  ? AppColors.coral
                                  : Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.contactless_rounded,
                          size: 24,
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 38,
                          height: 27,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFE8D9A8), Color(0xFFC9AE67)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 22,
                                height: 1,
                                color: Colors.black.withValues(alpha: 0.2),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: 22,
                                height: 1,
                                color: Colors.black.withValues(alpha: 0.2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '••••  ••••  ••••  8821',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.6,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PEMILIK KARTU',
                              style: TextStyle(
                                fontSize: 6.5,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.9,
                                color: Colors.white.withValues(alpha: 0.45),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'RAKA PRATAMA',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          'VISA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            letterSpacing: -0.5,
                            color: Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (frozen)
                Positioned.fill(
                  child: Container(
                    color: AppColors.brandDeep.withValues(alpha: 0.55),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.ac_unit_rounded,
                              size: 15,
                              color: Colors.white,
                            ),
                            SizedBox(width: 7),
                            Text(
                              'Kartu dibekukan',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardQuickAction extends StatelessWidget {
  const _CardQuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: active ? AppColors.brandSoft : AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: active
                ? AppColors.brand.withValues(alpha: 0.15)
                : AppColors.line,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: active ? AppColors.brand : AppColors.inkSoft,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
                color: active ? AppColors.brand : AppColors.inkSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
    this.badge,
  });

  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.brandSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 17, color: AppColors.brand),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9,
                      color: AppColors.inkMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.limeSoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(
                    fontSize: 7.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.limeDeep,
                  ),
                ),
              ),
            ],
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: AppColors.inkMuted,
            ),
          ],
        ),
      ),
    );
  }
}
