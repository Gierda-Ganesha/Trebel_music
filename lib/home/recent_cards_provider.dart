import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Provider untuk mengelola kartu yang baru saja dilihat
class RecentCardsProvider with ChangeNotifier {
  // List untuk menyimpan kartu terbaru
  List<Map<String, String>> _recentCards = [];

  // Getter untuk mengakses kartu terbaru
  List<Map<String, String>> get recentCards => _recentCards;

  // Konstruktor untuk memuat kartu terbaru saat provider dibuat
  RecentCardsProvider() {
    _loadRecentCards();
  }

  /// Fungsi untuk menambahkan kartu ke list
  /// dan menyimpannya ke SharedPreferences
  void addCard(Map<String, String> card) async {
    // Memeriksa apakah kartu sudah ada dalam list
    if (!_recentCards.any((c) => c['title'] == card['title'])) {
      // Jika jumlah kartu lebih dari atau sama dengan 10, hapus kartu pertama
      if (_recentCards.length >= 10) {
        _recentCards.removeAt(0);
      }
      // Menambahkan kartu baru ke list
      _recentCards.add(card);
      notifyListeners();
      // Menyimpan perubahan ke SharedPreferences
      await _saveRecentCards();
    }
  }

  /// Fungsi untuk memuat kartu terbaru dari SharedPreferences
  Future<void> _loadRecentCards() async {
    final prefs = await SharedPreferences.getInstance();
    final recentCardsString = prefs.getString('recentCards');
    // Jika ada data yang disimpan, ubah kembali ke list
    if (recentCardsString != null) {
      _recentCards = List<Map<String, String>>.from(
        json.decode(recentCardsString).map(
              (card) => Map<String, String>.from(card),
            ),
      );
      notifyListeners();
    }
  }

  /// Fungsi untuk menyimpan kartu terbaru ke SharedPreferences
  Future<void> _saveRecentCards() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('recentCards', json.encode(_recentCards));
  }
}
