import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/domain.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesBloc(this.getNowPlayingTvSeries)
      : super(NowPlayingTvSeriesEmpty()) {
    on<FetchNowPlayingTvSeries>((event, emit) async {
      emit(NowPlayingTvSeriesLoading());
      final result = await getNowPlayingTvSeries.execute();
      result.fold(
        (failure) => emit(NowPlayingTvSeriesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(NowPlayingTvSeriesEmpty());
          } else {
            emit(NowPlayingTvSeriesData(data));
          }
        },
      );
    });
  }
}
