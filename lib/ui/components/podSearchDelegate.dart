import 'package:Podcast/resources/databaseService.dart';
import 'package:Podcast/resources/models/episode.dart';
import 'package:Podcast/ui/abstractions/podSpinner.dart';
import 'package:Podcast/ui/components/episodeWidget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:basics/basics.dart';

class SearchResult {
  final List<Episode> episodes;
  final bool isLoading;
  SearchResult(this.episodes, {@required this.isLoading});

  factory SearchResult.initial() => SearchResult(null, isLoading: false);
}

class SearchService {
  DatabaseService _databaseService = DatabaseService();
  BehaviorSubject<SearchResult> _searchResultSubject =
      BehaviorSubject.seeded(SearchResult.initial());
  BehaviorSubject<String> _searchInputSubject = BehaviorSubject();

  SearchService() {
    _searchInputSubject
        .debounceTime(Duration(milliseconds: 200))
        .listen((event) async {
      List<Episode> result =
          await _databaseService.getEpisodes(queryParameter: event);
      _searchResultSubject.value = SearchResult(result, isLoading: false);
    });
  }

  Stream<SearchResult> get results => _searchResultSubject.stream;

  void search(String query) async {
    if (_searchInputSubject.value == query) {
      return;
    }
    _searchInputSubject.value = query;
    _searchResultSubject.value = SearchResult(null, isLoading: true);
  }

  void dispose() {
    _searchResultSubject.close();
    _searchInputSubject.close();
  }
}

class PodSearchDelegate extends SearchDelegate {
  final SearchService searchService = SearchService();
  Widget podSearchWidget() => StreamBuilder(
        stream: searchService.results,
        builder: (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
          if (snapshot.data?.episodes?.isEmpty ?? false) {
            return Center(
              child: Text("Search For Something"),
            );
          }
          if (snapshot.data.isLoading || snapshot.data.episodes.isNull)
            return Center(
              child: PodSpinner(),
            );
          return ListView.builder(
              itemCount: snapshot.data.episodes.length,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(15),
              itemBuilder: (BuildContext context, int index) {
                Episode episode = snapshot.data.episodes.elementAt(index);
                return Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: EpisodeWidget(episode: episode));
              });
        },
      );
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
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
    searchService.search(query);
    return podSearchWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchService.search(query);
    return podSearchWidget();
  }
}
