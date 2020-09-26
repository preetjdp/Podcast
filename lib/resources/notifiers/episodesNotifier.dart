import 'package:Podcast/resources/databaseService.dart';
import 'package:Podcast/resources/models/episode.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';

final episodesStateNotifierProvider =
    StateNotifierProvider((ref) => EpisodesNotifier());

class EpisodesNotifier extends StateNotifier<AsyncValue<List<Episode>>> {
  DatabaseService databaseService = DatabaseService();
  EpisodesNotifier() : super(const AsyncValue.loading()) {
    _fetch();
  }

  Future<void> _fetch() async {
    state = await AsyncValue.guard(() =>
        databaseService.getEpisodes(queryParameter: "Technology and Design"));
  }

  Future<void> refresh() => _fetch();
}
