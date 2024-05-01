import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/presentation.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchMovieBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

class FakeSearchMovieEvent extends Fake implements SearchMovieEvent {}

class FakeSearchMovieState extends Fake implements SearchMovieState {}

void main() {
  late MockSearchMovieBloc mockSearchMovieBloc;
  setUpAll(() {
    registerFallbackValue(FakeSearchMovieEvent());
    registerFallbackValue(FakeSearchMovieState());
  });
  setUp(() {
    mockSearchMovieBloc = MockSearchMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieBloc>.value(
      value: mockSearchMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state).thenReturn(SearchMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state)
        .thenReturn(SearchMovieData([testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchMovieBloc.state)
        .thenReturn(const SearchMovieError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

    expect(textFinder, findsOneWidget);
  });
}
