import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podTheme.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

extension PlayableUtil on Audio {
  Episode get episode => Episode.fromJson(this.metas.extra);
}

extension PodContext on BuildContext {
  PodDesign get podDesign => PodDesign();
}
