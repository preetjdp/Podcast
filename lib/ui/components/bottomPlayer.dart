import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AssetsAudioPlayer player = context.watch<AssetsAudioPlayer>();
    return Container(
        color: Colors.white,
        height: 80,
        child: Center(
            child: Container(
          height: 50,
          width: 50,
          child: CupertinoButton(
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
        )));
  }
}
