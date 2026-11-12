import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusapay/app.dart';

void main() {
  testWidgets('halaman utama NusaPay tampil dengan baik', (tester) async {
    await tester.pumpWidget(const NusaPayApp());
    await tester.pump();

    expect(find.text('nusapay.'), findsOneWidget);
    expect(find.textContaining('Raka', findRichText: true), findsWidgets);
    expect(find.text('Top Up'), findsWidgets);
    expect(find.text('Transfer'), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('Promo buat kamu'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Promo buat kamu'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Aktivitas terakhir'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Aktivitas terakhir'), findsOneWidget);
  });

  testWidgets('tombol mata menyembunyikan saldo', (tester) async {
    await tester.pumpWidget(const NusaPayApp());
    await tester.pump();

    expect(find.text('Rp 12.480.000'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Sembunyikan saldo'));
    await tester.pumpAndSettle();

    expect(find.text('Rp 12.480.000'), findsNothing);
    expect(find.text('••••••'), findsOneWidget);
  });

  testWidgets('bottom navigation membuka tab kartu', (tester) async {
    await tester.pumpWidget(const NusaPayApp());
    await tester.pump();

    await tester.tap(find.text('Kartu'));
    await tester.pumpAndSettle();

    expect(
      find.text('Kelola kartu, limit, dan keamanan transaksi.'),
      findsOneWidget,
    );
    expect(find.text('Limit harian'), findsOneWidget);
  });
}
