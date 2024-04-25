import 'package:ditonton_app/data/data.dart';
import 'package:ditonton_app/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
    firstAirDate: '',
    originCountry: [],
    originalLanguage: '',
    name: '',
    originalName: '',
  );

  const tTvSeries = TvSeries(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
    firstAirDate: '',
    originCountry: [],
    originalLanguage: '',
    name: '',
    originalName: '',
  );

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
