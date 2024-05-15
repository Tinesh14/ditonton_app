import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/domain.dart';
import 'package:tv_series/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'season_detail_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetSeasonDetailTvSeries])
void main() {
  late SeasonDetailTvSeriesBloc seasonDetailBloc;
  late MockGetSeasonDetailTvSeries mockGetSeasonDetailTvSeries;

  setUp(() {
    mockGetSeasonDetailTvSeries = MockGetSeasonDetailTvSeries();
    seasonDetailBloc = SeasonDetailTvSeriesBloc(mockGetSeasonDetailTvSeries);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  group('Season Detail TvSeries', () {
    test('initial state should be empty', () {
      expect(seasonDetailBloc.state, SeasonDetailTvSeriesEmpty());
    });

    blocTest<SeasonDetailTvSeriesBloc, SeasonDetailTvSeriesState>(
      'when data is gotten successfully',
      build: () {
        when(mockGetSeasonDetailTvSeries.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => const Right(tSeasonDetail));
        return seasonDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchSeasonDetailTvSeries(
        id: tId,
        seasonNumber: tSeasonNumber,
      )),
      expect: () => [
        SeasonDetailTvSeriesLoading(),
        const SeasonDetailTvSeriesData(tSeasonDetail),
      ],
      verify: (bloc) =>
          verify(mockGetSeasonDetailTvSeries.execute(tId, tSeasonNumber)),
    );

    blocTest<SeasonDetailTvSeriesBloc, SeasonDetailTvSeriesState>(
      'when get detail season is unsuccessful',
      build: () {
        when(mockGetSeasonDetailTvSeries.execute(tId, tSeasonNumber))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
        return seasonDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchSeasonDetailTvSeries(
        id: tId,
        seasonNumber: tSeasonNumber,
      )),
      expect: () => [
        SeasonDetailTvSeriesLoading(),
        const SeasonDetailTvSeriesError('Server Failure'),
      ],
      verify: (bloc) =>
          verify(mockGetSeasonDetailTvSeries.execute(tId, tSeasonNumber)),
    );
  });
}
