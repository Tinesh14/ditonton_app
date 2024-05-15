part of 'season_detail_tv_series_bloc.dart';

abstract class SeasonDetailTvSeriesEvent extends Equatable {
  const SeasonDetailTvSeriesEvent();
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchSeasonDetailTvSeries extends SeasonDetailTvSeriesEvent {
  final int id;
  final int seasonNumber;

  const FetchSeasonDetailTvSeries({
    required this.id,
    required this.seasonNumber,
  });
  // coverage:ignore-start
  @override
  List<Object?> get props => [id, seasonNumber];
  // coverage:ignore-end
}
