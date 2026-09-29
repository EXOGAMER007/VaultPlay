import 'package:flutter/material.dart';
import '../widgets/game_card.dart';
import 'game_detail_page.dart';

// halaman koleksi - list semua game yg dipunya
class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11141E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // judul halaman
                const Text(
                  'Koleksi Game 🎮',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Semua riwayat dan daftar backlog yang tersimpan',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),

                const SizedBox(height: 18),

                // section game unggulan / sorotan
                const Text(
                  'Sorotan Koleksi ✨',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // banner sorotan game, klik buat buka detail
                GestureDetector(
                  onTap: () {
                    // Navigator.push buat buka halaman detail Zelda
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameDetailPage(
                          title: 'Zelda: Tears of the Kingdom',
                          platform: 'Nintendo Switch',
                          genre: 'Action Adventure',
                          rating: '5.0',
                          status: 'Completed',
                          statusColor: Colors.greenAccent,
                          imagePath: 'assets/images/zelda.png',
                          developer: 'Nintendo EPD',
                          releaseYear: '2023',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // BoxShadow biar banner keliatan ada depth
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      // Stack buat numpuk gambar, overlay gelap, dan teks info
                      child: Stack(
                        children: [
                          // Image.asset - cover game dari assets
                          Image.asset(
                            'assets/images/zelda.png',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),

                          // overlay gradient biar teks di bawah terbaca
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.85),
                                ],
                              ),
                            ),
                          ),

                          // Positioned - badge di pojok kiri atas
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'GAME TERBAIK 2023',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // Positioned - info game di bagian bawah
                          Positioned(
                            bottom: 12,
                            left: 14,
                            right: 14,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Zelda: Tears of the Kingdom',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Nintendo Switch • Tamat (85 Jam)',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                // icon panah kecil biar keliatan bisa diklik
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // header daftar game + jumlah
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Semua Koleksi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '5 Game',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // daftar kartu game, masing2 bisa diklik ke detail
                const GameCard(
                  title: 'Elden Ring',
                  platform: 'PC',
                  genre: 'Action RPG',
                  rating: '5.0',
                  status: 'Playing',
                  icon: Icons.videogame_asset,
                  iconColor: Colors.amber,
                  statusColor: Colors.blueAccent,
                  imagePath: 'assets/images/elden_ring.png',
                  developer: 'FromSoftware',
                  releaseYear: '2022',
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
                  imagePath: 'assets/images/gow_ragnarok.png',
                  developer: 'Santa Monica Studio',
                  releaseYear: '2022',
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
                  imagePath: 'assets/images/persona5.png',
                  developer: 'ATLUS',
                  releaseYear: '2019',
                ),
                const GameCard(
                  title: 'Cyberpunk 2077',
                  platform: 'PC',
                  genre: 'Sci-Fi RPG',
                  rating: '4.7',
                  status: 'Wishlist',
                  icon: Icons.bolt,
                  iconColor: Colors.yellowAccent,
                  statusColor: Colors.amberAccent,
                  imagePath: 'assets/images/cyberpunk.png',
                  developer: 'CD Projekt Red',
                  releaseYear: '2020',
                ),
                const GameCard(
                  title: 'The Witcher 3: Wild Hunt',
                  platform: 'PC',
                  genre: 'Open World RPG',
                  rating: '4.9',
                  status: 'Playing',
                  icon: Icons.sports_esports,
                  iconColor: Colors.deepPurpleAccent,
                  statusColor: Colors.blueAccent,
                  imagePath: 'assets/images/witcher3.png',
                  developer: 'CD Projekt Red',
                  releaseYear: '2015',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
