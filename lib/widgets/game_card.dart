import 'package:flutter/material.dart';

// widget kartu game - bisa dipake ulang tinggal ganti parameternya
class GameCard extends StatelessWidget {
  final String title;
  final String platform;
  final String genre;
  final String rating;
  final String status;
  final IconData icon;
  final Color iconColor;
  final Color statusColor;

  const GameCard({
    super.key,
    required this.title,
    required this.platform,
    required this.genre,
    required this.rating,
    required this.status,
    required this.icon,
    required this.iconColor,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    // Container pembungkus kartu game, dikasih margin bawah biar ada jarak antar kartu
    return Container(
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
            child: Icon(icon, color: iconColor, size: 28), // Icon game
          ),
          const SizedBox(width: 12), // SizedBox pemisah icon & info

          // Expanded - detail info game ambil sisa space di tengah
          Expanded(
            child: Column( // Column susun nama game sama badge
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( // Text judul game
                  title,
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
                        platform,
                        style: const TextStyle(fontSize: 10, color: Colors.white70),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text( // Text genre
                      genre,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // bagian kanan: rating bintang + status
          Column( // Column susun rating di atas, status di bawah
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row( // Row buat icon bintang sama angka rating
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16), // Icon bintang
                  const SizedBox(width: 4),
                  Text( // Text rating
                    rating,
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
                status,
                style: TextStyle(fontSize: 11, color: statusColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
