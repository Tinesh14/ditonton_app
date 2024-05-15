import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/domain.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies getSearchMovies;
  SearchMovieBloc(this.getSearchMovies) : super(SearchMovieEmpty()) {
    on<SearchMovieOnChanged>((event, emit) async {
      emit(SearchMovieLoading());
      final result = await getSearchMovies.execute(event.query);
      result.fold(
        (failure) => emit(SearchMovieError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(SearchMovieEmpty());
          } else {
            emit(SearchMovieData(data));
          }
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
