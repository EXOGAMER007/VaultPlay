import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_navigation.dart';
import 'providers/game_provider.dart';

void main() {
  // ChangeNotifierProvider (package provider) - masang GameProvider di paling atas
  // biar semua halaman di bawahnya bisa baca & ubah data game yg sama
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: const VaultPlayApp(),
    ),
  );
}

// root widget aplikasi VaultPlay
class VaultPlayApp extends StatelessWidget {
  const VaultPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp - konfigurasi tema dark mode dan halaman awal aplikasi
    return MaterialApp(
      title: 'VaultPlay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF11141E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // halaman awal diarahkan ke MainNavigation yang mengelola BottomNavigationBar
      home: const MainNavigation(),
    );
  }
}
