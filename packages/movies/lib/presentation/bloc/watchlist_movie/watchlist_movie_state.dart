part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieData extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistMovieData(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object?> get props => [message];
}