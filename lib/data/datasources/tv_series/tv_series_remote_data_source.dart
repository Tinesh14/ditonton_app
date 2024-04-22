import 'package:http/http.dart' as http;

import '../../models/models.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<List<TvSeriesModel>> searchTvSeries(String query);
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<dynamic>> getNowPlayingTvSeries() {
    // TODO: implement getNowPlayingTvSeries
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getPopularTvSeries() {
    // TODO: implement getPopularTvSeries
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getTopRatedTvSeries() {
    // TODO: implement getTopRatedTvSeries
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getTvSeriesDetail(int id) {
    // TODO: implement getTvSeriesDetail
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> getTvSeriesRecommendations(int id) {
    // TODO: implement getTvSeriesRecommendations
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> searchTvSeries(String query) {
    // TODO: implement searchTvSeries
    throw UnimplementedError();
  }
}
