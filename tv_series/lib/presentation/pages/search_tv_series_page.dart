import 'package:core/common/common.dart';
import 'package:core/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class SearchTvSeriesPage extends StatelessWidget {
  static const routeName = '/search-tv-series';

  const SearchTvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                context
                    .read<SearchTvSeriesBloc>()
                    .add(SearchTvSeriesOnChanged(value));
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
            BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
              builder: (context, state) {
                if (state is SearchTvSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvSeriesData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvSeries = result[index];
                        return CardList(
                          title: tvSeries.name ?? '',
                          posterPath: tvSeries.posterPath ?? '',
                          overview: tvSeries.overview ?? '',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              TvSeriesDetailPage.routeName,
                              arguments: tvSeries.id,
                            );
                          },
                        );
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchTvSeriesEmpty) {
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
                } else if (state is SearchTvSeriesError) {
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
