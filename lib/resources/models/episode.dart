import 'package:Podcast/resources/helpers.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Episode extends Equatable {
  final String id;
  final String title;
  final String description;
  final String audioUrl;
  final String image;
  final String thumbnail;
  final bool isExplicit;
  final int length;
  final DateTime publishedAt;
  final String simplerDate;
  final String publisher;
  final String podcastTitle;
  final Map<String, dynamic> data;

  @override
  List<Object> get props => [id];

  Audio get audio => Audio.network(audioUrl,
      metas: Metas(
          title: title,
          album: podcastTitle,
          artist: publisher,
          extra: data,
          image: MetasImage.network(thumbnail)));

  Episode(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.audioUrl,
      @required this.image,
      @required this.thumbnail,
      @required this.isExplicit,
      @required this.length,
      @required this.publishedAt,
      @required this.simplerDate,
      @required this.publisher,
      @required this.podcastTitle,
      @required this.data});

  factory Episode.fromJson(Map<String, dynamic> json) {
    DateTime publishedAt =
        DateTime.fromMillisecondsSinceEpoch(json['pub_date_ms']);
    String simplerDate =
        "${publishedAt.day}${getDayOfMonthSuffix(publishedAt.day)} ${getMonth(publishedAt.month)}";

    return Episode(
        id: json['id'],
        title: json['title_original'],
        description: json['description_original'],
        audioUrl: json['audio'],
        image: json['image'],
        thumbnail: json['thumbnail'],
        isExplicit: json['explicit_content'],
        length: json['audio_length_sec'],
        publishedAt: publishedAt,
        simplerDate: simplerDate,
        podcastTitle: json['podcast_title_original'],
        publisher: json['publisher_original'],
        data: json);
  }
}
