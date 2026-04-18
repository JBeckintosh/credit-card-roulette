import 'package:flutter/material.dart';

import '../models/player.dart';
import '../theme/app_theme.dart';

class PlayerRow extends StatelessWidget {
  const PlayerRow({
    super.key,
    required this.player,
    required this.totalPrice,
    required this.onRemove,
  });

  final Player player;
  final double totalPrice;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final share = totalPrice > 0 ? (player.price / totalPrice) * 100 : 0.0;
    final isMobile = AppLayout.isMobileWidth(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 16, vertical: 6),
      child: ListTile(
        title: Text(
          player.name,
          style: isMobile ? theme.textTheme.titleMedium : theme.textTheme.titleLarge,
        ),
        subtitle: Text(
          '\$${player.price.toStringAsFixed(2)} - ${share.toStringAsFixed(1)}% share',
          style: isMobile ? theme.textTheme.bodyLarge : theme.textTheme.titleMedium,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
            color: theme.colorScheme.error,
          ),
          tooltip: 'Remove player',
          onPressed: onRemove,
        ),
      ),
    );
  }
}
