part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;

  FetchMovieDetail(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}

class AddWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  AddWatchlist(this.movieDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [movieDetail];
  // coverage:ignore-end
}

class RemoveFromWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  RemoveFromWatchlist(this.movieDetail);
  // coverage:ignore-start
  @override
  List<Object?> get props => [movieDetail];
  // coverage:ignore-end
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);
  // coverage:ignore-start
  @override
  List<Object?> get props => [id];
  // coverage:ignore-end
}
