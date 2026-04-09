import 'dart:math';

import '../models/player.dart';

/// Result of preparing a weighted spin: winner and total rotation (radians).
class SpinPlan {
  SpinPlan({
    required this.winner,
    required this.endRotationRadians,
  });

  final Player winner;
  final double endRotationRadians;
}

class RouletteService {
  RouletteService([Random? random]) : _random = random ?? Random();

  final Random _random;

  /// Picks a winner with probability proportional to [Player.price].
  Player pickWeightedWinner(List<Player> players) {
    if (players.isEmpty) {
      throw ArgumentError('players must not be empty');
    }
    final total = players.fold<double>(0, (s, p) => s + p.price);
    if (total <= 0) {
      throw ArgumentError('total price must be positive');
    }
    var r = _random.nextDouble() * total;
    for (final p in players) {
      r -= p.price;
      if (r <= 0) {
        return p;
      }
    }
    return players.last;
  }

  /// Builds rotation so the chart (first slice from top, clockwise) lands on [winner].
  SpinPlan planSpin(List<Player> players, Player winner) {
    final total = players.fold<double>(0, (s, p) => s + p.price);
    if (total <= 0) {
      throw ArgumentError('total price must be positive');
    }

    double startFrac = 0;
    double endFrac = 0;
    var found = false;
    for (final p in players) {
      final share = p.price / total;
      endFrac = startFrac + share;
      if (p.id == winner.id) {
        found = true;
        break;
      }
      startFrac = endFrac;
    }
    if (!found) {
      throw ArgumentError('winner must be in players list');
    }

    // Land on a random point inside the winner's slice (weighted fairness preserved by pick).
    final t = _random.nextDouble();
    final targetFrac = startFrac + t * (endFrac - startFrac);

    // Chart rotates clockwise. Point at angle θ (from slice layout) ends at θ - R.
    // We want target θ such that after rotation R, winner segment center lands at top (-π/2).
    // θ = -π/2 + 2π * targetFrac  =>  R_end = 2π * targetFrac + 2π * fullTurns
    final fullTurns = 6 + _random.nextInt(4); // 6–8 full rotations
    final endRotation = 2 * pi * fullTurns + 2 * pi * targetFrac;

    return SpinPlan(winner: winner, endRotationRadians: endRotation);
  }
}
