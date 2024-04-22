// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/pages/movie_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as i11;
import 'dart:ui' as i12;

import 'package:ditonton_app/common/state_enum.dart' as i9;
import 'package:ditonton_app/domain/entities/movie.dart' as i10;
import 'package:ditonton_app/domain/entities/movie_detail.dart' as i7;
import 'package:ditonton_app/domain/usecases/movie.dart/get_movie_detail.dart' as i2;
import 'package:ditonton_app/domain/usecases/movie.dart/get_movie_recommendations.dart'
    as i3;
import 'package:ditonton_app/domain/usecases/movie.dart/get_watchlist_status.dart' as i4;
import 'package:ditonton_app/domain/usecases/movie.dart/remove_watchlist.dart' as i6;
import 'package:ditonton_app/domain/usecases/movie.dart/save_watchlist.dart' as i5;
import 'package:ditonton_app/presentation/provider/movies/movie_detail_notifier.dart'
    as i8;
import 'package:mockito/mockito.dart' as i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeGetMovieDetail extends i1.Fake implements i2.GetMovieDetail {}

class _FakeGetMovieRecommendations extends i1.Fake
    implements i3.GetMovieRecommendations {}

class _FakeGetWatchListStatus extends i1.Fake
    implements i4.GetWatchListStatus {}

class _FakeSaveWatchlist extends i1.Fake implements i5.SaveWatchlist {}

class _FakeRemoveWatchlist extends i1.Fake implements i6.RemoveWatchlist {}

class _FakeMovieDetail extends i1.Fake implements i7.MovieDetail {}

/// A class which mocks [MovieDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailNotifier extends i1.Mock
    implements i8.MovieDetailNotifier {
  MockMovieDetailNotifier() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.GetMovieDetail get getMovieDetail =>
      (super.noSuchMethod(Invocation.getter(#getMovieDetail),
          returnValue: _FakeGetMovieDetail()) as i2.GetMovieDetail);
  @override
  i3.GetMovieRecommendations get getMovieRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getMovieRecommendations),
              returnValue: _FakeGetMovieRecommendations())
          as i3.GetMovieRecommendations);
  @override
  i4.GetWatchListStatus get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
          returnValue: _FakeGetWatchListStatus()) as i4.GetWatchListStatus);
  @override
  i5.SaveWatchlist get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
          returnValue: _FakeSaveWatchlist()) as i5.SaveWatchlist);
  @override
  i6.RemoveWatchlist get removeWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlist),
          returnValue: _FakeRemoveWatchlist()) as i6.RemoveWatchlist);
  @override
  i7.MovieDetail get movie => (super.noSuchMethod(Invocation.getter(#movie),
      returnValue: _FakeMovieDetail()) as i7.MovieDetail);
  @override
  i9.RequestState get movieState =>
      (super.noSuchMethod(Invocation.getter(#movieState),
          returnValue: i9.RequestState.Empty) as i9.RequestState);
  @override
  List<i10.Movie> get movieRecommendations =>
      (super.noSuchMethod(Invocation.getter(#movieRecommendations),
          returnValue: <i10.Movie>[]) as List<i10.Movie>);
  @override
  i9.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: i9.RequestState.Empty) as i9.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatchlist =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlist),
          returnValue: false) as bool);
  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  i11.Future<void> fetchMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#fetchMovieDetail, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as i11.Future<void>);
  @override
  i11.Future<void> addWatchlist(i7.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [movie]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as i11.Future<void>);
  @override
  i11.Future<void> removeFromWatchlist(i7.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlist, [movie]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as i11.Future<void>);
  @override
  i11.Future<void> loadWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as i11.Future<void>);
  @override
  void addListener(i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
