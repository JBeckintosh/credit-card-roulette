import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/player.dart';
import '../services/roulette_service.dart';
import '../state/game_state.dart';
import '../theme/app_theme.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {
  List<Player> _players = [];
  Player? _winner;
  bool _failed = false;

  /// Non-null during countdown: 5, 4, 3, 2, 1.
  int? _countdownValue;
  bool _resultShown = false;
  static const _sectionColors = <Color>[
    Color(0xFFFF8A80), // light red
    Color(0xFFA5D6A7), // light green
    Color(0xFF90CAF9), // light blue
    Color(0xFFFFF59D), // light yellow
    Color(0xFFCE93D8), // light purple
    Color(0xFFFFCC80), // light orange
    Color(0xFF80DEEA), // light cyan
    Color(0xFFF8BBD0), // light pink
    Color(0xFFC5E1A5), // light lime
    Color(0xFFB39DDB), // light indigo
  ];

  static const double _pieSectionRadius = 225.0;
  static const double _winnerSectionRadius = 265.5;
  static const double _centerHoleRadius = 108.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _prepareRound());
  }

  Future<void> _prepareRound() async {
    final game = context.read<GameState>();
    final players = List<Player>.from(game.players);

    if (players.length < 2) {
      if (mounted) {
        setState(() => _failed = true);
        Navigator.of(context).pop();
      }
      return;
    }

    final service = RouletteService();
    final winner = service.pickWeightedWinner(players);

    if (!mounted) {
      return;
    }
    setState(() {
      _players = players;
      _winner = winner;
      _countdownValue = 5;
    });

    for (var n = 4; n >= 1; n--) {
      if (!mounted) {
        return;
      }
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) {
        return;
      }
      setState(() => _countdownValue = n);
    }
    await Future<void>.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }
    game.setWinner(winner.name);
    setState(() {
      _countdownValue = null;
      _resultShown = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_failed || _winner == null || _players.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final winner = _winner!;
    final total = _players.fold<double>(0, (s, p) => s + p.price);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final inCountdown = _countdownValue != null;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final size = math.min(
                          constraints.maxWidth,
                          constraints.maxHeight * 1.3,
                        );
                        return Center(
                          child: SizedBox(
                            width: size,
                            height: size,
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                PieChart(
                                  PieChartData(
                                    startDegreeOffset: -90,
                                    sectionsSpace: 2,
                                    centerSpaceRadius: _centerHoleRadius,
                                    sections: [
                                      for (var i = 0; i < _players.length; i++)
                                        _section(
                                          _players[i],
                                          total,
                                          i,
                                          winner.id,
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: _centerHoleRadius * 2,
                                  height: _centerHoleRadius * 2,
                                  child: Center(
                                    child: AnimatedSwitcher(
                                      duration: AppTokens.motionStandard,
                                      transitionBuilder: (child, animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: inCountdown
                                          ? Text(
                                              '${_countdownValue!}',
                                              key: ValueKey<int>(
                                                _countdownValue!,
                                              ),
                                              style: theme
                                                  .textTheme
                                                  .displayLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w900,
                                                    color: colorScheme.primary,
                                                  ),
                                            )
                                          : const SizedBox(
                                              key: ValueKey<String>(
                                                'no-countdown-center',
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_resultShown) ...[
                    const SizedBox(height: 12),
                    Text(
                      ' Shout out',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      winner.name,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '💕 Thanks for covering the ${total.toStringAsFixed(2)} bill 💕',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 150),
                  ] else ...[
                    const SizedBox(height: 4),
                  ],
                  if (_resultShown) ...[
                    Align(
                      alignment: Alignment.center,
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        child: FilledButton(
                          onPressed: () {
                            context.read<GameState>().clearPlayers();
                            Navigator.of(
                              context,
                            ).pushNamedAndRemoveUntil('/', (route) => false);
                          },
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                          ),
                          child: Text(
                            'Play Again?',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PieChartSectionData _section(
    Player p,
    double total,
    int index,
    String winnerId,
  ) {
    final share = total > 0 ? p.price / total : 0.0;
    final pct = (share * 100).toStringAsFixed(1);
    final isWinner = p.id == winnerId;
    final emphasize = _resultShown && isWinner;

    return PieChartSectionData(
      value: p.price,
      title: '$pct%\n${p.name}',
      radius: emphasize ? _winnerSectionRadius : _pieSectionRadius,
      color: _sectionColors[index % _sectionColors.length],
      borderSide: emphasize
          ? const BorderSide(color: Colors.white, width: 3)
          : BorderSide.none,
      titleStyle: TextStyle(
        fontSize: emphasize ? 20 : 16,
        fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
        color: Colors.white,
        shadows: const [Shadow(blurRadius: 2, color: Colors.black54)],
      ),
    );
  }
}
