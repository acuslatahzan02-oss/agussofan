import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../utils/formatters.dart';

enum MoneyFlow { send, topUp }

Future<int?> showMoneySheet(
  BuildContext context, {
  required MoneyFlow flow,
  required int balance,
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.ink.withValues(alpha: 0.45),
    constraints: const BoxConstraints(maxWidth: 540),
    builder: (context) => MoneySheet(flow: flow, balance: balance),
  );
}

class MoneySheet extends StatefulWidget {
  const MoneySheet({super.key, required this.flow, required this.balance});

  final MoneyFlow flow;
  final int balance;

  @override
  State<MoneySheet> createState() => _MoneySheetState();
}

class _MoneySheetState extends State<MoneySheet> {
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  final _noteController = TextEditingController();
  String? _error;

  static const _quickAmounts = [50000, 100000, 250000, 500000, 1000000];
  static const _contacts = ['Dinda Ayu', 'Bagas Wijaya', 'Sinta Maharani'];

  bool get _isSend => widget.flow == MoneyFlow.send;

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  int get _amount {
    final digits = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }

  void _setAmount(int amount) {
    _amountController.text = formatRupiah(amount, withSymbol: false);
    _amountController.selection = TextSelection.collapsed(
      offset: _amountController.text.length,
    );
    setState(() => _error = null);
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_amount < 10000) {
      setState(() => _error = 'Minimal transaksi adalah Rp 10.000.');
      return;
    }
    if (_isSend && _recipientController.text.trim().isEmpty) {
      setState(() => _error = 'Nama atau nomor penerima wajib diisi.');
      return;
    }
    if (_isSend && _amount > widget.balance) {
      setState(() => _error = 'Saldo kamu tidak cukup untuk transaksi ini.');
      return;
    }
    Navigator.of(context).pop(_amount);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.92,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isSend ? 'Kirim uang' : 'Top up saldo',
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.7,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Saldo saat ini ${formatRupiah(widget.balance)}',
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: AppColors.inkSoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.canvas,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.close_rounded, size: 19),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              if (_isSend) ...[
                const _FieldLabel('Penerima'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final contact in _contacts)
                      _ContactChip(
                        name: contact,
                        selected: _recipientController.text.trim() == contact,
                        onTap: () {
                          setState(() {
                            _recipientController.text = contact;
                            _error = null;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                _SheetTextField(
                  controller: _recipientController,
                  hint: 'Nama atau nomor NusaPay',
                  icon: Icons.person_search_rounded,
                  keyboardType: TextInputType.text,
                  onChanged: (_) {
                    if (_error != null) setState(() => _error = null);
                  },
                ),
                const SizedBox(height: 18),
              ],
              const _FieldLabel('Nominal'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.canvas,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: _error != null && _amount < 10000
                        ? AppColors.coral
                        : AppColors.line,
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Rp',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.inkSoft,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [RupiahInputFormatter()],
                        onChanged: (_) {
                          if (_error != null) {
                            setState(() => _error = null);
                          } else {
                            setState(() {});
                          }
                        },
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.2,
                          height: 1.35,
                        ),
                        decoration: const InputDecoration(
                          hintText: '0',
                          hintStyle: TextStyle(
                            color: AppColors.inkMuted,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final amount in _quickAmounts)
                    _AmountChip(
                      label: _shortAmount(amount),
                      selected: _amount == amount,
                      onTap: () => _setAmount(amount),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              if (!_isSend) ...[
                const _FieldLabel('Sumber dana'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.canvas,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.line),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.account_balance_rounded,
                          size: 19,
                          color: AppColors.brand,
                        ),
                      ),
                      const SizedBox(width: 11),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Central Asia',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Tahapan •••• 0912',
                              style: TextStyle(
                                fontSize: 9.5,
                                color: AppColors.inkSoft,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: AppColors.inkSoft,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
              ],
              const _FieldLabel('Catatan (opsional)'),
              const SizedBox(height: 8),
              _SheetTextField(
                controller: _noteController,
                hint: _isSend
                    ? 'Contoh: buat kopi sore'
                    : 'Contoh: top up bulanan',
                icon: Icons.edit_note_rounded,
                maxLength: 40,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.brandSoft.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.bolt_rounded, size: 16, color: AppColors.brand),
                    SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        'Proses instan 24/7 • Bebas biaya admin',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.brand,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      size: 14,
                      color: AppColors.danger,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        _error!,
                        style: const TextStyle(
                          fontSize: 9.5,
                          color: AppColors.danger,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 18),
              FilledButton(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.brand,
                  minimumSize: const Size.fromHeight(54),
                ),
                child: Text(_isSend ? 'Lanjutkan transfer' : 'Top up sekarang'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _shortAmount(int value) {
    if (value >= 1000000) return '${value ~/ 1000000} jt';
    return '${value ~/ 1000} rb';
  }
}

class _SheetTextField extends StatelessWidget {
  const _SheetTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.maxLength,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        counterText: '',
        hintStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: AppColors.inkMuted,
        ),
        prefixIcon: Icon(icon, size: 18, color: AppColors.inkSoft),
        filled: true,
        fillColor: AppColors.canvas,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.brand, width: 1.4),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.w600,
        color: AppColors.inkSoft,
        letterSpacing: 0.1,
      ),
    );
  }
}

class _ContactChip extends StatelessWidget {
  const _ContactChip({
    required this.name,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(' ')
        .take(2)
        .map((word) => word.substring(0, 1))
        .join();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.brandSoft : AppColors.canvas,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.brand : AppColors.line,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: Text(
                initials,
                style: const TextStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.brand,
                ),
              ),
            ),
            const SizedBox(width: 7),
            Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: selected ? AppColors.brand : AppColors.inkSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountChip extends StatelessWidget {
  const _AmountChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.brand : AppColors.canvas,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.brand : AppColors.line,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.inkSoft,
          ),
        ),
      ),
    );
  }
}
