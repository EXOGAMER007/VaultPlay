import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/now_playing_card.dart';
import '../widgets/collection_summary.dart';
import '../widgets/game_card.dart';

// halaman utama (home) VaultPlay
// jadi StatefulWidget karena ada search bar yg nyimpen teks pencarian
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // teks pencarian yg lagi diketik
  String _query = '';

  @override
  Widget build(BuildContext context) {
    // context.watch - ambil data game dari provider, rebuild kalo berubah
    final allGames = context.watch<GameProvider>().games;
    // warna aksen dari tema yg dipilih di profil
    final accentColor = context.watch<ThemeProvider>().accentColor;
    // kalo search kosong tampilin 3 game teratas, kalo ada isi tampilin yg cocok
    final shownGames = _query.isEmpty
        ? allGames.take(3).toList()
        : allGames
            .where((g) => g.title.toLowerCase().contains(_query.toLowerCase()))
            .toList();

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
                      child: Icon(
                        Icons.person, // Icon profil
                        color: accentColor,
                        size: 26,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20), // SizedBox kasih spasi antar section

                // search bar
                // Container sebagai background search
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2030),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2C324B)),
                  ),
                  // TextField input cari game, onChanged update state tiap ngetik
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        _query = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Cari koleksi game...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: Icon(
                        Icons.search, // Icon search di kanan textfield
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // section game yg lagi dimainkan
                const Text(
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
                // Row buat judul di kiri, keterangan di kanan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _query.isEmpty ? 'Daftar Game Terbaru' : 'Hasil Pencarian',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text( // jumlah hasil kalo lagi nyari
                      _query.isEmpty ? 'Terbaru' : '${shownGames.length} game',
                      style: TextStyle(
                        fontSize: 12,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // kalo hasil pencarian kosong kasih pesan, kalo ada tampilin kartunya
                if (shownGames.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Game tidak ditemukan',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                else
                  // list kartu game pake GameCard widget
                  ...shownGames.map((game) => GameCard(game: game)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
