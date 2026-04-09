import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/game_state.dart';
import '../widgets/player_row.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Consumer<GameState>(
        builder: (context, game, _) {
          final players = game.players;
          final total = game.totalPrice;

          return Column(
            children: [
              Expanded(
                child: players.isEmpty
                    ? Center(
                        child: Text(
                          'No players yet.\n\nTap + to add someone.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          final p = players[index];
                          return PlayerRow(
                            player: p,
                            totalPrice: total,
                            onRemove: () => game.removePlayer(p.id),
                          );
                        },
                      ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 72,
                          height: 72,
                          child: FilledButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed('/add-player'),
                            style: FilledButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Icon(Icons.add, size: 36),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: 0.5,
                          child: FilledButton(
                            onPressed: game.canPlayRoulette
                            ? () => Navigator.of(context)
                                .pushNamed('/roulette')
                            : null,
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(68),
                            ),
                            child: Text(
                              'Roulette!',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
