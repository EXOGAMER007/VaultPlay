import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/game_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/game_card.dart';
import 'add_game_page.dart';
import 'game_detail_page.dart';

// halaman koleksi - list semua game yg dipunya
// StatefulWidget karena ada filter status sama pencarian
class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  // filter yg aktif: 'Semua', salah satu status, atau 'Favorit'
  String _filter = 'Semua';
  // teks pencarian
  String _query = '';

  @override
  Widget build(BuildContext context) {
    // context.watch - data game dari provider
    final provider = context.watch<GameProvider>();
    final accentColor = context.watch<ThemeProvider>().accentColor;
    // game sorotan, kalo udah dihapus banner-nya ikut ilang
    final highlight = provider.getById('zelda');

    // ambil list yg udah diurutin, terus terapin filter + pencarian
    final shownGames = provider.sortedGames.where((g) {
      bool matchStatus;
      if (_filter == 'Semua') {
        matchStatus = true;
      } else if (_filter == 'Favorit') {
        matchStatus = g.isFavorite;
      } else {
        matchStatus = g.status == _filter;
      }
      final matchQuery = g.title.toLowerCase().contains(_query.toLowerCase());
      return matchStatus && matchQuery;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF11141E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // judul halaman + tombol tambah game
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Koleksi Game 🎮',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // IconButton buat buka form tambah game
                    Container(
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          // Navigator.push buka halaman form
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddGamePage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Semua riwayat dan daftar backlog yang tersimpan',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),

                const SizedBox(height: 18),

                // section game unggulan / sorotan
                if (highlight != null) ...[
                  const Text(
                    'Sorotan Koleksi ✨',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildHighlight(context, highlight, accentColor),
                  const SizedBox(height: 22),
                ],

                // search bar koleksi
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2030),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2C324B)),
                  ),
                  // TextField cari game, setState tiap teks berubah
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        _query = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Cari di koleksi...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      suffixIcon: Icon(Icons.search, color: Colors.grey, size: 22),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // filter status pake ChoiceChip, bisa di-scroll ke samping
                // ditambah 'Favorit' buat nampilin game yg di-love aja
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Semua', ...statusList, 'Favorit'].map((s) {
                      final selected = _filter == s;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        // ChoiceChip tiap pilihan filter
                        child: ChoiceChip(
                          label: Text(s),
                          selected: selected,
                          selectedColor: accentColor,
                          labelStyle: TextStyle(
                            color: selected ? Colors.white : Colors.grey,
                          ),
                          onSelected: (_) {
                            setState(() {
                              _filter = s;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 18),

                // header daftar game + jumlah + tombol urutkan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Semua Koleksi (${shownGames.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // PopupMenuButton buat pilih urutan
                    // pilihannya disimpen di GameProvider, jadi pake context.read
                    PopupMenuButton<GameSortOption>(
                      color: const Color(0xFF1C2030),
                      initialValue: provider.sortOption,
                      icon: Icon(Icons.sort, color: accentColor),
                      onSelected: (option) {
                        context.read<GameProvider>().setSortOption(option);
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: GameSortOption.latest,
                          child: Text('Terbaru', style: TextStyle(color: Colors.white)),
                        ),
                        PopupMenuItem(
                          value: GameSortOption.titleAsc,
                          child: Text('Judul A-Z', style: TextStyle(color: Colors.white)),
                        ),
                        PopupMenuItem(
                          value: GameSortOption.ratingDesc,
                          child: Text('Rating tertinggi', style: TextStyle(color: Colors.white)),
                        ),
                        PopupMenuItem(
                          value: GameSortOption.hoursDesc,
                          child: Text('Jam main terbanyak', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
                const Text(
                  'Tekan lama kartu game buat hapus',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 12),

                // daftar kartu game, masing2 bisa diklik ke detail
                if (shownGames.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'Tidak ada game yang cocok',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                else
                  ...shownGames.map((game) => GameCard(game: game)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // banner sorotan game, klik buat buka detail
  Widget _buildHighlight(BuildContext context, Game game, Color accentColor) {
    return GestureDetector(
      onTap: () {
        // Navigator.push buat buka halaman detail
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailPage(gameId: game.id),
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
                game.imagePath,
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
                    color: accentColor,
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
                      children: [
                        Text(
                          game.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${game.platform} • ${game.status} (${game.hoursPlayed} Jam)',
                          style: const TextStyle(
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
    );
  }
}
