import 'package:flutter/material.dart';

import '../../../models/wallet_models.dart';
import '../../../theme/app_colors.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({
    super.key,
    required this.promos,
    required this.onPromoTap,
  });

  final List<Promo> promos;
  final ValueChanged<Promo> onPromoTap;

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  late final PageController _controller;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 166,
          child: PageView.builder(
            controller: _controller,
            padEnds: false,
            itemCount: widget.promos.length,
            onPageChanged: (index) => setState(() => _page = index),
            itemBuilder: (context, index) {
              final promo = widget.promos[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == widget.promos.length - 1 ? 0 : 12,
                ),
                child: PromoCard(
                  promo: promo,
                  onTap: () => widget.onPromoTap(promo),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.promos.length, (index) {
            final selected = index == _page;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: selected ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: selected ? AppColors.brand : AppColors.line,
                borderRadius: BorderRadius.circular(6),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    required this.promo,
    required this.onTap,
    this.compact = false,
  });

  final Promo promo;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ink = promo.ink;
    final isDark = ink == Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              colors: promo.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: promo.colors.first.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              children: [
                Positioned(
                  right: -22,
                  bottom: -34,
                  child: Container(
                    width: compact ? 130 : 112,
                    height: compact ? 130 : 112,
                    decoration: BoxDecoration(
                      color: ink.withValues(alpha: isDark ? 0.09 : 0.06),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: -6,
                  child: Icon(
                    promo.icon,
                    size: compact ? 74 : 62,
                    color: ink.withValues(alpha: isDark ? 0.22 : 0.14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: ink.withValues(alpha: isDark ? 0.14 : 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          promo.eyebrow,
                          style: TextStyle(
                            fontSize: 7.8,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: ink.withValues(alpha: 0.92),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        promo.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: compact ? 22 : 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.7,
                          color: ink,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.only(right: 36),
                        child: Text(
                          promo.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 9.5,
                            height: 1.45,
                            color: ink.withValues(alpha: isDark ? 0.76 : 0.68),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            promo.cta,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: ink,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: ink.withValues(
                                alpha: isDark ? 0.14 : 0.09,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 12,
                              color: ink,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
