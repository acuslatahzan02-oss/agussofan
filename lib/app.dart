import 'package:flutter/material.dart';

import 'screens/root_shell.dart';
import 'theme/app_theme.dart';

class NusaPayApp extends StatelessWidget {
  const NusaPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaPay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RootShell(),
    );
  }
}
