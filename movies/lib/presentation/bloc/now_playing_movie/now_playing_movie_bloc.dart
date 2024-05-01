import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/domain.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMovieBloc(this.getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<FetchNowPlayingMovie>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) => emit(NowPlayingMovieError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(NowPlayingMovieEmpty());
          } else {
            emit(NowPlayingMovieData(data));
          }
        },
      );
    });
  }
}
