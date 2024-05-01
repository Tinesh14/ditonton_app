part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  FetchTvSeriesDetail(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}

class AddWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  AddWatchlist(this.tvSeriesDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [tvSeriesDetail];
  // coverage:ignore-end
}

class RemoveFromWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  RemoveFromWatchlist(this.tvSeriesDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [tvSeriesDetail];
  // coverage:ignore-end
}

class LoadWatchlistStatus extends TvSeriesDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}
