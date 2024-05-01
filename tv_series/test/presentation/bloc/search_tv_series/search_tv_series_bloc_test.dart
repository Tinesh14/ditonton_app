import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesBloc searchTvSeriesBloc;
  late MockSearchTvSeries mockSearchTvSeries;
  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesBloc = SearchTvSeriesBloc(mockSearchTvSeries);
  });
  const tQuery = 'Thrones';
  group('Search TvSeries', () {
    test('initial state should be empty', () {
      expect(searchTvSeriesBloc.state, SearchTvSeriesEmpty());
    });

    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'when data is gotten successfully',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => const Right([testTvSeries]));
        return searchTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const SearchTvSeriesOnChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvSeriesLoading(),
        const SearchTvSeriesData([testTvSeries]),
      ],
      verify: (bloc) => verify(mockSearchTvSeries.execute(tQuery)),
    );
    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'when data is empty',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => const Right([]));
        return searchTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const SearchTvSeriesOnChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvSeriesLoading(),
        SearchTvSeriesEmpty(),
      ],
      verify: (bloc) => verify(mockSearchTvSeries.execute(tQuery)),
    );
    blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
      'when get search is unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return searchTvSeriesBloc;
      },
      act: (bloc) => bloc.add(const SearchTvSeriesOnChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvSeriesLoading(),
        const SearchTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockSearchTvSeries.execute(tQuery)),
    );
  });
}
