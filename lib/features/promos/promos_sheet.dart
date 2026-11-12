import 'package:flutter/material.dart';

import '../../models/wallet_models.dart';
import '../../screens/home/widgets/promo_carousel.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_snackbar.dart';

Future<void> showPromosSheet(BuildContext context, List<Promo> promos) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.ink.withValues(alpha: 0.45),
    constraints: const BoxConstraints(maxWidth: 540),
    builder: (context) => _PromosSheet(promos: promos),
  );
}

Future<void> showPromoDetail(BuildContext context, Promo promo) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.ink.withValues(alpha: 0.45),
    constraints: const BoxConstraints(maxWidth: 540),
    builder: (context) => _PromoDetailSheet(promo: promo),
  );
}

class _PromosSheet extends StatelessWidget {
  const _PromosSheet({required this.promos});

  final List<Promo> promos;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.86,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.line,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 10, 4),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Promo buat kamu',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Pilih promo, klaim, lalu hemat di transaksi berikutnya.',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.inkSoft,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded, size: 21),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
              itemCount: promos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final promo = promos[index];
                return SizedBox(
                  height: 166,
                  child: PromoCard(
                    promo: promo,
                    onTap: () => showPromoDetail(context, promo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoDetailSheet extends StatelessWidget {
  const _PromoDetailSheet({required this.promo});

  final Promo promo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.line,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(
                  colors: promo.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Stack(
                  children: [
                    Positioned(
                      right: -26,
                      bottom: -30,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: promo.ink.withValues(alpha: 0.09),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 18,
                      bottom: 8,
                      child: Icon(
                        promo.icon,
                        size: 92,
                        color: promo.ink.withValues(alpha: 0.23),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: promo.ink.withValues(alpha: 0.13),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              promo.eyebrow,
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.9,
                                color: promo.ink.withValues(alpha: 0.9),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            promo.title,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1.1,
                              height: 1.1,
                              color: promo.ink,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(right: 70),
                            child: Text(
                              promo.subtitle,
                              style: TextStyle(
                                fontSize: 10,
                                height: 1.45,
                                color: promo.ink.withValues(alpha: 0.76),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Syarat dan ketentuan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 10),
            for (final term in promo.terms)
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: AppColors.brand,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        term,
                        style: const TextStyle(
                          fontSize: 10,
                          height: 1.55,
                          color: AppColors.inkSoft,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () {
                showNusaSnackBar(
                  context,
                  'Promo "${promo.title}" berhasil diklaim.',
                  icon: Icons.local_offer_rounded,
                );
                Navigator.of(context).pop();
              },
              child: Text(promo.cta),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.inkSoft,
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: const Text('Nanti saja'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
