import 'package:core/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton_app/main.dart' as app;

import 'package:integration_test/integration_test.dart';

void main() {
  group('Testing App', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    final watchlistButton = find.byKey(const Key('watchlistButton'));
    final iconCheck = find.byIcon(Icons.check);
    final iconBack = find.byKey(const Key('iconBack'));
    final iconMenuWatchlist = find.byIcon(Icons.remove_red_eye);

    testWidgets('Verify watchlist', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // click movie item
      final movieItem = find.byKey(const Key('movieItem')).first;
      await tester.tap(movieItem);
      await tester.pumpAndSettle();

      // click watchlist button
      await tester.tap(watchlistButton);
      await tester.pumpAndSettle();
      expect(iconCheck, findsOneWidget);

      // back to home page
      await tester.tap(iconBack);
      await tester.pumpAndSettle();

      // click watchlist menu in home page
      await tester.tap(iconMenuWatchlist);
      await tester.pumpAndSettle();

      // check save movie item in watchlist page
      expect(find.byType(CardList), findsOneWidget);

      // click tv series menu
      final iconMenuTvSeries = find.byIcon(Icons.live_tv_outlined);
      await tester.tap(iconMenuTvSeries);
      await tester.pumpAndSettle();

      // click tv series item
      final tvSeriesItem = find.byKey(const Key('tvSeriesItem')).first;
      await tester.tap(tvSeriesItem);
      await tester.pumpAndSettle();

      // click watchlist button
      await tester.tap(watchlistButton);
      await tester.pumpAndSettle();
      expect(iconCheck, findsOneWidget);

      // back to home page
      await tester.tap(iconBack);
      await tester.pumpAndSettle();

      // click watchlist menu in home page
      await tester.tap(iconMenuWatchlist);
      await tester.pumpAndSettle();

      // check save tv series item in watchlist page
      await tester.tap(find.byKey(const Key('tabTvSeriesWatchlist')));
      await tester.pumpAndSettle();
      expect(find.byType(CardList), findsOneWidget);
    });
  });
}
