import 'package:core/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const routeName = '/top-rated-tv-series';

  const TopRatedTvSeriesPage({super.key});

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedTvSeriesBloc>().add(FetchTopRatedTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
            builder: (context, state) {
              if (state is TopRatedTvSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedTvSeriesData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeries = state.result[index];
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
                  itemCount: state.result.length,
                );
              } else if (state is TopRatedTvSeriesError) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              } else if (state is TopRatedTvSeriesEmpty) {
                return const Center(
                  child: Text('Emmpty Data'),
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
