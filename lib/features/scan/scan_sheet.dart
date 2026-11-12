import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_snackbar.dart';

Future<void> showScanSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    constraints: const BoxConstraints(maxWidth: 540),
    builder: (context) => const ScanSheet(),
  );
}

class ScanSheet extends StatefulWidget {
  const ScanSheet({super.key});

  @override
  State<ScanSheet> createState() => _ScanSheetState();
}

class _ScanSheetState extends State<ScanSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _torchOn = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openManualCode() async {
    final controller = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Kode QRIS',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Masukkan kode pembayaran',
              filled: true,
              fillColor: AppColors.canvas,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.line),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                if (!mounted) return;
                showNusaSnackBar(
                  context,
                  'Kode berhasil diproses (mode demo).',
                  icon: Icons.qr_code_2_rounded,
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 42),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Proses'),
            ),
          ],
        );
      },
    );
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.92,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A1F1B), Color(0xFF04110F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Scan QRIS',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.6,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Bayar apa saja, cukup satu pindai.',
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(13),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 330),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D2A24),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.07),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: CustomPaint(
                                  painter: _ScannerGridPainter(),
                                ),
                              ),
                            ),
                            Center(
                              child: Icon(
                                Icons.qr_code_2_rounded,
                                size: 138,
                                color: Colors.white.withValues(alpha: 0.055),
                              ),
                            ),
                            Positioned.fill(
                              child: CustomPaint(
                                painter: _ScannerCornersPainter(),
                              ),
                            ),
                            Positioned(
                              top: 14,
                              right: 14,
                              child: InkWell(
                                onTap: () {
                                  setState(() => _torchOn = !_torchOn);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: _torchOn
                                        ? AppColors.lime
                                        : Colors.white.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    _torchOn
                                        ? Icons.flashlight_on_rounded
                                        : Icons.flashlight_off_rounded,
                                    size: 19,
                                    color: _torchOn
                                        ? AppColors.brandDeep
                                        : Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                ),
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    return Align(
                                      alignment: Alignment(
                                        0,
                                        -1 + (_controller.value * 2),
                                      ),
                                      child: child,
                                    );
                                  },
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          AppColors.lime.withValues(alpha: 0.9),
                                          Colors.transparent,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.lime.withValues(
                                            alpha: 0.55,
                                          ),
                                          blurRadius: 14,
                                          spreadRadius: 2,
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
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.lime,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'Posisikan kode QR di dalam bingkai',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _ScanButton(
                        icon: Icons.photo_library_rounded,
                        label: 'Dari galeri',
                        onTap: () => showNusaSnackBar(
                          context,
                          'Galeri belum tersedia pada prototipe.',
                          icon: Icons.photo_library_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _ScanButton(
                        icon: Icons.keyboard_rounded,
                        label: 'Kode manual',
                        onTap: _openManualCode,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanButton extends StatelessWidget {
  const _ScanButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 17, color: Colors.white.withValues(alpha: 0.85)),
              const SizedBox(width: 7),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.88),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScannerCornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.lime
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const inset = 18.0;
    const length = 36.0;
    const radius = 10.0;

    final topLeft = Path()
      ..moveTo(inset, inset + length)
      ..lineTo(inset, inset + radius)
      ..quadraticBezierTo(inset, inset, inset + radius, inset)
      ..lineTo(inset + length, inset);

    final topRight = Path()
      ..moveTo(size.width - inset - length, inset)
      ..lineTo(size.width - inset - radius, inset)
      ..quadraticBezierTo(
        size.width - inset,
        inset,
        size.width - inset,
        inset + radius,
      )
      ..lineTo(size.width - inset, inset + length);

    final bottomRight = Path()
      ..moveTo(size.width - inset, size.height - inset - length)
      ..lineTo(size.width - inset, size.height - inset - radius)
      ..quadraticBezierTo(
        size.width - inset,
        size.height - inset,
        size.width - inset - radius,
        size.height - inset,
      )
      ..lineTo(size.width - inset - length, size.height - inset);

    final bottomLeft = Path()
      ..moveTo(inset + length, size.height - inset)
      ..lineTo(inset + radius, size.height - inset)
      ..quadraticBezierTo(
        inset,
        size.height - inset,
        inset,
        size.height - inset - radius,
      )
      ..lineTo(inset, size.height - inset - length);

    for (final path in [topLeft, topRight, bottomRight, bottomLeft]) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ScannerGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..color = Colors.white.withValues(alpha: 0.055);

    const spacing = 22.0;
    for (var x = spacing; x < size.width; x += spacing) {
      for (var y = spacing; y < size.height; y += spacing) {
        final distance = math.sqrt(
          math.pow(x - size.width / 2, 2) + math.pow(y - size.height / 2, 2),
        );
        if (distance < size.width * 0.44) {
          canvas.drawCircle(Offset(x, y), 1.1, dotPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
