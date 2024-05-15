import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/domain.dart';
import 'package:movies/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late NowPlayingMovieBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  group('Now Playing Movies', () {
    test('initial state should be empty', () {
      expect(nowPlayingMoviesBloc.state, NowPlayingMovieEmpty());
    });
    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'when data is empty',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieEmpty(),
      ],
      verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
    );
    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieData([testMovie]),
      ],
      verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
    );
    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovie()),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetNowPlayingMovies.execute()),
    );
  });
}
