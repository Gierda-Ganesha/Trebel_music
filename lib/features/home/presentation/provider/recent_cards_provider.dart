import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecentCardsProvider with ChangeNotifier {
  List<Map<String, String>> _recentCards = [];

  List<Map<String, String>> get recentCards => _recentCards;

  RecentCardsProvider() {
    _loadRecentCards();
  }

  void addCard(Map<String, String> card) async {
    if (!_recentCards.any((c) => c['title'] == card['title'])) {
      if (_recentCards.length >= 10) {
        _recentCards.removeAt(0);
      }
      _recentCards.add(card);
      notifyListeners();
      await _saveRecentCards();
    }
  }

  Future<void> _loadRecentCards() async {
    final prefs = await SharedPreferences.getInstance();
    final recentCardsString = prefs.getString('recentCards');
    if (recentCardsString != null) {
      _recentCards = List<Map<String, String>>.from(
        json.decode(recentCardsString).map(
              (card) => Map<String, String>.from(card),
            ),
      );
      notifyListeners();
    }
  }

  Future<void> _saveRecentCards() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('recentCards', json.encode(_recentCards));
  }
}
