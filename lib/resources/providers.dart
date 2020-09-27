// Package imports: 
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

final assetsAudioPlayerProvider = Provider((ref) => AssetsAudioPlayer());

final mainNavigatorKey = Provider((ref) => GlobalKey<NavigatorState>());
