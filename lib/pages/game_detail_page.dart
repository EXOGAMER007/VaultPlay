import 'package:flutter/material.dart';

// halaman detail game, munculnya kalo klik salah satu kartu game
class GameDetailPage extends StatelessWidget {
  final String title;
  final String platform;
  final String genre;
  final String rating;
  final String status;
  final Color statusColor;
  final String imagePath;
  final String developer;
  final String releaseYear;

  const GameDetailPage({
    super.key,
    required this.title,
    required this.platform,
    required this.genre,
    required this.rating,
    required this.status,
    required this.statusColor,
    required this.imagePath,
    this.developer = 'Game Studio',
    this.releaseYear = '2023',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11141E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack buat numpuk gambar cover sama tombol back & badge status
              Stack(
                children: [
                  // Image.asset nampilin cover game dari folder assets
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  ),

                  // gradient gelap di bawah gambar biar transisi ke konten mulus
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF11141E).withValues(alpha: 0.95),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Positioned - tombol back di pojok kiri atas
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                        // BoxShadow biar tombolnya keliatan "ngambang"
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        // Navigator.pop buat balik ke halaman sebelumnya
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),

                  // Positioned - badge status di pojok kanan atas
                  Positioned(
                    top: 20,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2235).withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor, width: 1.2),
                        boxShadow: [
                          BoxShadow(
                            color: statusColor.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      // Text status game (PLAYING/COMPLETED/WISHLIST)
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // konten detail di bawah banner
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // judul game
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Row buat badge platform, genre, sama rating
                    Row(
                      children: [
                        Container( // badge platform
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E3550),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            platform,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text( // genre
                          genre,
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const Spacer(),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // kartu info developer & tahun rilis
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1E2E),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2C324B)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // info developer
                          Column(
                            children: [
                              const Text(
                                'Pengembang',
                                style: TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                developer,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          // garis pemisah
                          Container(
                            height: 28,
                            width: 1,
                            color: const Color(0xFF2C324B),
                          ),
                          // info tahun rilis
                          Column(
                            children: [
                              const Text(
                                'Tahun Rilis',
                                style: TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                releaseYear,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // section buat update catatan game
                    const Text(
                      'Update Catatan & Jam Bermain',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Masukkan estimasi atau jumlah jam yang sudah kamu habiskan:',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),

                    // input jam bermain (angka) pake keyboardType number
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C2030),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2C324B)),
                      ),
                      // TextField tipe angka
                      child: const TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.timer_outlined,
                            color: Colors.deepPurpleAccent,
                          ),
                          hintText: 'Jumlah jam bermain (contoh: 45)',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // input catatan/progres bebas
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C2030),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2C324B)),
                      ),
                      child: const TextField(
                        maxLines: 3,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Tulis progres misi terakhir atau catatan backlog...',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // tombol simpan
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        // BoxShadow glow ungu biar tombolnya keliatan premium
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      // ElevatedButton buat simpan perubahan
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save_outlined, color: Colors.white),
                        label: const Text(
                          'Simpan Perubahan & Kembali',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // kasih snackbar notif dulu baru pop
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Catatan game berhasil disimpan!'),
                              backgroundColor: Colors.deepPurple,
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Navigator.pop buat balik
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    const SizedBox(height: 18),
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
