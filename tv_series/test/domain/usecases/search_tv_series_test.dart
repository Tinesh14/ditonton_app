import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/domain.dart';
import '../../../../core/lib/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });
  final tTvSeries = <TvSeries>[];
  const tQuery = 'Thrones';
  group('SearchTvSeries Tests execute', () {
    test('should get list of tv series from the repository', () async {
      // arrange
      when(mockTvSeriesRepository.searchTvSeries(tQuery))
          .thenAnswer((_) async => Right(tTvSeries));
      // act
      final result = await usecase.execute(tQuery);
      // assert
      expect(result, Right(tTvSeries));
    });
  });
}
