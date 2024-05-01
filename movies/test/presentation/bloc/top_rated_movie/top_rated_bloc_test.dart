import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/domain.dart';
import 'package:movies/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  group('Top Rated Movies', () {
    test('initial state should be empty', () {
      expect(topRatedMovieBloc.state, TopRatedMovieEmpty());
    });

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'when data is empty',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieEmpty(),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
    );
    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieData([testMovie]),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
    );
    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'when data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
    );
  });
}
