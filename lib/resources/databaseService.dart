// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:Podcast/resources/models/episode.dart';

const API_URl = "https://listen-api.listennotes.com/api/v2";
const API_KEY = "9bd2e09bcf93430a8f75163ce394205f";

class DatabaseService {
  Future<List<Episode>> getEpisodes({@required String queryParameter}) async {
    Dio dio = Dio(BaseOptions(
      baseUrl: API_URl,
      headers: {"X-ListenAPI-Key": API_KEY},
    ));

    Response response =
        await dio.get("/search", queryParameters: {'q': queryParameter});
    // print(response.statusCode);
    // print(response.data['results']);
    List<dynamic> _jsonList = response.data['results'];
    return _jsonList.map((e) => Episode.fromJson(e)).toList();
  }
}
