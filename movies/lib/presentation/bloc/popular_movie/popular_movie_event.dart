part of 'popular_movie_bloc.dart';

abstract class PopularMovieEvent extends Equatable {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];
  // coverage:ignore-end
}

class FetchPopularMovie extends PopularMovieEvent {}
