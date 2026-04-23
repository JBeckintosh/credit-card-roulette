import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'screens/add_player_screen.dart';
import 'screens/home_screen.dart';
import 'screens/players_screen.dart';
import 'screens/roulette_screen.dart';
import 'screens/terms_and_conditions_screen.dart';
import 'state/game_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameState(),
      child: const CreditCardRouletteApp(),
    ),
  );
}

class CreditCardRouletteApp extends StatelessWidget {
  const CreditCardRouletteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Roulette',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      builder: (context, child) => _WebPhoneFrame(child: child),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/players': (_) => const PlayersScreen(),
        '/add-player': (_) => const AddPlayerScreen(),
        '/roulette': (_) => const RouletteScreen(),
        '/terms': (_) => const TermsAndConditionsScreen(),
      },
    );
  }
}

class _WebPhoneFrame extends StatelessWidget {
  const _WebPhoneFrame({required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final content = child ?? const SizedBox.shrink();
    final isSmallMobile = kIsWeb && AppLayout.isMobileWidth(context);

    if (!isSmallMobile) {
      return content;
    }

    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surface,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppLayout.phoneOuterPadding),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppLayout.phoneFrameMaxWidth,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(AppTokens.radiusL),
                border: Border.all(color: scheme.outlineVariant, width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: Offset(0, 10),
                    color: Color(0x22000000),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTokens.radiusL),
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
