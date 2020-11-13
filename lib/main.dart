// @dart=2.9
// Flutter imports:
import 'package:Podcast/resources/providers.dart';
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
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

void main() {
  // Done with regards to Providers/
  WidgetsFlutterBinding.ensureInitialized();
  configureSystemChrome();
  runApp(ProviderScope(child: DevicePreview(
    enabled: true,
    builder: (e) => PodcastApp())));
}

class PodcastApp extends StatelessWidget {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('test_player');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      theme: podTheme(),
      title: 'Podcast',
      home: ResponsiveWrapper());
  }
}

final mainRoutes = <String, WidgetBuilder>{
  '/': (BuildContext context) => HomePage(),
  '/homePage': (BuildContext context) => HomePage(),
};

class ResponsiveWrapper extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final mainNaviagtorKey = useProvider(mainNavigatorKey);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Row(
      children: [
        if (mediaQuery.deviceType == PodDeviceType.DESKTOP) PodNavigationRail(),
        Expanded(
            flex: 2,
            child: Navigator(
              key: mainNaviagtorKey,
              onGenerateRoute: (s) => getRouteFromSetting(mainRoutes, s),
            )),
        if (mediaQuery.isOfTheseTypes([PodDeviceType.DESKTOP]))
          Expanded(
            child: MainPlayer(),
          )
      ],
    );
  }
}
