import 'package:Podcast/resources/databaseService.dart';
import 'package:Podcast/resources/models/episode.dart';
import 'package:flutter/material.dart';

class EpisodeNotifier extends ChangeNotifier {
  DatabaseService _databaseService = DatabaseService();
  List<Episode> episodes = [];
  EpisodeNotifier() {
    fetch();
  }

  void fetch() async {
    episodes = await _databaseService.getEpisodes(
        queryParameter: "Technology and Design");
    notifyListeners();
  }
}
