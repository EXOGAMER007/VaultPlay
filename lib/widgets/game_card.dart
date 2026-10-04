import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../pages/game_detail_page.dart';
import '../providers/game_provider.dart';

// widget kartu game - bisa dipake ulang, tinggal kasih objek Game
class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  // dialog konfirmasi sebelum game dihapus dari koleksi
  void _confirmDelete(BuildContext context) {
    // showDialog + AlertDialog buat konfirmasi hapus
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1C2030),
        title: const Text('Hapus game?', style: TextStyle(color: Colors.white)),
        content: Text(
          '${game.title} akan dihapus dari koleksimu.',
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              // context.read - panggil aksi di provider tanpa ikut rebuild
              context.read<GameProvider>().removeGame(game.id);
              Navigator.pop(dialogContext);
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // bungkus pake GestureDetector biar bisa diklik ke halaman detail
    // tekan lama buat hapus
    return GestureDetector(
      onLongPress: () => _confirmDelete(context),
      onTap: () {
        // Navigator.push buat buka halaman detail game
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailPage(gameId: game.id),
          ),
        );
      },
      // Container pembungkus kartu game, dikasih margin bawah biar ada jarak antar kartu
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C2030),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF2C324B)),
        ),
        // Row buat susun icon, info game, sama rating ke samping
        child: Row(
          children: [
            // Container kotak icon game di kiri
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF272C42),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(game.icon, color: game.iconColor, size: 28), // Icon game
            ),
            const SizedBox(width: 12), // SizedBox pemisah icon & info

            // Expanded - detail info game ambil sisa space di tengah
            Expanded(
              child: Column( // Column susun nama game sama badge
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( // Text judul game
                    game.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Row buat badge platform sama genre sejajar
                  Row(
                    children: [
                      Container( // Container badge platform
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E3550),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text( // Text nama platform
                          game.platform,
                          style: const TextStyle(fontSize: 10, color: Colors.white70),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text( // Text genre
                          game.genre,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // bagian kanan: rating bintang + status + jam main
            Column( // Column susun rating di atas, status di bawah
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row( // Row buat icon favorit, bintang sama angka rating
                  children: [
                    // GestureDetector kecil buat toggle favorit langsung dari kartu
                    GestureDetector(
                      onTap: () =>
                          context.read<GameProvider>().toggleFavorite(game.id),
                      child: Icon(
                        game.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: game.isFavorite ? Colors.redAccent : Colors.grey,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, color: Colors.amber, size: 16), // Icon bintang
                    const SizedBox(width: 4),
                    Text( // Text rating
                      game.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text( // Text status game (playing/completed/wishlist)
                  game.status,
                  style: TextStyle(fontSize: 11, color: game.statusColor),
                ),
                Text( // Text jam main
                  '${game.hoursPlayed} jam',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
