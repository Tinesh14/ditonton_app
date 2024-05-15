import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
])
void main() {
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesBloc = NowPlayingTvSeriesBloc(mockGetNowPlayingTvSeries);
  });

  group('Now Playing TvSeriess', () {
    test('initial state should be empty', () {
      expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesEmpty());
    });
    blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'when data is empty',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => const Right([]));
        return nowPlayingTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        NowPlayingTvSeriesLoading(),
        NowPlayingTvSeriesEmpty(),
      ],
      verify: (bloc) => verify(mockGetNowPlayingTvSeries.execute()),
    );
    blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => const Right([testTvSeries]));
        return nowPlayingTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        NowPlayingTvSeriesLoading(),
        NowPlayingTvSeriesData(const [testTvSeries]),
      ],
      verify: (bloc) => verify(mockGetNowPlayingTvSeries.execute()),
    );
    blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
      'when data is unsuccessful',
      build: () {
        when(mockGetNowPlayingTvSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingTvSeriesBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingTvSeries()),
      expect: () => [
        NowPlayingTvSeriesLoading(),
        NowPlayingTvSeriesError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetNowPlayingTvSeries.execute()),
    );
  });
}
