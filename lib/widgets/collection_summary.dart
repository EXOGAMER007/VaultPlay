import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

// widget buat nampilin 3 kotak ringkasan (playing, completed, wishlist)
// angkanya dihitung dari provider, jadi ikut berubah kalo status game diganti
class CollectionSummary extends StatelessWidget {
  const CollectionSummary({super.key});

  // satu kotak statistik, dibikin fungsi biar ga nulis 3x
  Widget _box(String count, String label, Color color) {
    // Expanded biar ukuran 3 kotak rata
    return Expanded(
      child: Container( // Container kotak statistik
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1C2030),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2C324B)),
        ),
        child: Column( // Column susun angka di atas, label di bawah
          children: [
            Text( // Text angka
              count,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4), // SizedBox jarak angka ke label
            Text( // Text label
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // context.watch - rebuild kalo data game berubah
    final provider = context.watch<GameProvider>();

    // Row buat bikin 3 kotak statistik sejajar horizontal
    return Row(
      children: [
        _box('${provider.countByStatus('Playing')}', 'Playing', Colors.blueAccent),
        const SizedBox(width: 10),
        _box('${provider.countByStatus('Completed')}', 'Completed', Colors.greenAccent),
        const SizedBox(width: 10),
        _box('${provider.countByStatus('Wishlist')}', 'Wishlist', Colors.amberAccent),
      ],
    );
  }
}
