import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/domain.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;
  PopularTvSeriesBloc(this.getPopularTvSeries) : super(PopularTvSeriesEmpty()) {
    on<FetchPopularTvSeries>((event, emit) async {
      emit(PopularTvSeriesLoading());
      final result = await getPopularTvSeries.execute();
      result.fold(
        (failure) => emit(PopularTvSeriesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(PopularTvSeriesEmpty());
          } else {
            emit(PopularTvSeriesData(data));
          }
        },
      );
    });
  }
}
