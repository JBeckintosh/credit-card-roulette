import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:credit_card_roulette/main.dart';
import 'package:credit_card_roulette/state/game_state.dart';

void main() {
  testWidgets('Home screen shows title and Start Game', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GameState(),
        child: const CreditCardRouletteApp(),
      ),
    );

    expect(find.text('Credit Card Roulette'), findsOneWidget);
    expect(find.text('Start Game'), findsOneWidget);
  });
}
