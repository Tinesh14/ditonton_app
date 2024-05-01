part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularTvSeriesEmpty extends PopularTvSeriesState {}

class PopularTvSeriesLoading extends PopularTvSeriesState {}

class PopularTvSeriesData extends PopularTvSeriesState {
  final List<TvSeries> result;

  PopularTvSeriesData(this.result);

  @override
  List<Object?> get props => [result];
}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String message;

  PopularTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}