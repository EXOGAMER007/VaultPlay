import 'package:flutter/material.dart';

// widget banner buat game yg lagi dimainkan sekarang
class NowPlayingCard extends StatelessWidget {
  const NowPlayingCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Container utama pake gradient ungu biar keliatan stand out
    return Container(
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
            child: const Icon( // Icon controller game
              Icons.sports_esports,
              color: Colors.deepPurpleAccent,
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
                const Text( // Text judul game
                  'The Witcher 3: Wild Hunt',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                const Text( // Text info platform & jam main
                  'PC • 48 Jam Dimainkan',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
