part of 'season_detail_tv_series_bloc.dart';

abstract class SeasonDetailTvSeriesState extends Equatable {
  const SeasonDetailTvSeriesState();

  @override
  List<Object?> get props => [];
}

class SeasonDetailTvSeriesEmpty extends SeasonDetailTvSeriesState {}

class SeasonDetailTvSeriesLoading extends SeasonDetailTvSeriesState {}

class SeasonDetailTvSeriesData extends SeasonDetailTvSeriesState {
  final SeasonDetail result;

  const SeasonDetailTvSeriesData(this.result);

  @override
  List<Object?> get props => [result];
}

class SeasonDetailTvSeriesError extends SeasonDetailTvSeriesState {
  final String message;

  const SeasonDetailTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}
