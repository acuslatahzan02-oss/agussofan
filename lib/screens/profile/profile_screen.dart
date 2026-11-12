import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.onLogout});

  final VoidCallback onLogout;

  void _notify(BuildContext context, String message, IconData icon) {
    showNusaSnackBar(context, message, icon: icon);
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Keluar dari NusaPay?',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          content: const Text(
            'Kamu bisa masuk kembali kapan saja menggunakan nomor terdaftar.',
            style: TextStyle(
              fontSize: 11,
              height: 1.55,
              color: AppColors.inkSoft,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              style: TextButton.styleFrom(foregroundColor: AppColors.inkSoft),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 42),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                backgroundColor: AppColors.danger,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      onLogout();
    }
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
            title: 'Profil',
            subtitle: 'Atur akun, keamanan, dan preferensi kamu.',
            trailing: InkWell(
              onTap: () => _notify(
                context,
                'Pengaturan akun dibuka.',
                Icons.settings_rounded,
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
                child: const Icon(Icons.settings_rounded, size: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.line.withValues(alpha: 0.8)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFDCEBE4), Color(0xFFBFDCD0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Text(
                        'RP',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brand,
                        ),
                      ),
                    ),
                    const SizedBox(width: 13),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  DemoData.userName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.verified_rounded,
                                size: 14,
                                color: AppColors.brand,
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Text(
                            DemoData.email,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 9.5,
                              color: AppColors.inkSoft,
                            ),
                          ),
                          SizedBox(height: 6),
                          _VerifiedPill(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => _notify(
                        context,
                        'Edit profil dibuka.',
                        Icons.edit_rounded,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.canvas,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.edit_rounded, size: 16),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: _ProfileStat(label: 'Level', value: 'Gold'),
                    ),
                    _VerticalDivider(),
                    Expanded(
                      child: _ProfileStat(
                        label: 'Poin',
                        value: '${DemoData.points}',
                      ),
                    ),
                    _VerticalDivider(),
                    Expanded(
                      child: _ProfileStat(label: 'Promo', value: '12'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Pengaturan akun'),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.line.withValues(alpha: 0.8)),
            ),
            child: Column(
              children: [
                _ProfileMenuTile(
                  icon: Icons.shield_rounded,
                  label: 'Keamanan & privasi',
                  description: 'PIN, biometrik, dan perangkat',
                  onTap: () => _notify(
                    context,
                    'Pengaturan keamanan dibuka.',
                    Icons.shield_rounded,
                  ),
                ),
                const _MenuDivider(),
                _ProfileMenuTile(
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'Metode pembayaran',
                  description: '2 rekening tersimpan',
                  onTap: () => _notify(
                    context,
                    'Metode pembayaran dibuka.',
                    Icons.account_balance_wallet_rounded,
                  ),
                ),
                const _MenuDivider(),
                _ProfileMenuTile(
                  icon: Icons.notifications_rounded,
                  label: 'Notifikasi',
                  description: 'Email dan push notification',
                  onTap: () => _notify(
                    context,
                    'Preferensi notifikasi dibuka.',
                    Icons.notifications_rounded,
                  ),
                ),
                const _MenuDivider(),
                _ProfileMenuTile(
                  icon: Icons.help_rounded,
                  label: 'Bantuan & dukungan',
                  description: 'FAQ dan hubungi customer service',
                  onTap: () => _notify(
                    context,
                    'Pusat bantuan dibuka.',
                    Icons.help_rounded,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => _confirmLogout(context),
            icon: const Icon(Icons.logout_rounded, size: 17),
            label: const Text('Keluar dari akun'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              foregroundColor: AppColors.danger,
              side: BorderSide(color: AppColors.danger.withValues(alpha: 0.25)),
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              textStyle: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'NusaPay v1.0.0  •  Dibuat dengan Flutter',
              style: TextStyle(fontSize: 8.5, color: AppColors.inkMuted),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerifiedPill extends StatelessWidget {
  const _VerifiedPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.brandSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, size: 9, color: AppColors.brand),
          SizedBox(width: 3),
          Text(
            'Terverifikasi',
            style: TextStyle(
              fontSize: 7.5,
              fontWeight: FontWeight.w600,
              color: AppColors.brand,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 8.5, color: AppColors.inkMuted),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 28, color: AppColors.line);
  }
}

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.canvas,
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
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 8.5,
                      color: AppColors.inkMuted,
                    ),
                  ),
                ],
              ),
            ),
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

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 62),
      child: Divider(height: 1),
    );
  }
}
