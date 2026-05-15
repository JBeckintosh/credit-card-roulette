import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/game_state.dart';
import '../theme/app_theme.dart';
import '../widgets/player_row.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  static const _currencyOptions = <String>['£', r'$', '€', '¥'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = AppLayout.isMobileWidth(context);

    return Scaffold(
      body: Consumer<GameState>(
        builder: (context, game, _) {
          final players = game.players;
          final total = game.totalPrice;

          return Column(
            children: [              
              const SizedBox(height: AppTokens.spaceXL),
              Expanded(
                child: players.isEmpty
                    ? Center(
                        child: Text(
                          'No players yet.\n\nTap + to add a player.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(
                          top: isMobile ? 20 : 28,
                          bottom: isMobile ? 4 : 8,
                        ),
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          final p = players[index];
                          return PlayerRow(
                            player: p,
                            totalPrice: total,
                            amountText: game.formatAmount(p.price),
                            onRemove: () => game.removePlayer(p.id),
                          );
                        },
                      ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppTokens.spaceM,
                    isMobile ? 6 : AppTokens.spaceS,
                    AppTokens.spaceM,
                    isMobile ? AppTokens.spaceS : AppTokens.spaceM,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'The bill: ${game.formatAmount(total)}',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Are you ready to risk it all?',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: game.selectedCurrency,
                              decoration: const InputDecoration(
                                labelText: 'Currency',
                              ),
                              hint: const Text('Select currency (optional)'),
                              items: _currencyOptions
                                  .map(
                                    (currency) => DropdownMenuItem<String>(
                                      value: currency,
                                      child: Text(currency),
                                    ),
                                  )
                                  .toList(),
                              onChanged: game.setSelectedCurrency,
                            ),
                          ),
                          SizedBox(width: isMobile ? 12 : 16),
                          SizedBox(
                            width: isMobile ? 62 : 72,
                            height: isMobile ? 62 : 72,
                            child: FilledButton(
                              onPressed: () =>
                                  Navigator.of(context).pushNamed('/add-player'),
                              style: FilledButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: EdgeInsets.zero,
                              ),
                              child: Icon(
                                Icons.add,
                                size: isMobile ? 30 : 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 24 : 40),
                      Align(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: isMobile ? 0.78 : 0.5,
                          child: FilledButton(
                            onPressed: game.canPlayRoulette
                                ? () => Navigator.of(
                                    context,
                                  ).pushNamed('/roulette')
                                : null,
                            style: FilledButton.styleFrom(
                              minimumSize: Size.fromHeight(
                                isMobile
                                    ? AppLayout.mobileButtonHeight
                                    : AppLayout.desktopButtonHeight,
                              ),
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
                      SizedBox(height: isMobile ? 14 : 22),
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
