import 'package:flutter/material.dart';

import '../widgets/now_playing_card.dart';
import '../widgets/collection_summary.dart';
import '../widgets/game_card.dart';

// halaman utama (home) VaultPlay
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold - kerangka utama halaman ini
    return Scaffold(
      backgroundColor: const Color(0xFF11141E),

      // SafeArea biar konten ga ketutup notch hp
      body: SafeArea(
        // SingleChildScrollView supaya bisa di-scroll kalo kontennya panjang
        child: SingleChildScrollView(
          // Padding kasih jarak pinggir biar ga nempel ke tepi layar
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 16.0,
            ),

            // Column buat susun semua section dari atas ke bawah
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // bagian header: sapaan + icon profil
                // Row biar sapaan di kiri, icon profil di kanan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Column buat teks sapaan sama nama app
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // Text sapaan user
                        Text(
                          'Halo, Player! 🎮',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        // Text judul app
                        Text(
                          'VaultPlay',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),

                    // Container buat bungkus icon profil
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2235),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2E344D)),
                      ),
                      child: const Icon(
                        // Icon profil user
                        Icons.person,
                        color: Colors.deepPurpleAccent,
                        size: 26,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ), // SizedBox kasih spasi antar section
                // search bar
                // Container sebagai background search
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2030),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2C324B)),
                  ),
                  // TextField input cari game
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Cari koleksi game...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: Icon(
                        // Icon search di kanan textfield
                        Icons.search,
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // section game yg lagi dimainkan
                const Text(
                  // Text judul section
                  'Sedang Dimainkan 🔥',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const NowPlayingCard(), // banner game aktif

                const SizedBox(height: 22),

                // section ringkasan koleksi
                const Text(
                  // Text judul section
                  'Ringkasan Koleksi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const CollectionSummary(), // 3 box statistik

                const SizedBox(height: 24),

                // section daftar game terbaru
                // Row buat judul "Daftar Game" di kiri, "Lihat Semua" di kanan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      // Text judul daftar
                      'Daftar Game Terbaru',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      // Text lihat semua
                      'Lihat Semua',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // list kartu game pake GameCard widget
                const GameCard(
                  title: 'Elden Ring',
                  platform: 'PC',
                  genre: 'Action RPG',
                  rating: '5.0',
                  status: 'Playing',
                  icon: Icons.videogame_asset,
                  iconColor: Colors.amber,
                  statusColor: Colors.blueAccent,
                ),
                const GameCard(
                  title: 'God of War Ragnarok',
                  platform: 'PS5',
                  genre: 'Action Adventure',
                  rating: '4.9',
                  status: 'Completed',
                  icon: Icons.shield,
                  iconColor: Colors.blueAccent,
                  statusColor: Colors.greenAccent,
                ),
                const GameCard(
                  title: 'Persona 5 Royal',
                  platform: 'Switch',
                  genre: 'JRPG',
                  rating: '4.8',
                  status: 'Wishlist',
                  icon: Icons.flash_on,
                  iconColor: Colors.redAccent,
                  statusColor: Colors.amberAccent,
                ),
              ],
            ),
          ),
        ),
      ),

      // BottomNavigationBar - navigasi bawah (home, koleksi, profil)
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF141724),
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
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
    );
  }
}
