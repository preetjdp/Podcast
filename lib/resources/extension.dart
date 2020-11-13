// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:basics/basics.dart';

// Project imports:
import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podTheme.dart';

extension PlayableUtil on Audio {
  Episode get episode => Episode.fromJson(this.metas.extra);
}

extension PodContext on BuildContext {
  PodDesign get podDesign => PodDesign();
}

enum PodDeviceType { MOBILE, TABLET, DESKTOP, UNDEFINED }

extension PodMediaQuery on MediaQueryData {
  PodDeviceType get deviceType {
    double width = this.size.width;
    if (width >= 0 && width <= 480) {
      return PodDeviceType.MOBILE;
    } else if (width > 480 && width <= 800) {
      return PodDeviceType.TABLET;
    } else if (width > 800 && width.isFinite) {
      return PodDeviceType.DESKTOP;
    } else {
      return PodDeviceType.UNDEFINED;
    }
  }

  bool isOfTheseTypes(List<PodDeviceType> deviceTypes) {
    return deviceTypes.contains(this.deviceType);
  }
}

extension ClickableExtensions on Widget {
  // Widget clickable(void Function() action, {bool opaque = true}) {
  //   return GestureDetector(
  //     behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
  //     onTap: action,
  //     child: MouseRegion(
  //       cursor: SystemMouseCursors.click,
  //       opaque: opaque ?? false,
  //       child: this,
  //     ),
  //   );
  // }
  Widget clickable({bool opaque = true}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      opaque: opaque ?? false,
      child: this,
    );
  }
}

extension AssetsAudioPlayerExtensions on AssetsAudioPlayer {
  bool isEpisodePlaying(Episode episode) {
    Playing playing = this.current.value;
    if (playing.isNull) {
      return false;
    }

    return playing.audio.audio.episode == episode;
  }
}
