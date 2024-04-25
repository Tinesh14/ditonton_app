import 'package:ditonton_app/domain/domain.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });
  final tTvSeries = <TvSeries>[];

  group('GetPopularTvSeries Tests execute', () {
    test(
        'should get list of tv series from the repository  when execute function is called',
        () async {
      // arrange
      when(mockTvSeriesRepository.getPopularTvSeries())
          .thenAnswer((_) async => Right(tTvSeries));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tTvSeries));
    });
  });
}
