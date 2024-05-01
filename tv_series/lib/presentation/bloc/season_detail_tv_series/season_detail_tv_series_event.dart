part of 'season_detail_tv_series_bloc.dart';

abstract class SeasonDetailTvSeriesEvent extends Equatable {
  const SeasonDetailTvSeriesEvent();
  @override
  List<Object?> get props => [];
}

class FetchSeasonDetailTvSeries extends SeasonDetailTvSeriesEvent {
  final int id;
  final int seasonNumber;

  const FetchSeasonDetailTvSeries({
    required this.id,
    required this.seasonNumber,
  });
  @override
  List<Object?> get props => [id, seasonNumber];
}
