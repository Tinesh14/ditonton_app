import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/domain.dart';
import 'package:movies/presentation/bloc/search_movie/search_movie_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchMovieBloc;
  late MockSearchMovies mockSearchMovies;
  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMovieBloc = SearchMovieBloc(mockSearchMovies);
  });
  const tQuery = 'spiderman';
  group('Search Movie', () {
    test('initial state should be empty', () {
      expect(searchMovieBloc.state, SearchMovieEmpty());
    });

    blocTest<SearchMovieBloc, SearchMovieState>(
      'when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right([testMovie]));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const SearchMovieOnChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieData([testMovie]),
      ],
      verify: (bloc) => verify(mockSearchMovies.execute(tQuery)),
    );
    blocTest<SearchMovieBloc, SearchMovieState>(
      'when data is empty',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => const Right([]));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const SearchMovieOnChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieEmpty(),
      ],
      verify: (bloc) => verify(mockSearchMovies.execute(tQuery)),
    );
    blocTest<SearchMovieBloc, SearchMovieState>(
      'when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(const SearchMovieOnChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchMovieLoading(),
        const SearchMovieError('Server Failure'),
      ],
      verify: (bloc) => verify(mockSearchMovies.execute(tQuery)),
    );
  });
}
