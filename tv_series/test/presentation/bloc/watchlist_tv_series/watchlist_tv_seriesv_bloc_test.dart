import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_seriesv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(mockGetWatchlistTvSeries);
  });

  group('Watchlist TvSeries', () {
    test('initial state should be empty', () {
      expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesEmpty());
    });

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'when data is empty',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesEmpty(),
      ],
      verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
    );
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'when data is gotten succesfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => const Right([testWatchlistTvSeries]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesData(const [testWatchlistTvSeries]),
      ],
      verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
    );
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'when data is unsuccessful',
      build: () {
        when(mockGetWatchlistTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
      expect: () => [
        WatchlistTvSeriesLoading(),
        WatchlistTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetWatchlistTvSeries.execute()),
    );
  });
}
