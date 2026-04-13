import 'package:flutter/foundation.dart';

import '../models/player.dart';

/// Session-only game state (cleared on full reset / after winner flow).
class GameState extends ChangeNotifier {
  final List<Player> _players = [];
  String? _winnerName;

  List<Player> get players => List.unmodifiable(_players);
  String? get winnerName => _winnerName;

  bool get canPlayRoulette => _players.length >= 2;

  void addPlayer(Player player) {
    _players.add(player);
    notifyListeners();
  }

  void removePlayer(String id) {
    _players.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void setWinner(String name) {
    _winnerName = name;
    notifyListeners();
  }

  void clearPlayers() {
    _players.clear();
    _winnerName = null;
    notifyListeners();
  }

  double get totalPrice => _players.fold<double>(0, (sum, p) => sum + p.price);
}
