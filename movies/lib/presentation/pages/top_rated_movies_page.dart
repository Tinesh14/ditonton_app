import 'package:core/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedMovieBloc>().add(FetchTopRatedMovie()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, state) {
            if (state is TopRatedMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMovieData) {
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
            } else if (state is TopRatedMovieError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is TopRatedMovieEmpty) {
              return const Center(
                child: Text('Emmpty Data'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
