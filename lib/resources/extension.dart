import 'package:Podcast/resources/models/episode.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

extension PlayableUtil on Audio {
  Episode get episode => Episode.fromJson(this.metas.extra);
}
