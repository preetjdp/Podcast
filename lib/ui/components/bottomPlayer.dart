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
import 'package:Podcast/resources/providers.dart';
import 'package:Podcast/ui/abstractions/podSpinner.dart';
import 'package:Podcast/ui/mainPlayer.dart';

class BottomPlayer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer player = useProvider(assetsAudioPlayerProvider);
    void _showMainPlayer() {
      if (player.realtimePlayingInfos.value.isNotNull)
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => MainPlayer()));
    }

    return CupertinoButton(
      onPressed: _showMainPlayer,
      minSize: 0,
      padding: EdgeInsets.all(0),
      child: Container(
          color: context.podDesign.podWhite2,
          height: 80,
          child: player.builderRealtimePlayingInfos(builder:
              (BuildContext context, RealtimePlayingInfos realTimeInfo) {
            // print(realTimeInfo.toString());
            if (realTimeInfo.isNull)
              return Center(
                  child: Text("Start By Selecting a Podcast",
                      style: Theme.of(context).textTheme.subtitle1));
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 80,
                    width: 80,
                    child: realTimeInfo.current.isNotNull
                        ? Image.network(
                            realTimeInfo.current.audio.audio.episode.thumbnail)
                        : Container()),
                CustomPaint(
                  painter: DurationPainter(context,
                      value: realTimeInfo.playingPercent),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: !realTimeInfo.isBuffering &&
                            realTimeInfo.current.isNotNull
                        ? Text(realTimeInfo.current.audio.audio.episode.title,
                            style: Theme.of(context).textTheme.subtitle1)
                        : Center(
                            child: PodSpinner(),
                          ),
                  ),
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
              ],
            );
          })),
    );
  }
}

class DurationPainter extends CustomPainter {
  final double value;
  final BuildContext context;
  double maxWidth;
  DurationPainter(this.context, {@required this.value}) : assert(value >= 0) {
    maxWidth = MediaQuery.of(context).size.width - 80;
  }
  static double _strokeWidth = 2;
  static double _startPosition = -40 + _strokeWidth / 2;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = context.podDesign.podGrey1
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.butt
      ..filterQuality = FilterQuality.high;

    canvas.drawLine(Offset(0, _startPosition),
        Offset(value * maxWidth, _startPosition), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
