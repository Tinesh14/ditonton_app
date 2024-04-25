import 'dart:convert';

import 'package:ditonton_app/data/data.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3],
    id: 1,
    overview: "Overview",
    popularity: 2.3,
    posterPath: "/path.jpg",
    voteAverage: 8.0,
    voteCount: 230,
    firstAirDate: '2022-10-10',
    originCountry: ["en", "id"],
    originalLanguage: 'Original Language',
    name: 'Name',
    originalName: 'Original Name',
  );
  const tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series/now_playing.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/path.jpg",
            "popularity": 2.3,
            "id": 1,
            "backdrop_path": "/path.jpg",
            "vote_average": 8.0,
            "overview": "Overview",
            "first_air_date": "2022-10-10",
            "origin_country": ["en", "id"],
            "genre_ids": [1, 2, 3],
            "original_language": "Original Language",
            "vote_count": 230,
            "name": "Name",
            "original_name": "Original Name"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
