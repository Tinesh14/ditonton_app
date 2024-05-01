// ignore_for_file: constant_identifier_names

import 'package:core/common/common.dart';
import 'package:core/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

import '../presentation.dart';

class SearchMoviePage extends StatelessWidget {
  static const routeName = '/search-movie';

  const SearchMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                context
                    .read<SearchMovieBloc>()
                    .add(SearchMovieOnChanged(value));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchMovieBloc, SearchMovieState>(
              builder: (context, state) {
                if (state is SearchMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchMovieData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
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
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchMovieEmpty) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Search Not Found', style: kSubtitle),
                        ],
                      ),
                    ),
                  );
                } else if (state is SearchMovieError) {
                  return Expanded(
                    child: Center(
                      key: const Key('error_message'),
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
