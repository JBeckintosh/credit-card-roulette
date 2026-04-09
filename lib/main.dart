import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/add_player_screen.dart';
import 'screens/home_screen.dart';
import 'screens/players_screen.dart';
import 'screens/roulette_screen.dart';
import 'state/game_state.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/players': (_) => const PlayersScreen(),
        '/add-player': (_) => const AddPlayerScreen(),
        '/roulette': (_) => const RouletteScreen(),
      },
    );
  }
}
