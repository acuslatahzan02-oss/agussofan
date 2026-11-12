import 'package:flutter/material.dart';

enum QuickActionType {
  transfer,
  topUp,
  scan,
  bills,
  mobileData,
  invest,
  donate,
  more,
}

enum TransactionType { incoming, outgoing }

@immutable
class QuickAction {
  const QuickAction({
    required this.type,
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final QuickActionType type;
  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
}

@immutable
class WalletTransaction {
  const WalletTransaction({
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
    required this.type,
    required this.icon,
    required this.accent,
    this.reference = 'NSP-240912-8821',
    this.method = 'NusaPay • 8821',
  });

  final String title;
  final String category;
  final String date;
  final int amount;
  final TransactionType type;
  final IconData icon;
  final Color accent;
  final String reference;
  final String method;

  bool get isIncoming => type == TransactionType.incoming;
}

@immutable
class Promo {
  const Promo({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.cta,
    required this.icon,
    required this.colors,
    required this.ink,
    required this.terms,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final String cta;
  final IconData icon;
  final List<Color> colors;
  final Color ink;
  final List<String> terms;
}

@immutable
class AppNotification {
  const AppNotification({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.accent,
    this.read = false,
  });

  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color accent;
  final bool read;

  AppNotification copyWith({bool? read}) {
    return AppNotification(
      title: title,
      message: message,
      time: time,
      icon: icon,
      accent: accent,
      read: read ?? this.read,
    );
  }
}
