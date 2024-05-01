import 'package:core/common/common.dart';
import 'package:core/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchlistMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMovieData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return CardList(
                    title: movie.title ?? '',
                    posterPath: movie.posterPath ?? '',
                    overview: movie.overview ?? '',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MovieDetailPage.routeName,
                        arguments: movie.id,
                      );
                    },
                  );
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistMovieError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is WatchlistMovieEmpty) {
              return const Center(
                child: Text('Empty Data'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
