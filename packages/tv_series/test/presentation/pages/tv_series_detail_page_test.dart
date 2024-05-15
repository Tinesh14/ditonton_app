import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:core/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/presentation.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailTvSeriesBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class FakeDetailTvSeriesEvent extends Fake implements TvSeriesDetailEvent {}

class FakeDetailTvSeriesState extends Fake implements TvSeriesDetailState {}

void main() {
  late MockDetailTvSeriesBloc mockDetailTvSeriesBloc;
  setUpAll(() {
    registerFallbackValue(FakeDetailTvSeriesEvent());
    registerFallbackValue(FakeDetailTvSeriesState());
  });
  setUp(() {
    mockDetailTvSeriesBloc = MockDetailTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesDetailBloc>.value(
      value: mockDetailTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when tvSeries not added to watchlist',
    (WidgetTester tester) async {
      when(() => mockDetailTvSeriesBloc.state).thenReturn(
        TvSeriesDetailState.initial().copyWith(
          tvSeriesDetailState: RequestState.Loaded,
          tvSeriesDetail: testTvSeriesDetail,
          tvSeriesRecommendationsState: RequestState.Loaded,
          tvSeriesRecommendations: <TvSeries>[],
          isAddedToWatchlist: false,
        ),
      );

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester
          .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should dispay check icon when tvSeries is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state).thenReturn(
      TvSeriesDetailState.initial().copyWith(
        tvSeriesDetailState: RequestState.Loaded,
        tvSeriesDetail: testTvSeriesDetail,
        tvSeriesRecommendationsState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets('Watchlist should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
      mockDetailTvSeriesBloc,
      Stream.fromIterable([
        TvSeriesDetailState.initial().copyWith(
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState.initial().copyWith(
          isAddedToWatchlist: false,
          watchlistMessage: 'Added to Watchlist',
        ),
      ]),
      initialState: TvSeriesDetailState.initial(),
    );

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byType(SnackBar), findsNothing);
    expect(find.text('Added to Watchlist'), findsNothing);

    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
      mockDetailTvSeriesBloc,
      Stream.fromIterable([
        TvSeriesDetailState.initial().copyWith(
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState.initial().copyWith(
          isAddedToWatchlist: false,
          watchlistMessage: 'Failed',
        ),
      ]),
      initialState: TvSeriesDetailState.initial(),
    );
    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Failed '), findsNothing);

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
