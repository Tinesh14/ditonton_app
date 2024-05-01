part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTvSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  FetchTvSeriesDetail(this.id);
  @override
  List<Object?> get props => [id];
}

class AddWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  AddWatchlist(this.tvSeriesDetail);
  @override
  List<Object?> get props => [tvSeriesDetail];
}

class RemoveFromWatchlist extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeriesDetail;

  RemoveFromWatchlist(this.tvSeriesDetail);
  @override
  List<Object?> get props => [tvSeriesDetail];
}

class LoadWatchlistStatus extends TvSeriesDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);
  @override
  List<Object?> get props => [id];
}
