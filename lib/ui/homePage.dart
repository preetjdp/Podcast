import 'package:Podcast/resources/episodeNotifer.dart';
import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podSpinner.dart';
import 'package:Podcast/ui/components/bottomPlayer.dart';
import 'package:Podcast/ui/components/episodeWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basics/basics.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Episode> episodes = context.watch<EpisodeNotifier>().episodes;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: episodes.isEmpty
              ? HomePageEmptyState()
              : CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(
                        "Featured",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: EpisodeWidget(
                        size: EpisodeWidgetSize.LARGE,
                        episode: episodes.first,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "For You",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      Episode episode = episodes.sublist(1).elementAt(index);
                      return Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: EpisodeWidget(
                            episode: episode,
                          ));
                    }, childCount: episodes.length - 1))
                  ],
                ),
        ),
      ),
      bottomNavigationBar: BottomPlayer(),
    );
  }
}

class HomePageEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PodSpinner(),
    );
  }
}
