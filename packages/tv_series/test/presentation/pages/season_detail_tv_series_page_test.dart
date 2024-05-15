import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/presentation.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSeasonDetailTvSeriesBloc
    extends MockBloc<SeasonDetailTvSeriesEvent, SeasonDetailTvSeriesState>
    implements SeasonDetailTvSeriesBloc {}

class FakeSeasonDetailTvSeriesEvent extends Fake
    implements SeasonDetailTvSeriesEvent {}

class FakeSeasonDetailTvSeriesState extends Fake
    implements SeasonDetailTvSeriesState {}

void main() {
  late MockSeasonDetailTvSeriesBloc mockSeasonDetailTvSeriesBloc;
  setUpAll(() {
    registerFallbackValue(FakeSeasonDetailTvSeriesEvent());
    registerFallbackValue(FakeSeasonDetailTvSeriesState());
  });
  setUp(() {
    mockSeasonDetailTvSeriesBloc = MockSeasonDetailTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SeasonDetailTvSeriesBloc>.value(
      value: mockSeasonDetailTvSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tId = 1;
  const tSeasonNumber = 1;
  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSeasonDetailTvSeriesBloc.state)
        .thenReturn(SeasonDetailTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SeasonDetailTvSeriesPage(
      id: tId,
      seasonNumber: tSeasonNumber,
    )));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSeasonDetailTvSeriesBloc.state)
        .thenReturn(const SeasonDetailTvSeriesData(tSeasonDetail));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SeasonDetailTvSeriesPage(
      id: tId,
      seasonNumber: tSeasonNumber,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSeasonDetailTvSeriesBloc.state)
        .thenReturn(const SeasonDetailTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const SeasonDetailTvSeriesPage(
      id: tId,
      seasonNumber: tSeasonNumber,
    )));

    expect(textFinder, findsOneWidget);
  });
}
