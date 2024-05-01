import 'package:core/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail';

  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(FetchMovieDetail(widget.id));
      context.read<MovieDetailBloc>().add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        listenWhen: (previous, current) {
          return previous.watchlistMessage != current.watchlistMessage &&
              current.watchlistMessage != '';
        },
        builder: (context, state) {
          if (state.movieDetailState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.movieDetailState == RequestState.Loaded) {
            final movie = state.movieDetail;
            return SafeArea(
              child: DetailContentMovie(
                movie!,
                state.movieRecommendations,
                state.isAddedToWatchlist,
              ),
            );
          } else if (state.movieDetailState == RequestState.Error) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
        listener: (context, state) {
          final message = state.watchlistMessage;
          if (message == MovieDetailBloc.watchlistAddSuccessMessage ||
              message == MovieDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Text(message),
                );
              },
            );
          }
        },
      ),
    );
  }
}
