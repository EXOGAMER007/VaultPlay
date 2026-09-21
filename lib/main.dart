import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const VaultPlayApp());
}

// root widget aplikasi VaultPlay
class VaultPlayApp extends StatelessWidget {
  const VaultPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp - konfigurasi tema dark mode dan halaman awal
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
      home: const HomePage(),
    );
  }
}
