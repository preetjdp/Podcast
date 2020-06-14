import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podImagePlaceHolder.dart';
import 'package:Podcast/ui/abstractions/podTheme.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Podcast/resources/extension.dart';
import 'package:provider/provider.dart';
import 'package:basics/basics.dart';
import 'dart:math' as math;

class MainPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      return Padding(
        padding: EdgeInsets.all(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RotatingDisc(),
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

class RotatingDisc extends StatefulWidget {
  @override
  _RotatingDiscState createState() => _RotatingDiscState();
}

class _RotatingDiscState extends State<RotatingDisc>
    with SingleTickerProviderStateMixin {
  AnimationController rotationController;
  AssetsAudioPlayer player;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 360,
        duration: Duration(seconds: 15));
    player = context.read<AssetsAudioPlayer>();
    player.realtimePlayingInfos.listen((event) {
      if (event.isNotNull && !event.isBuffering) {
        if (event.isPlaying) {
          rotationController.forward();
        } else {
          rotationController.stop();
        }
      }
    });
    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return player.builderRealtimePlayingInfos(
        builder: (BuildContext context, RealtimePlayingInfos realTimeInfo) {
      if (realTimeInfo.isNull || realTimeInfo.current.isNull) {
        return Center(
          child: Text("Empty"),
        );
      }
      Playing playing = realTimeInfo.current;
      Episode episode = playing.audio.audio.episode;
      return AnimatedBuilder(
        animation: rotationController,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(250, 250),
              painter: DiscPainter(discs: 15),
              willChange: false,
            ),
            ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 80,
                width: 80,
                child: PodImagePlaceholder.network(
                  url: episode.image,
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            angle: (rotationController.value * math.pi) / 180,
            child: child,
          );
        },
      );
    });
  }
}

class DiscPainter extends CustomPainter {
  final int discs;
  DiscPainter({@required this.discs});
  math.Random random = math.Random();
  PodDesign podDesign = PodDesign();
  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()..color = podDesign.podGrey1;
    Paint discPainter = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = podDesign.podWhite1;
    Offset center = size.center(Offset(0, 0));
    double radius = size.height / 2;
    double imageRadius = 40;

    canvas.drawCircle(center, radius, backgroundPaint);

    double tempRadius = imageRadius;
    double deltaRadius = (radius - imageRadius) / discs;

    for (int i = 0; i < discs; i++) {
      canvas.drawCircle(center, tempRadius, discPainter);
      tempRadius += deltaRadius;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}