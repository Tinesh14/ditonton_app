import 'package:dartz/dartz.dart';
import 'package:ditonton_app/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
  });
  group('SaveWatchlistTvSeries Tests execute', () {
    test('should save tv series to the repository', () async {
      // arrange
      when(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => const Right('Added to watchlist'));
      // act
      final result = await usecase.execute(testTvSeriesDetail);
      // assert
      verify(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail));
      expect(result, const Right('Added to watchlist'));
    });
  });
}
