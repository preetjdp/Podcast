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
