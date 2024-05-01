import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/domain.dart';
import 'package:movies/presentation/presentation.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      getWatchListStatus: mockGetWatchlistStatus,
    );
  });

  const tId = 1;

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'get detail movie and recommendation movies success',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.Loading,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Loaded,
          movieRecommendations: testMovieList,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'get detail movie failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'get recommendation movies empty',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Right([]));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.Loading,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Empty,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'get recommendation movies failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.Loading,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.Error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });
  group('Watchlist Status Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'WatchlistStatus is true',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) => verify(mockGetWatchlistStatus.execute(tId)),
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'WatchlistStatus is false',
      build: () {
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) => verify(mockGetWatchlistStatus.execute(tId)),
    );
  });
  group('Save Watchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'when success added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
        ),
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'when failed added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      },
    );
  });
  group('Remove Watchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'when success removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'when failed removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(testMovieDetail.id));
      },
    );
  });
}
