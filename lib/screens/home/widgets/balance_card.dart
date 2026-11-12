import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/demo_data.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/formatters.dart';
import '../../../widgets/app_snackbar.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({
    super.key,
    required this.balance,
    required this.onTopUp,
    required this.onTransfer,
  });

  final int balance;
  final VoidCallback onTopUp;
  final VoidCallback onTransfer;

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _hidden = false;

  Future<void> _copyAccountNumber() async {
    await Clipboard.setData(
      const ClipboardData(text: '0888 0100 ${DemoData.accountNumber}'),
    );
    if (!mounted) return;
    showNusaSnackBar(
      context,
      'Nomor NusaPay berhasil disalin',
      icon: Icons.copy_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 236,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF072E29), Color(0xFF0F4A40), Color(0xFF196254)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.55, 1],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandDeep.withValues(alpha: 0.28),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            const Positioned.fill(child: CustomPaint(painter: _CardPattern())),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.09),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.lime,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Saldo aktif',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.82),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Semantics(
                        button: true,
                        label: _hidden
                            ? 'Tampilkan saldo'
                            : 'Sembunyikan saldo',
                        child: InkWell(
                          onTap: () => setState(() => _hidden = !_hidden),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _hidden
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              size: 17,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.18),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: FittedBox(
                            key: ValueKey(_hidden),
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _hidden ? '••••••' : formatRupiah(widget.balance),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -1.4,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lime.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.trending_up_rounded,
                              size: 12,
                              color: AppColors.lime,
                            ),
                            SizedBox(width: 3),
                            Text(
                              '12,4%',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lime,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'NusaPay • ${DemoData.accountNumber}',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.58),
                        ),
                      ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: _copyAccountNumber,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Icon(
                            Icons.copy_rounded,
                            size: 12.5,
                            color: Colors.white.withValues(alpha: 0.58),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: _CardButton(
                          label: 'Top Up',
                          icon: Icons.add_rounded,
                          filled: true,
                          onTap: widget.onTopUp,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _CardButton(
                          label: 'Transfer',
                          icon: Icons.north_east_rounded,
                          onTap: widget.onTransfer,
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
    );
  }
}

class _CardButton extends StatelessWidget {
  const _CardButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final foreground = filled ? AppColors.brandDeep : Colors.white;
    return Material(
      color: filled ? AppColors.lime : Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: filled
                ? null
                : Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 17, color: foreground),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: foreground,
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

class _CardPattern extends CustomPainter {
  const _CardPattern();

  @override
  void paint(Canvas canvas, Size size) {
    final softWhite = Paint()..color = Colors.white.withValues(alpha: 0.045);
    final lime = Paint()..color = AppColors.lime.withValues(alpha: 0.06);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white.withValues(alpha: 0.075);

    canvas.drawCircle(Offset(size.width * 0.9, -18), 105, softWhite);
    canvas.drawCircle(Offset(size.width * 1.02, size.height * 0.7), 78, lime);
    canvas.drawCircle(
      Offset(size.width * 0.86, size.height * 0.92),
      118,
      stroke,
    );
    canvas.drawCircle(
      Offset(size.width * 0.86, size.height * 0.92),
      92,
      stroke,
    );

    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset(22 + (i * 9), size.height - 20),
        1.4,
        Paint()..color = Colors.white.withValues(alpha: 0.2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
