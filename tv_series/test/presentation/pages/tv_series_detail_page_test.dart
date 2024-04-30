import 'package:core/common/common.dart';
import 'package:core/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/presentation.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailNotifier])
void main() {
  late MockTvSeriesDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesDetailNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when tv series not added to watchlist',
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.tvSeriesRecommendationsState)
          .thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display check icon when tv series is added to watchlist',
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.tvSeriesRecommendationsState)
          .thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when tv series is added to watchlist',
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.tvSeriesRecommendationsState)
          .thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');
      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when tv series add to watchlist failed',
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.tvSeriesRecommendationsState)
          .thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');
      final watchlistButton = find.byType(ElevatedButton);

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );
}
