import 'package:flutter/services.dart';

/// Format angka menjadi Rupiah, mis. 12480000 -> "Rp 12.480.000".
String formatRupiah(num value, {bool withSymbol = true}) {
  final negative = value < 0;
  final digits = value.abs().round().toString();
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[i]);
  }

  final prefix = negative ? '-' : '';
  return withSymbol ? '${prefix}Rp $buffer' : '$prefix$buffer';
}

/// Versi ringkas untuk kartu kecil, mis. 8950000 -> "8,95 jt".
String compactRupiah(num value) {
  if (value >= 1000000) {
    final result = value / 1000000;
    final text = result == result.roundToDouble()
        ? result.toStringAsFixed(0)
        : result.toStringAsFixed(2).replaceAll('.', ',');
    return 'Rp $text jt';
  }
  if (value >= 1000) {
    final result = value / 1000;
    final text = result == result.roundToDouble()
        ? result.toStringAsFixed(0)
        : result.toStringAsFixed(0);
    return 'Rp $text rb';
  }
  return formatRupiah(value);
}

String greeting([DateTime? now]) {
  final hour = (now ?? DateTime.now()).hour;
  if (hour < 11) return 'Selamat pagi';
  if (hour < 15) return 'Selamat siang';
  if (hour < 18) return 'Selamat sore';
  return 'Selamat malam';
}

const _weekdays = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];

const _months = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

String longDate(DateTime date) {
  final weekday = _weekdays[date.weekday - 1];
  final month = _months[date.month - 1];
  return '$weekday, ${date.day} $month ${date.year}';
}

/// Input formatter yang otomatis menambahkan titik ribuan.
class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final number = int.tryParse(digits) ?? 0;
    final formatted = formatRupiah(number, withSymbol: false);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
