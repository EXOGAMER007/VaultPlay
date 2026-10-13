import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_navigation.dart';
import 'providers/game_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  // MultiProvider - soalnya sekarang provider-nya ada 2 (game sama tema)
  // jadi dipasang barengan di paling atas biar semua halaman bisa akses
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const VaultPlayApp(),
    ),
  );
}

// root widget aplikasi VaultPlay
class VaultPlayApp extends StatelessWidget {
  const VaultPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    // watch ThemeProvider biar MaterialApp rebuild pas tema diganti
    final themeProvider = context.watch<ThemeProvider>();

    // MaterialApp - tema diambil dari ThemeProvider, halaman awal ke MainNavigation
    return MaterialApp(
      title: 'VaultPlay',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme,
      home: const MainNavigation(),
    );
  }
}
