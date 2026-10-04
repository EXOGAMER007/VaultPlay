import 'package:flutter/material.dart';

// daftar status yg dipake di seluruh app
const List<String> statusList = ['Playing', 'Completed', 'Wishlist'];

// warna badge sesuai status, dipisah biar ga ditulis ulang di tiap widget
Color statusColorOf(String status) {
  switch (status) {
    case 'Playing':
      return Colors.blueAccent;
    case 'Completed':
      return Colors.greenAccent;
    default:
      return Colors.amberAccent;
  }
}

// model data satu game
// field yg bisa berubah (status, jam, catatan, favorit) sengaja ga final
class Game {
  final String id;
  final String title;
  final String platform;
  final String genre;
  final double rating;
  final String developer;
  final String releaseYear;
  final String imagePath;
  final IconData icon;
  final Color iconColor;

  String status;
  int hoursPlayed;
  String notes;
  bool isFavorite;

  Game({
    required this.id,
    required this.title,
    required this.platform,
    required this.genre,
    required this.rating,
    required this.status,
    this.developer = 'Game Studio',
    this.releaseYear = '2024',
    this.imagePath = 'assets/images/elden_ring.png',
    this.icon = Icons.sports_esports,
    this.iconColor = Colors.deepPurpleAccent,
    this.hoursPlayed = 0,
    this.notes = '',
    this.isFavorite = false,
  });

  // warna status ngikut status yg sekarang
  Color get statusColor => statusColorOf(status);
}
