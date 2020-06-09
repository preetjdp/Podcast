import 'package:Podcast/resources/databaseService.dart';
import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podSpinner.dart';
import 'package:Podcast/ui/components/episodeWidget.dart';
import 'package:flutter/material.dart';

class PodSearchDelegate extends SearchDelegate {
  DatabaseService databaseService = DatabaseService();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: databaseService.getEpisodes(queryParameter: query),
      builder: (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: PodSpinner(),
          );
        return ListView.builder(
            itemCount: snapshot.data.length,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(15),
            itemBuilder: (BuildContext context, int index) {
              Episode episode = snapshot.data.elementAt(index);
              return Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: EpisodeWidget(episode: episode));
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: databaseService.getEpisodes(queryParameter: query),
      builder: (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: PodSpinner(),
          );
        return ListView.builder(
            itemCount: snapshot.data.length,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(15),
            itemBuilder: (BuildContext context, int index) {
              Episode episode = snapshot.data.elementAt(index);
              return Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: EpisodeWidget(episode: episode));
            });
      },
    );
  }
}
