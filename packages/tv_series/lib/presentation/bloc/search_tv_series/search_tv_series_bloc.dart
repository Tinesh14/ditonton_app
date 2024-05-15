import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv_series/domain/domain.dart';
part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries getSearchTvSeries;
  SearchTvSeriesBloc(this.getSearchTvSeries) : super(SearchTvSeriesEmpty()) {
    on<SearchTvSeriesOnChanged>((event, emit) async {
      emit(SearchTvSeriesLoading());
      final result = await getSearchTvSeries.execute(event.query);
      result.fold(
        (failure) => emit(SearchTvSeriesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(SearchTvSeriesEmpty());
          } else {
            emit(SearchTvSeriesData(data));
          }
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
