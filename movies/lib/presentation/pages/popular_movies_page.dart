import 'package:core/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class PopularMoviesPage extends StatefulWidget {
  static const routeName = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularMovieBloc>().add(FetchPopularMovie()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
            if (state is PopularMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMovieData) {
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
            } else if (state is PopularMovieError) {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            } else {
              return const Center(
                child: Text('Empty Data'),
              );
            }
          },
        ),
      ),
    );
  }
}
