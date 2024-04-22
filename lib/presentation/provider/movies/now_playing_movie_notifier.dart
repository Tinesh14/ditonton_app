import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../domain/domain.dart';

class NowPlayingMoviesNotifier extends ChangeNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesNotifier(this.getNowPlayingMovies);

  var _movies = <Movie>[];
  List<Movie> get movies => _movies;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movieData) {
        _state = RequestState.Loaded;
        _movies = movieData;
        notifyListeners();
      },
    );
  }
}
