import 'package:dartz/dartz.dart';
import 'package:ditonton_app/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockTvSeriesRepository);
  });
  final tTvSeries = <TvSeries>[];
  group('GetNowPlayingTvSeries Tests execute', () {
    test('should get list of tv series from the repository', () async {
      // arrange
      when(mockTvSeriesRepository.getNowPlayingTvSeries())
          .thenAnswer((_) async => Right(tTvSeries));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tTvSeries));
    });
  });
}
