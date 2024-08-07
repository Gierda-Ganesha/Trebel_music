import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RecentCardsProvider with ChangeNotifier {
  List<Map<String, String>> _recentCards = [];

  RecentCardsProvider() {
    loadRecentCards();
  }

  List<Map<String, String>> get recentCards => _recentCards;

  void addRecentCard(Map<String, String> card) {
    if (_recentCards
        .any((existingCard) => existingCard['title'] == card['title'])) {
      return;
    }

    if (_recentCards.length >= 10) {
      _recentCards.removeAt(0);
    }
    _recentCards.add(card);
    notifyListeners();
    _saveRecentCards();
  }

  void loadRecentCards() async {
    final prefs = await SharedPreferences.getInstance();
    final recentCardsString = prefs.getString('recentCards');
    if (recentCardsString != null) {
      List<dynamic> decoded = json.decode(recentCardsString);
      _recentCards =
          decoded.map((item) => Map<String, String>.from(item)).toList();
      notifyListeners();
    }
  }

  void _saveRecentCards() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('recentCards', json.encode(_recentCards));
  }
}
