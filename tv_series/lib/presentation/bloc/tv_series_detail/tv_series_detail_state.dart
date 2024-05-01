part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailState extends Equatable {
  final TvSeriesDetail? tvSeriesDetail;
  final RequestState tvSeriesDetailState;
  final List<TvSeries> tvSeriesRecommendations;
  final RequestState tvSeriesRecommendationsState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const TvSeriesDetailState({
    required this.tvSeriesDetail,
    required this.tvSeriesDetailState,
    required this.tvSeriesRecommendations,
    required this.tvSeriesRecommendationsState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  @override
  List<Object?> get props {
    return [
      tvSeriesDetail,
      tvSeriesDetailState,
      tvSeriesRecommendations,
      tvSeriesRecommendationsState,
      message,
      watchlistMessage,
      isAddedToWatchlist,
    ];
  }

  TvSeriesDetailState copyWith({
    TvSeriesDetail? tvSeriesDetail,
    RequestState? tvSeriesDetailState,
    List<TvSeries>? tvSeriesRecommendations,
    RequestState? tvSeriesRecommendationsState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TvSeriesDetailState(
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      tvSeriesDetailState: tvSeriesDetailState ?? this.tvSeriesDetailState,
      tvSeriesRecommendations:
          tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      tvSeriesRecommendationsState:
          tvSeriesRecommendationsState ?? this.tvSeriesRecommendationsState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  factory TvSeriesDetailState.initial() {
    return const TvSeriesDetailState(
      tvSeriesDetail: null,
      tvSeriesDetailState: RequestState.Empty,
      tvSeriesRecommendations: [],
      tvSeriesRecommendationsState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }
}
