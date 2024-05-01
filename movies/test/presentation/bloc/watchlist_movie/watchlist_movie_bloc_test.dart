import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/domain.dart';
import 'package:movies/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  group('Watchlist Movies', () {
    test('initial state should be empty', () {
      expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'when data is empty',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieEmpty(),
      ],
      verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
    );
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'when data is gotten succesfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieData([testWatchlistMovie]),
      ],
      verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
    );
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'when data is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
    );
  });
}
