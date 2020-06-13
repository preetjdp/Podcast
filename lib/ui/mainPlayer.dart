import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podImagePlaceHolder.dart';
import 'package:Podcast/ui/abstractions/podTheme.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Podcast/resources/extension.dart';
import 'package:provider/provider.dart';
import 'package:basics/basics.dart';

class MainPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PodDesign podDesign = context.podDesign;
    AssetsAudioPlayer player = context.watch<AssetsAudioPlayer>();
    return Scaffold(body: player.builderRealtimePlayingInfos(
        builder: (BuildContext context, RealtimePlayingInfos realTimeInfo) {
      if (realTimeInfo.isNull || realTimeInfo.current.isNull) {
        return Center(
          child: Text("Nothing is happening"),
        );
      }
      Playing playing = realTimeInfo.current;
      Episode episode = playing.audio.audio.episode;
      print(episode.thumbnail + " " + episode.image);
      return Padding(
        padding: EdgeInsets.all(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 250,
                  width: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(podDesign.podRadius),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 15,
                            color: podDesign.podGrey2.withOpacity(0.05),
                            spreadRadius: 0.1)
                      ]),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(podDesign.podRadius),
                      child: PodImagePlaceholder.network(url: episode.image)),
                ),
                Text(
                  episode.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Slider(
                    value: realTimeInfo.playingPercent,
                    onChanged: (double value) {
                      player.seek(
                          Duration(seconds: (value * episode.length).toInt()));
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(50),
                        minSize: 20,
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.replay_30),
                        onPressed: () => player.seekBy(Duration(seconds: -5))),
                    SizedBox(
                      width: 15,
                    ),
                    CupertinoButton(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(50),
                        minSize: 20,
                        padding: EdgeInsets.all(10),
                        child: realTimeInfo.isPlaying
                            ? Icon(CupertinoIcons.pause)
                            : Icon(CupertinoIcons.play_arrow),
                        onPressed: player.playOrPause),
                    SizedBox(
                      width: 15,
                    ),
                    CupertinoButton(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(50),
                        minSize: 20,
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.forward_30),
                        onPressed: () => player.seekBy(Duration(seconds: 5))),
                  ],
                )
              ],
            )
          ],
        ),
      );
    }));
  }
}
