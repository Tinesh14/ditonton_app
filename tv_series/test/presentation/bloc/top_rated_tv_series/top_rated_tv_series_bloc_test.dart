import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
  });

  group('Top Rated TvSeries', () {
    test('initial state should be empty', () {
      expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesEmpty());
    });

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'when data is empty',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesEmpty(),
      ],
      verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
    );
    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => const Right([testTvSeries]));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesData(const [testTvSeries]),
      ],
      verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
    );
    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'when data is unsuccessful',
      build: () {
        when(mockGetTopRatedTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        TopRatedTvSeriesLoading(),
        TopRatedTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTopRatedTvSeries.execute()),
    );
  });
}
