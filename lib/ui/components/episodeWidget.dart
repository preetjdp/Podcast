// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:basics/basics.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

// Project imports:
import 'package:Podcast/resources/extension.dart';
import 'package:Podcast/resources/extension.dart';
import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/resources/providers.dart';
import 'package:Podcast/ui/abstractions/podImagePlaceHolder.dart';
import 'package:Podcast/ui/abstractions/podTheme.dart';

enum EpisodeWidgetSize { GIGANTIC, LARGE, REGULAR, SMALL }

class EpisodeWidget extends HookWidget {
  final EpisodeWidgetSize size;
  final Episode episode;
  final PodDesign podDesign = PodDesign();
  EpisodeWidget(
      {@required this.episode, this.size = EpisodeWidgetSize.REGULAR});
  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer player = useProvider(assetsAudioPlayerProvider);
    bool isEpisodePlaying() {
      Playing playing = player.current.value;
      if (playing.isNull) {
        return false;
      }

      return playing.audio.audio.episode == episode;
    }

    void _onPressed() async {
      if (isEpisodePlaying()) {
        await player.playOrPause();
      } else {
        await player.stop();
        await player.open(episode.audio, showNotification: true);
        await player.play();
      }
    }

    if (size == EpisodeWidgetSize.GIGANTIC) {
      return _EpisodeWidgetGigantic(
        episode: episode,
      );
    }

    return CupertinoButton(
      onPressed: _onPressed,
      minSize: 0,
      padding: EdgeInsets.all(0),
      //TODO This might cause perf issues.
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
                height: _getImageSize(size),
                width: _getImageSize(size),
                decoration: BoxDecoration(
                    color: podDesign.podWhite1,
                    borderRadius: BorderRadius.all(podDesign.podRadius),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 15,
                          color: podDesign.podGrey2.withOpacity(0.05),
                          spreadRadius: 0.1)
                    ]),
                child: player.builderRealtimePlayingInfos(builder:
                    (BuildContext context, RealtimePlayingInfos realTimeInfo) {
                  Playing playing = realTimeInfo?.current ?? null;
                  return Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.all(podDesign.podRadius),
                          child: PodImagePlaceholder.network(
                              url: episode.thumbnail)),
                      if (playing.isNotNull &&
                          episode == playing.audio.audio.episode)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(podDesign.podRadius),
                            color:
                                Theme.of(context).accentColor.withOpacity(0.6),
                          ),
                          child: Center(
                            child: Icon(
                              realTimeInfo.isPlaying
                                  ? CupertinoIcons.pause_solid
                                  : CupertinoIcons.play_arrow_solid,
                              color: Colors.white,
                              size: context.podDesign.size4,
                            ),
                          ),
                        )
                    ],
                  );
                })),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episode.title,
                    style: Theme.of(context).textTheme.headline5,
                    maxLines: size == EpisodeWidgetSize.REGULAR ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(episode.description,
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                  Text("${episode.simplerDate} ${episode.length ~/ 60} mins",
                      style: Theme.of(context).textTheme.subtitle2)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EpisodeWidgetGigantic extends HookWidget {
  final Episode episode;
  _EpisodeWidgetGigantic({@required this.episode});
  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer player = useProvider(assetsAudioPlayerProvider);

    PodDesign podDesign = context.podDesign;
    bool isEpisodePlaying() {
      Playing playing = player.current.value;
      if (playing.isNull) {
        return false;
      }

      return playing.audio.audio.episode == episode;
    }

    void _onPressed() async {
      if (isEpisodePlaying()) {
        await player.playOrPause();
      } else {
        await player.stop();
        await player.open(episode.audio, showNotification: true);
        await player.play();
      }
    }

    return CupertinoButton(
      onPressed: _onPressed,
      minSize: 0,
      padding: EdgeInsets.all(0),
      child: Container(
          height: _getImageSize(EpisodeWidgetSize.GIGANTIC),
          width: _getImageSize(EpisodeWidgetSize.GIGANTIC),
          decoration: BoxDecoration(
              color: podDesign.podWhite1,
              borderRadius: BorderRadius.all(podDesign.podRadius),
              boxShadow: [
                BoxShadow(
                    blurRadius: 15,
                    color: podDesign.podGrey2.withOpacity(0.05),
                    spreadRadius: 0.1)
              ]),
          child: player.builderRealtimePlayingInfos(builder:
              (BuildContext context, RealtimePlayingInfos realTimeInfo) {
            Playing playing = realTimeInfo?.current ?? null;
            return ClipRRect(
              borderRadius: BorderRadius.all(podDesign.podRadius),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(podDesign.podRadius),
                      child:
                          PodImagePlaceholder.network(url: episode.thumbnail)),
                  if (playing.isNotNull &&
                      episode == playing.audio.audio.episode)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(podDesign.podRadius),
                        color: Theme.of(context).accentColor.withOpacity(0.6),
                      ),
                      child: Center(
                        child: Icon(
                          realTimeInfo.isPlaying
                              ? CupertinoIcons.pause_solid
                              : CupertinoIcons.play_arrow_solid,
                          color: Colors.white,
                          size: context.podDesign.size3,
                        ),
                      ),
                    )
                  else
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0, 0.9],
                                colors: [Colors.transparent, Colors.black87])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(episode.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                maxLines: 2),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "${episode.simplerDate} ${episode.length ~/ 60} mins",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(color: Colors.white))
                          ],
                        )),
                ],
              ),
            );
          })),
    );
  }
}

double _getImageSize(EpisodeWidgetSize size) {
  if (size == EpisodeWidgetSize.REGULAR) {
    return 80;
  } else if (size == EpisodeWidgetSize.LARGE) {
    return 120;
  } else if (size == EpisodeWidgetSize.SMALL) {
    return 60;
  } else if (size == EpisodeWidgetSize.GIGANTIC) {
    return 300;
  }
}
