import 'package:Podcast/resources/episodeNotifer.dart';
import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podSpinner.dart';
import 'package:Podcast/ui/components/bottomPlayer.dart';
import 'package:Podcast/ui/components/episodeWidget.dart';
import 'package:Podcast/ui/components/podSearchDelegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Podcast/resources/extension.dart';

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
                    SearchBar(),
                    // SliverToBoxAdapter(
                    //   child: Text(
                    //     "Featured",
                    //     style: Theme.of(context).textTheme.headline4,
                    //   ),
                    // ),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 15),
                      sliver: SliverToBoxAdapter(
                        child: EpisodeWidget(
                          size: EpisodeWidgetSize.LARGE,
                          episode: episodes.first,
                        ),
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //   child: Text(
                    //     "For You",
                    //     style: Theme.of(context).textTheme.headline4,
                    //   ),
                    // ),
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

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _onSubmitted(String a) {
      showSearch(context: context, delegate: PodSearchDelegate(), query: a);
    }

    return SliverPadding(
      padding: EdgeInsets.only(bottom: 15),
      sliver: SliverToBoxAdapter(
          child: CupertinoTextField(
        onSubmitted: _onSubmitted,
        autocorrect: false,
        placeholder: "Search for Podcasts here ...",
        placeholderStyle: TextStyle(color: context.podDesign.podGrey2),
        textInputAction: TextInputAction.search,
        padding: EdgeInsets.all(15),
        cursorRadius: context.podDesign.podRadius,
        cursorColor: context.podDesign.podGrey1,
        decoration: BoxDecoration(
            color: context.podDesign.podWhite2,
            borderRadius: BorderRadius.all(context.podDesign.podRadius)),
        suffix: Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              CupertinoIcons.search,
              color: Colors.white,
              size: context.podDesign.size5,
            )),
      )),
    );
  }
}
