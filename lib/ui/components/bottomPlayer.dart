import 'package:Podcast/main.dart';
import 'package:Podcast/ui/abstractions/podSpinner.dart';
import 'package:Podcast/ui/abstractions/podTheme.dart';
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
        color: context.podDesign.podWhite2,
        height: 80,
        child: player.builderRealtimePlayingInfos(
            builder: (BuildContext context, RealtimePlayingInfos realTimeInfo) {
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
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: !realTimeInfo.isBuffering &&
                          realTimeInfo.current.isNotNull
                      ? Text(realTimeInfo.current.audio.audio.episode.title,
                          style: Theme.of(context).textTheme.subtitle1)
                      : Center(
                          child: PodSpinner(),
                        )),
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
            ],
          );
        }));
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
