import 'package:core/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const routeName = '/popular-tv-series';

  const PopularTvSeriesPage({super.key});

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvSeriesData) {
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
            } else if (state is PopularTvSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else if (state is PopularTvSeriesEmpty) {
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
}
