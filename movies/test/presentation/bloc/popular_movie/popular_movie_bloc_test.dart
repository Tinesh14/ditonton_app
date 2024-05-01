import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/domain.dart';
import 'package:movies/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  group('Popular Movies', () {
    test('initial state should be empty', () {
      expect(popularMovieBloc.state, PopularMovieEmpty());
    });
    blocTest<PopularMovieBloc, PopularMovieState>(
      'when data is empty',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieEmpty(),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()),
    );
    blocTest<PopularMovieBloc, PopularMovieState>(
      'when data is gotten succesfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieData([testMovie]),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()),
    );
    blocTest<PopularMovieBloc, PopularMovieState>(
      'when data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()),
    );
  
  });
}
