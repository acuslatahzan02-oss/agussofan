import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Snackbar konsisten yang dipakai di seluruh aplikasi.
void showNusaSnackBar(
  BuildContext context,
  String message, {
  IconData icon = Icons.check_circle_rounded,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 96),
        backgroundColor: AppColors.ink,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Row(
          children: [
            Icon(icon, color: AppColors.lime, size: 19),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
}
