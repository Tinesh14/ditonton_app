import 'package:core/common/common.dart';
import 'package:core/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetPopularTvSeries {
  final TvSeriesRepository repository;

  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopularTvSeries();
  }
}
