import 'package:Podcast/main.dart';
import 'package:Podcast/ui/components/podSearchDelegate.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Podcast/resources/extension.dart';
import 'package:basics/basics.dart';

class BottomPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AssetsAudioPlayer player = context.watch<AssetsAudioPlayer>();
    return Container(
      color: Colors.white,
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            child: player.builderCurrent(
                builder: (BuildContext context, Playing playing) {
              if (playing.isNotNull)
                return Image.network(playing.audio.audio.episode.thumbnail);
              return Container();
            }),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(child: player.builderCurrent(
              builder: (BuildContext context, Playing playing) {
            if (playing.isNotNull)
              return Text(playing.audio.audio.episode.title);
            return Text("Select a Podcast");
          })),
          SizedBox(
            width: 15,
          ),
          CupertinoButton(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(50),
              minSize: 20,
              padding: EdgeInsets.all(10),
              child: player.builderIsPlaying(
                  builder: (BuildContext context, bool isPlaying) {
                return isPlaying
                    ? Icon(CupertinoIcons.pause)
                    : Icon(CupertinoIcons.play_arrow);
              }),
              onPressed: player.playOrPause),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
