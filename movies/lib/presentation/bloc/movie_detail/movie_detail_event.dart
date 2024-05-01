part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  FetchMovieDetail(this.id);
  @override
  List<Object?> get props => [id];
}

class AddWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  AddWatchlist(this.movieDetail);
  @override
  List<Object?> get props => [movieDetail];
}

class RemoveFromWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  RemoveFromWatchlist(this.movieDetail);
  @override
  List<Object?> get props => [movieDetail];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);
  @override
  List<Object?> get props => [id];
}
