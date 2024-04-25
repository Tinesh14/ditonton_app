import 'package:dartz/dartz.dart';
import 'package:ditonton_app/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });
  group('RemoveWatchlistTvSeries Tests execute', () {
    test('should remove watchlist tv series from repository', () async {
      // arrange
      when(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Removed from watchlist'));
      // act
      final result = await usecase.execute(testTvSeriesDetail);
      // assert
      verify(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail));
      expect(result, const Right('Removed from watchlist'));
    });
  });
}
