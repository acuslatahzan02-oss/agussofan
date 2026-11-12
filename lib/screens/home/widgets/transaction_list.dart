import 'package:flutter/material.dart';

import '../../../models/wallet_models.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/formatters.dart';

class TransactionListCard extends StatelessWidget {
  const TransactionListCard({
    super.key,
    required this.transactions,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
  });

  final List<WalletTransaction> transactions;
  final ValueChanged<WalletTransaction> onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line.withValues(alpha: 0.8)),
      ),
      padding: padding,
      child: Column(
        children: [
          for (var i = 0; i < transactions.length; i++) ...[
            TransactionTile(
              transaction: transactions[i],
              onTap: () => onTap(transactions[i]),
            ),
            if (i != transactions.length - 1)
              const Padding(
                padding: EdgeInsets.only(left: 56),
                child: Divider(height: 1),
              ),
          ],
        ],
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  final WalletTransaction transaction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final amountColor = transaction.isIncoming
        ? AppColors.brand
        : AppColors.ink;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: transaction.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                transaction.icon,
                size: 20,
                color: transaction.accent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${transaction.category} • ${transaction.date}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w400,
                      color: AppColors.inkMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transaction.isIncoming ? '+' : '-'}${formatRupiah(transaction.amount)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: amountColor,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  transaction.isIncoming ? 'Diterima' : 'Berhasil',
                  style: const TextStyle(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w400,
                    color: AppColors.inkMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showTransactionDetail(
  BuildContext context,
  WalletTransaction transaction,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.ink.withValues(alpha: 0.45),
    constraints: const BoxConstraints(maxWidth: 540),
    builder: (context) => _TransactionDetailSheet(transaction: transaction),
  );
}

Future<void> showAllTransactions(
  BuildContext context,
  List<WalletTransaction> transactions,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: AppColors.ink.withValues(alpha: 0.45),
    constraints: const BoxConstraints(maxWidth: 540),
    builder: (_) {
      return _AllTransactionsSheet(
        transactions: transactions,
        hostContext: context,
      );
    },
  );
}

class _TransactionDetailSheet extends StatelessWidget {
  const _TransactionDetailSheet({required this.transaction});

  final WalletTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.line,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: transaction.accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(transaction.icon, size: 27, color: transaction.accent),
          ),
          const SizedBox(height: 14),
          Text(
            transaction.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${transaction.isIncoming ? '+' : '-'}${formatRupiah(transaction.amount)}',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
              color: transaction.isIncoming ? AppColors.brand : AppColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.brandSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  size: 12,
                  color: AppColors.brand,
                ),
                SizedBox(width: 4),
                Text(
                  'Transaksi berhasil',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.brand,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.canvas,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _DetailRow(label: 'Kategori', value: transaction.category),
                const SizedBox(height: 12),
                _DetailRow(label: 'Waktu', value: transaction.date),
                const SizedBox(height: 12),
                _DetailRow(label: 'Metode', value: transaction.method),
                const SizedBox(height: 12),
                _DetailRow(label: 'Referensi', value: transaction.reference),
                const SizedBox(height: 12),
                const _DetailRow(label: 'Biaya admin', value: 'Rp 0'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                foregroundColor: AppColors.ink,
                side: const BorderSide(color: AppColors.line),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Tutup',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AllTransactionsSheet extends StatelessWidget {
  const _AllTransactionsSheet({
    required this.transactions,
    required this.hostContext,
  });

  final List<WalletTransaction> transactions;
  final BuildContext hostContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.82,
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
            padding: const EdgeInsets.fromLTRB(22, 18, 14, 8),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Semua aktivitas',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Riwayat transaksi November 2026',
                        style: TextStyle(
                          fontSize: 10.5,
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
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
              itemCount: transactions.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return TransactionTile(
                  transaction: transaction,
                  onTap: () {
                    Navigator.of(context).pop();
                    Future<void>.delayed(Duration.zero, () {
                      if (hostContext.mounted) {
                        showTransactionDetail(hostContext, transaction);
                      }
                    });
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 82,
          child: Text(
            label,
            style: const TextStyle(fontSize: 10.5, color: AppColors.inkMuted),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
        ),
      ],
    );
  }
}
