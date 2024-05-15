import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/domain.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieBloc(this.getPopularMovies) : super(PopularMovieEmpty()) {
    on<FetchPopularMovie>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) => emit(PopularMovieError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(PopularMovieEmpty());
          } else {
            emit(PopularMovieData(data));
          }
        },
      );
    });
  }
}
