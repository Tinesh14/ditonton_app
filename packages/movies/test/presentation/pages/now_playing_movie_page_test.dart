import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/presentation.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingMovieBloc
    extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState>
    implements NowPlayingMovieBloc {}

class FakeNowPlayingMovieEvent extends Fake implements NowPlayingMovieEvent {}

class FakeNowPlayingMovieState extends Fake implements NowPlayingMovieState {}

void main() {
  late MockNowPlayingMovieBloc mockNowPlayingMovieBloc;
  setUpAll(() {
    registerFallbackValue(FakeNowPlayingMovieEvent());
    registerFallbackValue(FakeNowPlayingMovieState());
  });
  setUp(() {
    mockNowPlayingMovieBloc = MockNowPlayingMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingMovieBloc>.value(
      value: mockNowPlayingMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviePage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieData([testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingMoviePage()));

    expect(textFinder, findsOneWidget);
  });


}
