import 'package:flutter/material.dart';

// widget buat nampilin 3 kotak ringkasan (playing, completed, wishlist)
class CollectionSummary extends StatelessWidget {
  const CollectionSummary({super.key});

  @override
  Widget build(BuildContext context) {
    // Row buat bikin 3 kotak statistik sejajar horizontal
    return Row(
      children: [
        // kotak pertama - Playing
        // Expanded biar ukurannya rata sama kotak lain
        Expanded(
          child: Container( // Container kotak statistik
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF1C2030),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2C324B)),
            ),
            child: Column( // Column susun angka di atas, label di bawah
              children: const [
                Text( // Text angka playing
                  '3',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 4), // SizedBox jarak angka ke label
                Text( // Text label
                  'Playing',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 10),

        // kotak kedua - Completed
        Expanded( // Expanded biar rata
          child: Container( // Container kotak statistik
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF1C2030),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2C324B)),
            ),
            child: Column( // Column susun angka & label
              children: const [
                Text( // Text angka completed
                  '18',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                  ),
                ),
                SizedBox(height: 4),
                Text( // Text label
                  'Completed',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 10),

        // kotak ketiga - Wishlist
        Expanded( // Expanded biar rata juga
          child: Container( // Container kotak statistik
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF1C2030),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2C324B)),
            ),
            child: Column( // Column susun angka & label
              children: const [
                Text( // Text angka wishlist
                  '7',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                SizedBox(height: 4),
                Text( // Text label
                  'Wishlist',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
