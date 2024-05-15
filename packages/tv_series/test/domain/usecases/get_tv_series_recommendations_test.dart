import 'package:core/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/domain.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });
  final tTvSeries = <TvSeries>[];
  const tId = 1;
  group('GetTvSeriesRecommendations Tests execute', () {
    test(
        'should get list of tv series from the repository  when execute function is called',
        () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => Right(tTvSeries));
      // act
      final result = await usecase.execute(tId);
      // assert
      expect(result, Right(tTvSeries));
    });
  });
}
