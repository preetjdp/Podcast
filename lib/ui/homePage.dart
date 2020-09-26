// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

// Project imports:
import 'package:Podcast/resources/extension.dart';
import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/resources/notifiers/episodesNotifier.dart';
import 'package:Podcast/ui/abstractions/podSpinner.dart';
import 'package:Podcast/ui/components/bottomPlayer.dart';
import 'package:Podcast/ui/components/episodeWidget.dart';
import 'package:Podcast/ui/components/podSearchDelegate.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Episode>> episodesAsyncValue =
        useProvider(episodesStateNotifierProvider.state);
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: episodesAsyncValue.when(
                data: (episodes) => CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        if (MediaQuery.of(context).isOfTheseTypes(
                            [PodDeviceType.MOBILE, PodDeviceType.TABLET]))
                          SliverPadding(
                              padding: EdgeInsets.only(top: 15),
                              sliver: SearchBar()),
                        if (MediaQuery.of(context).deviceType ==
                            PodDeviceType.MOBILE) ...[
                          SliverPadding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            sliver: SliverToBoxAdapter(
                              child: EpisodeWidget(
                                size: EpisodeWidgetSize.LARGE,
                                episode: episodes.first,
                              ),
                            ),
                          ),
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                            Episode episode =
                                episodes.sublist(1).elementAt(index);
                            return Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: EpisodeWidget(
                                  episode: episode,
                                ));
                          }, childCount: episodes.length - 1))
                        ],
                        if (MediaQuery.of(context).isOfTheseTypes(
                            [PodDeviceType.DESKTOP, PodDeviceType.TABLET]))
                          SliverPadding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            sliver: SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          MediaQuery.of(context).deviceType ==
                                                  PodDeviceType.DESKTOP
                                              ? 300
                                              : 200,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15),
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  Episode episode = episodes.elementAt(index);
                                  return EpisodeWidget(
                                    episode: episode,
                                    size: EpisodeWidgetSize.GIGANTIC,
                                  );
                                },
                                childCount: episodes.length,
                              ),
                            ),
                          )
                      ],
                    ),
                loading: () => HomePageEmptyState(),
                //TODO Have a widget for this
                error: (a, e) => HomePageEmptyState())),
      ),
      bottomNavigationBar: MediaQuery.of(context)
              .isOfTheseTypes([PodDeviceType.MOBILE, PodDeviceType.TABLET])
          ? BottomPlayer()
          : SizedBox.shrink(),
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

    return SliverToBoxAdapter(
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
            size: context.podDesign.size6,
          )),
    ));
  }
}
