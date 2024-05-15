import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  group('Popular TvSeriess', () {
    test('initial state should be empty', () {
      expect(popularTvSeriesBloc.state, PopularTvSeriesEmpty());
    });
    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'when data is empty',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesEmpty(),
      ],
      verify: (bloc) => verify(mockGetPopularTvSeries.execute()),
    );
    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'when data is gotten succesfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => const Right([testTvSeries]));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesData(const [testTvSeries]),
      ],
      verify: (bloc) => verify(mockGetPopularTvSeries.execute()),
    );
    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'when data is unsuccessful',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        PopularTvSeriesLoading(),
        PopularTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularTvSeries.execute()),
    );
  });
}
