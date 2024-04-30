import 'package:core/common/common.dart';
import 'package:core/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const routeName = '/now-playing-tv-series';

  const NowPlayingTvSeriesPage({super.key});

  @override
  State<NowPlayingTvSeriesPage> createState() => _NowPlayingTvSeriesPageState();
}

class _NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowPlayingTvSeriesNotifier>(context, listen: false)
            .fetchNowPlayingTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = data.tvSeries[index];
                  return CardList(
                    title: tvSeries.name ?? '-',
                    overview: tvSeries.overview ?? '-',
                    posterPath: '${tvSeries.posterPath}',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        TvSeriesDetailPage.routeName,
                        arguments: tvSeries.id,
                      );
                    },
                  );
                },
                itemCount: data.tvSeries.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
