import 'package:flutter/material.dart';

// model buat satu pilihan warna tema
class ThemeAccent {
  final String id;
  final String name;
  final Color primaryColor;
  final Color accentColor;
  final IconData icon;

  const ThemeAccent({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.accentColor,
    required this.icon,
  });
}

// ThemeProvider = nyimpen warna tema yg lagi dipake
// sama kayak GameProvider, extends ChangeNotifier jadi kalo tema diganti
// tinggal panggil notifyListeners() terus semua widget yg watch ikut ganti warna
class ThemeProvider extends ChangeNotifier {
  // pilihan warna yg bisa dipilih di halaman profil
  final List<ThemeAccent> _accents = const [
    ThemeAccent(
      id: 'violet',
      name: 'Ungu',
      primaryColor: Colors.deepPurple,
      accentColor: Colors.deepPurpleAccent,
      icon: Icons.auto_awesome,
    ),
    ThemeAccent(
      id: 'cyan',
      name: 'Cyan',
      primaryColor: Colors.cyan,
      accentColor: Colors.cyanAccent,
      icon: Icons.electric_bolt,
    ),
    ThemeAccent(
      id: 'green',
      name: 'Hijau',
      primaryColor: Colors.teal,
      accentColor: Colors.greenAccent,
      icon: Icons.shield,
    ),
    ThemeAccent(
      id: 'red',
      name: 'Merah',
      primaryColor: Colors.red,
      accentColor: Colors.redAccent,
      icon: Icons.local_fire_department,
    ),
    ThemeAccent(
      id: 'amber',
      name: 'Kuning',
      primaryColor: Colors.amber,
      accentColor: Colors.amberAccent,
      icon: Icons.flare,
    ),
  ];

  // default pake ungu kayak tema awal app
  late ThemeAccent _currentAccent = _accents[0];

  List<ThemeAccent> get accents => _accents;
  ThemeAccent get currentAccent => _currentAccent;
  Color get primaryColor => _currentAccent.primaryColor;
  Color get accentColor => _currentAccent.accentColor;

  // ganti tema, kalo yg dipilih sama kayak sekarang ga usah notify
  void setAccent(String id) {
    final selected = _accents.firstWhere((a) => a.id == id);
    if (selected.id == _currentAccent.id) return;
    _currentAccent = selected;
    notifyListeners();
  }

  // ThemeData buat MaterialApp, warnanya ngikut tema yg dipilih
  ThemeData get currentTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF11141E),
      colorScheme: ColorScheme.fromSeed(
        seedColor: _currentAccent.primaryColor,
        brightness: Brightness.dark,
        primary: _currentAccent.accentColor,
      ),
      useMaterial3: true,
    );
  }
}
