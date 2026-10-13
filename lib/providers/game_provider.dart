import 'package:flutter/material.dart';
import '../models/game.dart';

// pilihan urutan buat list koleksi
enum GameSortOption { latest, titleAsc, ratingDesc, hoursDesc }

// GameProvider = tempat nyimpen data game yg dipake bareng semua halaman
// konsep: ChangeNotifier + Provider
// tiap data berubah kita panggil notifyListeners(), terus widget yg
// "mendengarkan" (context.watch / Consumer) otomatis rebuild
// catatan: data cuma di memori, jadi balik ke awal kalo app ditutup
class GameProvider extends ChangeNotifier {
  final List<Game> _games = [
    Game(
      id: 'elden_ring',
      title: 'Elden Ring',
      platform: 'PC',
      genre: 'Action RPG',
      rating: 5.0,
      status: 'Playing',
      icon: Icons.videogame_asset,
      iconColor: Colors.amber,
      imagePath: 'assets/images/elden_ring.png',
      developer: 'FromSoftware',
      releaseYear: '2022',
      hoursPlayed: 62,
      isFavorite: true,
    ),
    Game(
      id: 'gow_ragnarok',
      title: 'God of War Ragnarok',
      platform: 'PS5',
      genre: 'Action Adventure',
      rating: 4.9,
      status: 'Completed',
      icon: Icons.shield,
      iconColor: Colors.blueAccent,
      imagePath: 'assets/images/gow_ragnarok.png',
      developer: 'Santa Monica Studio',
      releaseYear: '2022',
      hoursPlayed: 48,
      isFavorite: true,
    ),
    Game(
      id: 'persona5',
      title: 'Persona 5 Royal',
      platform: 'Switch',
      genre: 'JRPG',
      rating: 4.8,
      status: 'Wishlist',
      icon: Icons.flash_on,
      iconColor: Colors.redAccent,
      imagePath: 'assets/images/persona5.png',
      developer: 'ATLUS',
      releaseYear: '2019',
    ),
    Game(
      id: 'cyberpunk',
      title: 'Cyberpunk 2077',
      platform: 'PC',
      genre: 'Sci-Fi RPG',
      rating: 4.7,
      status: 'Wishlist',
      icon: Icons.bolt,
      iconColor: Colors.yellowAccent,
      imagePath: 'assets/images/cyberpunk.png',
      developer: 'CD Projekt Red',
      releaseYear: '2020',
    ),
    Game(
      id: 'witcher3',
      title: 'The Witcher 3: Wild Hunt',
      platform: 'PC',
      genre: 'Open World RPG',
      rating: 4.9,
      status: 'Playing',
      icon: Icons.sports_esports,
      iconColor: Colors.deepPurpleAccent,
      imagePath: 'assets/images/witcher3.png',
      developer: 'CD Projekt Red',
      releaseYear: '2015',
      hoursPlayed: 48,
    ),
    Game(
      id: 'zelda',
      title: 'Zelda: Tears of the Kingdom',
      platform: 'Nintendo Switch',
      genre: 'Action Adventure',
      rating: 5.0,
      status: 'Completed',
      icon: Icons.landscape,
      iconColor: Colors.greenAccent,
      imagePath: 'assets/images/zelda.png',
      developer: 'Nintendo EPD',
      releaseYear: '2023',
      hoursPlayed: 85,
    ),
  ];

  // target tamat & switch sync dipindah ke sini (sebelumnya di ProfilePage)
  // biar nilainya ga ilang pas pindah2 halaman
  int _targetCompleted = 20;
  bool _cloudSyncEnabled = true;

  // urutan koleksi yg lagi dipilih
  GameSortOption _sortOption = GameSortOption.latest;

  // getter biar list aslinya ga bisa diubah dari luar sembarangan
  List<Game> get games => List.unmodifiable(_games);

  int get targetCompleted => _targetCompleted;
  bool get cloudSyncEnabled => _cloudSyncEnabled;
  GameSortOption get sortOption => _sortOption;

  int get totalHours => _games.fold(0, (sum, g) => sum + g.hoursPlayed);

  int countByStatus(String status) =>
      _games.where((g) => g.status == status).length;

  // game yg lagi dimainkan paling lama, dipake buat banner di home
  Game? get nowPlaying {
    final playing = _games.where((g) => g.status == 'Playing').toList();
    if (playing.isEmpty) return null;
    playing.sort((a, b) => b.hoursPlayed.compareTo(a.hoursPlayed));
    return playing.first;
  }

  Game? getById(String id) {
    for (final g in _games) {
      if (g.id == id) return g;
    }
    return null;
  }

  // list game yg udah diurutin sesuai pilihan sort
  // dicopy dulu biar urutan asli _games ga ikut keubah
  List<Game> get sortedGames {
    final list = List<Game>.from(_games);
    switch (_sortOption) {
      case GameSortOption.titleAsc:
        list.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case GameSortOption.ratingDesc:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case GameSortOption.hoursDesc:
        list.sort((a, b) => b.hoursPlayed.compareTo(a.hoursPlayed));
        break;
      case GameSortOption.latest:
        break;
    }
    return list;
  }

  void setTargetCompleted(int target) {
    _targetCompleted = target;
    notifyListeners();
  }

  void toggleCloudSync(bool value) {
    _cloudSyncEnabled = value;
    notifyListeners();
  }

  void setSortOption(GameSortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  // game baru ditaruh paling atas biar langsung keliatan
  void addGame(Game game) {
    _games.insert(0, game);
    notifyListeners();
  }

  void removeGame(String id) {
    _games.removeWhere((g) => g.id == id);
    notifyListeners();
  }

  void updateGame(String id, {String? status, int? hours, String? notes}) {
    final game = getById(id);
    if (game == null) return;
    if (status != null) game.status = status;
    if (hours != null) game.hoursPlayed = hours;
    if (notes != null) game.notes = notes;
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final game = getById(id);
    if (game == null) return;
    game.isFavorite = !game.isFavorite;
    notifyListeners();
  }
}
