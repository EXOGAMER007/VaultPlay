import 'package:flutter/material.dart';

// halaman profil user - statistik gaming, target tamat, dll
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                const Text(
                  'Profil Gamer 👤',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),

                // kartu profil utama
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2030),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF2C324B)),
                    // BoxShadow biar kartunya keliatan ngangkat
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  // Row: avatar di kiri, info di kanan
                  child: Row(
                    children: [
                      // avatar profil
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: const Color(0xFF272C42),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurpleAccent.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person, // Icon avatar
                          color: Colors.deepPurpleAccent,
                          size: 38,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // nama + level + ID
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Alex "VaultHunter"',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Level 28 • Hardcore Backlogger',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.deepPurpleAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'ID: #VP-89214',
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // section statistik
                const Text(
                  'Statistik Pribadi 📊',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),

                // 2 kartu statistik sejajar
                Row(
                  children: [
                    // kartu total jam bermain
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF181C2B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2C324B)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(Icons.access_time_filled, color: Colors.amber, size: 24),
                            SizedBox(height: 8),
                            Text(
                              '184 Jam',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Waktu Bermain',
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // kartu total game tamat
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF181C2B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2C324B)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(Icons.emoji_events, color: Colors.greenAccent, size: 24),
                            SizedBox(height: 8),
                            Text(
                              '14 Game',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Tamat Tahun Ini',
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // section target tamat
                const Text(
                  'Target Tamat Tahun Ini 🎯',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tetapkan target jumlah game yang ingin ditamatkan:',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 10),

                // TextField buat input target (angka)
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2030),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2C324B)),
                  ),
                  // pake keyboardType number biar cuma bisa input angka
                  child: const TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.flag_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                      hintText: 'Target game tamat (contoh: 20)',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // section pengaturan
                const Text(
                  'Pengaturan Akun ⚙️',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // list menu pengaturan
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF181C2B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF2C324B)),
                  ),
                  child: Column(
                    children: [
                      // menu sinkronisasi
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: const [
                            Icon(Icons.cloud_sync_outlined, color: Colors.blueAccent),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Sinkronisasi Cloud Steam / PSN',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                          ],
                        ),
                      ),
                      Container(height: 1, color: const Color(0xFF2C324B)),
                      // menu tema
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: const [
                            Icon(Icons.palette_outlined, color: Colors.deepPurpleAccent),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Tema Tampilan (Dark Violet)',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                          ],
                        ),
                      ),
                      Container(height: 1, color: const Color(0xFF2C324B)),
                      // menu tentang app
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: const [
                            Icon(Icons.info_outline, color: Colors.greenAccent),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Tentang VaultPlay v1.3',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
