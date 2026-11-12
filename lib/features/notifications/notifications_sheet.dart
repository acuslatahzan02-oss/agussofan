import 'package:flutter/material.dart';

import '../../models/wallet_models.dart';
import '../../theme/app_colors.dart';

Future<void> showNotificationsSheet(
  BuildContext context,
  List<AppNotification> notifications,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.ink.withValues(alpha: 0.45),
    constraints: const BoxConstraints(maxWidth: 540),
    builder: (context) => NotificationsSheet(notifications: notifications),
  );
}

class NotificationsSheet extends StatefulWidget {
  const NotificationsSheet({super.key, required this.notifications});

  final List<AppNotification> notifications;

  @override
  State<NotificationsSheet> createState() => _NotificationsSheetState();
}

class _NotificationsSheetState extends State<NotificationsSheet> {
  late List<AppNotification> _items;

  @override
  void initState() {
    super.initState();
    _items = List.of(widget.notifications);
  }

  int get _unreadCount => _items.where((item) => !item.read).length;

  void _markAllRead() {
    setState(() {
      _items = _items.map((item) => item.copyWith(read: true)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.74,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.line,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 10, 6),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Notifikasi',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                          ),
                          if (_unreadCount > 0) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.coralSoft,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$_unreadCount baru',
                                style: const TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.coralDeep,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Kabar terbaru seputar akun dan promo kamu.',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: _unreadCount == 0 ? null : _markAllRead,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.brand,
                    textStyle: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Tandai semua dibaca'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(18, 2, 18, 28),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = _items[index];
                return _NotificationTile(
                  notification: item,
                  onTap: () {
                    if (!item.read) {
                      setState(() {
                        _items[index] = item.copyWith(read: true);
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.onTap});

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: notification.read
              ? AppColors.canvas.withValues(alpha: 0.55)
              : AppColors.brandSoft.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: notification.read
                ? AppColors.line.withValues(alpha: 0.7)
                : AppColors.brand.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: notification.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                notification.icon,
                size: 18,
                color: notification.accent,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: notification.read
                                ? FontWeight.w500
                                : FontWeight.w600,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        notification.time,
                        style: const TextStyle(
                          fontSize: 8.5,
                          color: AppColors.inkMuted,
                        ),
                      ),
                      if (!notification.read) ...[
                        const SizedBox(width: 6),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.coral,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: const TextStyle(
                      fontSize: 9.5,
                      height: 1.5,
                      color: AppColors.inkSoft,
                    ),
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
