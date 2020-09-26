// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:device_preview/device_preview.dart';

// Project imports:
import 'package:Podcast/resources/extension.dart';
import 'package:Podcast/resources/helpers.dart';
import 'package:Podcast/ui/abstractions/podTheme.dart';
import 'package:Podcast/ui/components/navigationRail.dart';
import 'package:Podcast/ui/homePage.dart';
import 'package:Podcast/ui/mainPlayer.dart';

void main() {
  // Done with regards to Providers/
  WidgetsFlutterBinding.ensureInitialized();
  configureSystemChrome();
  runApp(PodcastApp());
}

class PodcastApp extends StatelessWidget {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('test_player');
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder: (a) => MaterialApp(
          builder: DevicePreview.appBuilder,
          theme: podTheme(),
          title: 'Podcast',
          home: ResponsiveWrapper()),
    );
  }
}

class ResponsiveWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Row(
      children: [
        if (mediaQuery.deviceType == PodDeviceType.DESKTOP) PodNavigationRail(),
        Expanded(flex: 2, child: HomePage()),
        if (mediaQuery.isOfTheseTypes([PodDeviceType.DESKTOP]))
          Expanded(
            child: MainPlayer(),
          )
      ],
    );
  }
}
