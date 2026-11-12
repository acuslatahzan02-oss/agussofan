import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusapay/app.dart';

void main() {
  testWidgets('layout aman pada layar kecil 320x568', (tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const NusaPayApp());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final list = find.byType(Scrollable).first;
    await tester.drag(list, const Offset(0, -1000));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Kartu'));
    await tester.pumpAndSettle();
    expect(find.text('Limit harian'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Insight'));
    await tester.pumpAndSettle();
    expect(find.text('Kategori pengeluaran'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();
    expect(find.text('Pengaturan akun'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('layout aman pada layar 430x932', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const NusaPayApp());
    await tester.pumpAndSettle();

    expect(find.text('Promo buat kamu'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Aktivitas terakhir'),
      240,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Aktivitas terakhir'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('alur transfer mengubah saldo', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const NusaPayApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Transfer').first);
    await tester.pumpAndSettle();

    expect(find.text('Kirim uang'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'Dinda Ayu');
    await tester.enterText(find.byType(TextField).at(1), '100000');
    await tester.pump();

    final submit = find.text('Lanjutkan transfer');
    await tester.ensureVisible(submit);
    await tester.pumpAndSettle();
    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(find.text('Rp 12.380.000'), findsOneWidget);
    expect(find.text('Transfer Rp 100.000 berhasil dikirim.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
