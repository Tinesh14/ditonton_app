import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/domain.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMovieBloc(this.getWatchlistMovies) : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistMovieError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(WatchlistMovieEmpty());
          } else {
            emit(WatchlistMovieData(data));
          }
        },
      );
    });
  }
}
