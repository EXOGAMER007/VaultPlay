import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../providers/theme_provider.dart';

// halaman profil user - statistik gaming, target tamat, pilihan tema, dll
// masih StatefulWidget karena ada TextEditingController buat input target
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // controller buat input target tamat
  late final TextEditingController _targetController;

  @override
  void initState() {
    super.initState();
    // isi awal textfield diambil dari target yg ada di provider
    final target = context.read<GameProvider>().targetCompleted;
    _targetController = TextEditingController(text: target.toString());
  }

  @override
  void dispose() {
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // context.watch - statistik dihitung dari data game di provider
    final provider = context.watch<GameProvider>();
    // context.watch - buat warna tema sama list pilihan tema
    final themeProvider = context.watch<ThemeProvider>();
    final accentColor = themeProvider.accentColor;

    final completed = provider.countByStatus('Completed');
    final target = provider.targetCompleted;
    final progress = target == 0 ? 0.0 : (completed / target).clamp(0.0, 1.0);

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
                      // avatar profil, border-nya ngikut warna tema
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: const Color(0xFF272C42),
                          shape: BoxShape.circle,
                          border: Border.all(color: accentColor, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person, // Icon avatar
                          color: accentColor,
                          size: 38,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // nama + level + ID
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Alex "VaultHunter"',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Level 28 • Hardcore Backlogger',
                              style: TextStyle(
                                fontSize: 12,
                                color: accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
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
                      child: _statCard(
                        icon: Icons.access_time_filled,
                        iconColor: Colors.amber,
                        value: '${provider.totalHours} Jam',
                        label: 'Waktu Bermain',
                      ),
                    ),
                    const SizedBox(width: 12),
                    // kartu total game tamat
                    Expanded(
                      child: _statCard(
                        icon: Icons.emoji_events,
                        iconColor: Colors.greenAccent,
                        value: '$completed Game',
                        label: 'Sudah Tamat',
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

                // TextField buat input target (angka) + tombol set
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C2030),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2C324B)),
                        ),
                        // pake keyboardType number biar cuma bisa input angka
                        child: TextField(
                          controller: _targetController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.flag_outlined, color: accentColor),
                            hintText: 'Target game tamat (contoh: 20)',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // ElevatedButton buat nerapin target baru
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final value = int.tryParse(_targetController.text);
                        // target harus angka lebih dari 0
                        if (value == null || value <= 0) return;
                        // simpen ke provider, bukan setState lagi
                        context.read<GameProvider>().setTargetCompleted(value);
                        FocusScope.of(context).unfocus(); // tutup keyboard
                      },
                      child: const Text(
                        'Set',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // progress menuju target, otomatis ikut jumlah game completed
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$completed dari $target game',
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                    Text(
                      '${(progress * 100).round()}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // LinearProgressIndicator buat nunjukin progress target
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: const Color(0xFF2C324B),
                    color: accentColor,
                  ),
                ),

                const SizedBox(height: 22),

                // section pilih warna tema
                const Text(
                  'Warna Tema 🎨',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // Wrap biar chip warnanya turun ke bawah kalo ga muat
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: themeProvider.accents.map((accent) {
                    final selected = accent.id == themeProvider.currentAccent.id;
                    // ChoiceChip tiap pilihan warna
                    // pas dipilih panggil setAccent, terus semua halaman ikut ganti warna
                    return ChoiceChip(
                      avatar: Icon(accent.icon, size: 16, color: accent.accentColor),
                      label: Text(accent.name),
                      selected: selected,
                      selectedColor: accent.accentColor.withValues(alpha: 0.3),
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.grey,
                      ),
                      onSelected: (_) {
                        context.read<ThemeProvider>().setAccent(accent.id);
                      },
                    );
                  }).toList(),
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
                      // menu sinkronisasi, pake Switch yg bisa di-toggle
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 6.0,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.cloud_sync_outlined, color: Colors.blueAccent),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Sinkronisasi Cloud Steam / PSN',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                            // Switch on/off sinkronisasi, nilainya dari provider
                            Switch(
                              value: provider.cloudSyncEnabled,
                              activeThumbColor: accentColor,
                              onChanged: (value) {
                                context.read<GameProvider>().toggleCloudSync(value);
                              },
                            ),
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
                                'Tentang VaultPlay v1.4',
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

  // kartu statistik kecil, dibikin fungsi biar ga nulis 2x
  Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    // Container kotak statistik
    return Container(
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
      // Column susun icon, angka, label
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
