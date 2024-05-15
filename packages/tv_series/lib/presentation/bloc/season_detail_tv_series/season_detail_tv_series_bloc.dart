import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_season_detail_tv_series.dart';

part 'season_detail_tv_series_event.dart';
part 'season_detail_tv_series_state.dart';

class SeasonDetailTvSeriesBloc
    extends Bloc<SeasonDetailTvSeriesEvent, SeasonDetailTvSeriesState> {
  final GetSeasonDetailTvSeries getSeasonDetailTvSeries;

  SeasonDetailTvSeriesBloc(this.getSeasonDetailTvSeries)
      : super(SeasonDetailTvSeriesEmpty()) {
    on<FetchSeasonDetailTvSeries>((event, emit) async {
      emit(SeasonDetailTvSeriesLoading());

      final result = await getSeasonDetailTvSeries.execute(
        event.id,
        event.seasonNumber,
      );

      result.fold(
        (failure) => emit(SeasonDetailTvSeriesError(failure.message)),
        (data) => emit(SeasonDetailTvSeriesData(data)),
      );
    });
  }
}
