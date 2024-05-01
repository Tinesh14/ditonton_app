import 'package:core/common/common.dart';
import 'package:core/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/domain.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchListStatusTvSeries getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvSeriesDetailState.initial()) {
    on<FetchTvSeriesDetail>((event, emit) async {
      emit(state.copyWith(tvSeriesDetailState: RequestState.Loading));

      final id = event.id;

      final detailTvSeriesResult = await getTvSeriesDetail.execute(id);
      final recommendationTvSeriessResult =
          await getTvSeriesRecommendations.execute(id);

      detailTvSeriesResult.fold(
        (failure) => emit(
          state.copyWith(
            tvSeriesDetailState: RequestState.Error,
            message: failure.message,
          ),
        ),
        (tvSeriesDetail) {
          emit(
            state.copyWith(
              tvSeriesRecommendationsState: RequestState.Loading,
              tvSeriesDetailState: RequestState.Loaded,
              tvSeriesDetail: tvSeriesDetail,
            ),
          );
          recommendationTvSeriessResult.fold(
            (failure) => emit(
              state.copyWith(
                tvSeriesRecommendationsState: RequestState.Error,
                message: failure.message,
              ),
            ),
            (tvSeriesRecommendations) {
              if (tvSeriesRecommendations.isEmpty) {
                emit(
                  state.copyWith(
                    tvSeriesRecommendationsState: RequestState.Empty,
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    tvSeriesRecommendationsState: RequestState.Loaded,
                    tvSeriesRecommendations: tvSeriesRecommendations,
                  ),
                );
              }
            },
          );
        },
      );
    });

    on<AddWatchlist>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;
      final result = await saveWatchlist.execute(tvSeriesDetail);

      result.fold(
        (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
        (successMessage) =>
            emit(state.copyWith(watchlistMessage: successMessage)),
      );

      add(LoadWatchlistStatus(tvSeriesDetail.id));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;
      final result = await removeWatchlist.execute(tvSeriesDetail);

      result.fold(
        (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
        (successMessage) =>
            emit(state.copyWith(watchlistMessage: successMessage)),
      );

      add(LoadWatchlistStatus(tvSeriesDetail.id));
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final status = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: status));
    });
  }
}
