import 'package:dartz/dartz.dart';
import 'package:ditonton_app/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });
  const tId = 1;

  group('GetTvSeriesDetail Tests execute', () {
    test(
        'should get list of tv series from the repository  when execute function is called',
        () async {
      // arrange
      when(mockTvSeriesRepository.getTvSeriesDetail(tId)).thenAnswer(
          (realInvocation) async => const Right(testTvSeriesDetail));
      // act
      final result = await usecase.execute(tId);
      // assert
      expect(result, const Right(testTvSeriesDetail));
    });
  });
}
