import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/game_provider.dart';
import '../providers/theme_provider.dart';

// halaman form buat nambah game baru ke koleksi
// StatefulWidget karena isi form (dropdown, slider, status) berubah2
class AddGamePage extends StatefulWidget {
  const AddGamePage({super.key});

  @override
  State<AddGamePage> createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  // key buat validasi Form
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _genreController = TextEditingController();
  final _developerController = TextEditingController();

  final List<String> _platforms = ['PC', 'PS5', 'Xbox', 'Switch'];
  String _platform = 'PC';
  String _status = 'Playing';
  double _rating = 4.0;

  // cover diambil bergantian dari aset yg udah ada
  final List<String> _covers = [
    'assets/images/elden_ring.png',
    'assets/images/gow_ragnarok.png',
    'assets/images/persona5.png',
    'assets/images/cyberpunk.png',
    'assets/images/witcher3.png',
    'assets/images/zelda.png',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _genreController.dispose();
    _developerController.dispose();
    super.dispose();
  }

  // style input biar seragam sama halaman lain
  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      filled: true,
      fillColor: const Color(0xFF1C2030),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2C324B)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2C324B)),
      ),
    );
  }

  void _submit() {
    // validate() ngecek semua validator di TextFormField
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<GameProvider>();
    provider.addGame(
      Game(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        platform: _platform,
        genre: _genreController.text.trim().isEmpty
            ? 'Lainnya'
            : _genreController.text.trim(),
        developer: _developerController.text.trim().isEmpty
            ? 'Game Studio'
            : _developerController.text.trim(),
        rating: _rating,
        status: _status,
        imagePath: _covers[provider.games.length % _covers.length],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Game baru ditambahkan ke koleksi!'),
        backgroundColor: context.read<ThemeProvider>().primaryColor,
        duration: const Duration(seconds: 1),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // warna tombol, slider dll ngikut tema
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF11141E),
      // AppBar dengan tombol back otomatis
      appBar: AppBar(
        backgroundColor: const Color(0xFF11141E),
        title: const Text('Tambah Game', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          // Form buat ngelompokin field & validasi
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // judul game (wajib diisi)
                TextFormField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle('Judul game'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Judul tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _genreController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle('Genre (contoh: Action RPG)'),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _developerController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle('Developer'),
                ),
                const SizedBox(height: 16),

                const Text('Platform', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                // DropdownButtonFormField buat pilih platform
                DropdownButtonFormField<String>(
                  initialValue: _platform,
                  dropdownColor: const Color(0xFF1C2030),
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputStyle(''),
                  items: _platforms
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _platform = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),

                const Text('Status', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                // ChoiceChip buat pilih status awal
                Wrap(
                  spacing: 8,
                  children: statusList.map((s) {
                    return ChoiceChip(
                      label: Text(s),
                      selected: _status == s,
                      selectedColor: statusColorOf(s).withValues(alpha: 0.3),
                      labelStyle: TextStyle(
                        color: _status == s ? statusColorOf(s) : Colors.grey,
                      ),
                      onSelected: (_) {
                        setState(() {
                          _status = s;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Row nampilin label rating + nilainya
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Rating', style: TextStyle(color: Colors.grey)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          _rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Slider buat atur rating dari 1 sampai 5
                Slider(
                  value: _rating,
                  min: 1,
                  max: 5,
                  divisions: 8,
                  activeColor: themeProvider.accentColor,
                  onChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // tombol simpan
                SizedBox(
                  width: double.infinity,
                  // ElevatedButton buat submit form
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Tambah ke Koleksi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
