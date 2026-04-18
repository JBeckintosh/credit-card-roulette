import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Landing page with title and [Start Game].
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = AppLayout.isMobileWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            isMobile
                ? AppLayout.mobilePagePadding
                : AppLayout.desktopPagePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              Text(
                'Credit Card Roulette',
                textAlign: TextAlign.center,
                style: (isMobile
                        ? theme.textTheme.displayMedium
                        : theme.textTheme.displayLarge)
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: AppTokens.spaceM),
              Text(
                'Whoever the wheel picks, pays.',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(flex: 3),
              Align(
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: isMobile ? 0.78 : 0.5,
                  child: FilledButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/players'),
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(
                        isMobile
                            ? AppLayout.mobileButtonHeight
                            : AppLayout.desktopButtonHeight,
                      ),
                    ),
                    child: Text(
                      'Add Players!',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppTokens.spaceL),
            ],
          ),
        ),
      ),
    );
  }
}
