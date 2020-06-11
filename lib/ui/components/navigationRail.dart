import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podImagePlaceHolder.dart';
import 'package:Podcast/ui/abstractions/podTheme.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Podcast/resources/extension.dart';
import 'package:basics/basics.dart';

class PodNavigationRail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer player = context.watch<AssetsAudioPlayer>();
    PodDesign podDesign = context.podDesign;
    return NavigationRail(
      backgroundColor: podDesign.podWhite2,
      destinations: [
        NavigationRailDestination(icon: Text('wow'), label: Text('test')),
        NavigationRailDestination(icon: Text('wow'), label: Text('test')),
        NavigationRailDestination(icon: Text('wow'), label: Text('test')),
      ],
      groupAlignment: 1,
      trailing: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(podDesign.podRadius),
              boxShadow: [
                BoxShadow(
                    blurRadius: 15,
                    color: podDesign.podGrey2.withOpacity(0.05),
                    spreadRadius: 0.1)
              ]),
          child: player.builderRealtimePlayingInfos(builder:
              (BuildContext context, RealtimePlayingInfos realTimeInfo) {
            if (realTimeInfo.isNull || realTimeInfo.current.isNull) {
              return Center(child: Text("Wow"));
            }

            Playing playing = realTimeInfo.current;
            Episode episode = playing.audio.audio.episode;
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(podDesign.podRadius),
                    child: PodImagePlaceholder.network(url: episode.thumbnail)),
                if (playing.isNotNull)
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
                        size: context.podDesign.size4,
                      ),
                    ),
                  )
              ],
            );
          }),
        ),
      ),
      selectedIndex: 1,
    );
  }
}