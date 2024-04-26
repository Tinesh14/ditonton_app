import 'package:dartz/dartz.dart';
import 'package:ditonton_app/common/common.dart';
import 'package:ditonton_app/domain/domain.dart';
import 'package:ditonton_app/presentation/presentation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    notifier = NowPlayingTvSeriesNotifier(mockGetNowPlayingTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });
  const tTvSeries = TvSeries(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: [10765, 10759, 18],
    id: 1399,
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    voteAverage: 7.91,
    voteCount: 1172,
    firstAirDate: '2011-04-17',
    originCountry: ["US"],
    originalLanguage: 'en',
    name: 'Game of Thrones',
    originalName: 'Game of Thrones',
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing Tv Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      notifier.fetchNowPlayingTvSeries();
      // assert
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });
    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await notifier.fetchNowPlayingTvSeries();
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.tvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await notifier.fetchNowPlayingTvSeries();
      // assert
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
