import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/game_detail_page.dart';
import '../providers/game_provider.dart';

// widget banner buat game yg lagi dimainkan sekarang
// isinya ngikut data di provider, jadi berubah kalo status game diganti
class NowPlayingCard extends StatelessWidget {
  const NowPlayingCard({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch - rebuild otomatis tiap data di provider berubah
    final game = context.watch<GameProvider>().nowPlaying;

    // kalo ga ada game yg lagi dimainkan, tampilin pesan kosong
    if (game == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1C2030),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2C324B)),
        ),
        child: const Text(
          'Belum ada game yang lagi dimainkan. Ubah status game jadi Playing dulu ya.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      );
    }

    // bungkus pake GestureDetector biar banner bisa diklik ke detail
    return GestureDetector(
      onTap: () {
        // Navigator.push buat buka detail game yg lagi dimainkan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailPage(gameId: game.id),
          ),
        );
      },
      // Container utama pake gradient ungu biar keliatan stand out
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3F2B96), Color(0xFF1E2048)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF533FAD)),
          // BoxShadow glow ungu biar banner ini keliatan menonjol
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3F2B96).withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        // Row buat susun thumbnail sama info game ke samping
        child: Row(
          children: [
            // Container kotak icon game
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF111422),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon( // Icon game
                game.icon,
                color: game.iconColor,
                size: 34,
              ),
            ),
            const SizedBox(width: 14), // SizedBox kasih jarak antara icon & teks

            // Expanded biar info game ambil sisa ruang yg ada
            Expanded(
              // Column buat susun badge, judul, dan keterangan game
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container badge status "PLAYING"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0x334CAF50),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.greenAccent, width: 0.8),
                    ),
                    child: const Text( // Text label status
                      'PLAYING',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text( // Text judul game
                    game.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text( // Text info platform & jam main
                    '${game.platform} • ${game.hoursPlayed} Jam Dimainkan',
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
