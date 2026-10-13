import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/collection_page.dart';
import 'pages/profile_page.dart';
import 'providers/theme_provider.dart';

// pengatur navigasi utama pake BottomNavigationBar
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // nyimpen index halaman yg aktif
  int _currentIndex = 0;

  // list halaman yg bisa dipilih
  final List<Widget> _pages = const [
    HomePage(),
    CollectionPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // warna menu aktif ngikut tema yg dipilih
    final accentColor = context.watch<ThemeProvider>().accentColor;

    return Scaffold(
      backgroundColor: const Color(0xFF11141E),

      // pake IndexedStack biar state halaman ga reset tiap pindah tab
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      // bungkus navbar pake Container buat kasih shadow
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        // BottomNavigationBar - navigasi bawah
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF141724),
          selectedItemColor: accentColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), // Icon beranda
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports), // Icon koleksi
              label: 'Koleksi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person), // Icon profil
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
