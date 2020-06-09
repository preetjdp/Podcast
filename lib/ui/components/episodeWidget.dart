import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podTheme.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Podcast/resources/extension.dart';
import 'package:basics/basics.dart';

enum EpisodeWidgetSize { LARGE, REGULAR, SMALL }

class EpisodeWidget extends StatelessWidget {
  final EpisodeWidgetSize size;
  final Episode episode;
  final PodDesign podDesign = PodDesign();
  EpisodeWidget(
      {@required this.episode, this.size = EpisodeWidgetSize.REGULAR});
  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer player = context.watch<AssetsAudioPlayer>();
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
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
                height: size == EpisodeWidgetSize.LARGE ? 120 : 80,
                width: size == EpisodeWidgetSize.LARGE ? 120 : 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(podDesign.podRadius),
                    image:
                        DecorationImage(image: NetworkImage(episode.thumbnail)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 15,
                          color: PodDesign().podGrey2.withOpacity(0.05),
                          spreadRadius: 0.1)
                    ]),
                child: player.builderRealtimePlayingInfos(builder:
                    (BuildContext context, RealtimePlayingInfos realTimeInfo) {
                  Playing playing = realTimeInfo?.current ?? null;
                  return Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      if (playing.isNotNull &&
                          episode == playing.audio.audio.episode)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(podDesign.podRadius),
                            color:
                                Theme.of(context).accentColor.withOpacity(0.7),
                          ),
                          child: Center(
                            child: Icon(
                              realTimeInfo.isPlaying
                                  ? CupertinoIcons.pause_solid
                                  : CupertinoIcons.play_arrow_solid,
                              color: Colors.white,
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
                  Text("${episode.simplerDate} 30 mins",
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
