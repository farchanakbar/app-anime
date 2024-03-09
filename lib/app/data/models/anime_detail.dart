// To parse this JSON data, do
//
//     final animeDetail = animeDetailFromJson(jsonString);

import 'dart:convert';

AnimeDetail animeDetailFromJson(String str) =>
    AnimeDetail.fromJson(json.decode(str));

String animeDetailToJson(AnimeDetail data) => json.encode(data.toJson());

class AnimeDetail {
  final String? title;
  final String? japaneseTitle;
  final String? poster;
  final String? rating;
  final String? produser;
  final String? type;
  final String? status;
  final String? episodeCount;
  final String? duration;
  final String? releaseDate;
  final String? studio;
  final List<Genre>? genres;
  final String? synopsis;
  final Batch? batch;
  final List<EpisodeList>? episodeLists;
  final List<Recommendation>? recommendations;

  AnimeDetail({
    this.title,
    this.japaneseTitle,
    this.poster,
    this.rating,
    this.produser,
    this.type,
    this.status,
    this.episodeCount,
    this.duration,
    this.releaseDate,
    this.studio,
    this.genres,
    this.synopsis,
    this.batch,
    this.episodeLists,
    this.recommendations,
  });

  factory AnimeDetail.fromJson(Map<String, dynamic> json) => AnimeDetail(
        title: json["title"],
        japaneseTitle: json["japanese_title"],
        poster: json["poster"],
        rating: json["rating"],
        produser: json["produser"],
        type: json["type"],
        status: json["status"],
        episodeCount: json["episode_count"],
        duration: json["duration"],
        releaseDate: json["release_date"],
        studio: json["studio"],
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
        synopsis: json["synopsis"],
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
        episodeLists: json["episode_lists"] == null
            ? []
            : List<EpisodeList>.from(
                json["episode_lists"]!.map((x) => EpisodeList.fromJson(x))),
        recommendations: json["recommendations"] == null
            ? []
            : List<Recommendation>.from(json["recommendations"]!
                .map((x) => Recommendation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "japanese_title": japaneseTitle,
        "poster": poster,
        "rating": rating,
        "produser": produser,
        "type": type,
        "status": status,
        "episode_count": episodeCount,
        "duration": duration,
        "release_date": releaseDate,
        "studio": studio,
        "genres": genres == null
            ? []
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "synopsis": synopsis,
        "batch": batch?.toJson(),
        "episode_lists": episodeLists == null
            ? []
            : List<dynamic>.from(episodeLists!.map((x) => x.toJson())),
        "recommendations": recommendations == null
            ? []
            : List<dynamic>.from(recommendations!.map((x) => x.toJson())),
      };
}

class Batch {
  final String? slug;
  final String? otakudesuUrl;
  final String? uploadedAt;

  Batch({
    this.slug,
    this.otakudesuUrl,
    this.uploadedAt,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        slug: json["slug"],
        otakudesuUrl: json["otakudesu_url"],
        uploadedAt: json["uploaded_at"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "otakudesu_url": otakudesuUrl,
        "uploaded_at": uploadedAt,
      };
}

class EpisodeList {
  final String? episode;
  final String? slug;
  final String? otakudesuUrl;

  EpisodeList({
    this.episode,
    this.slug,
    this.otakudesuUrl,
  });

  factory EpisodeList.fromJson(Map<String, dynamic> json) => EpisodeList(
        episode: json["episode"],
        slug: json["slug"],
        otakudesuUrl: json["otakudesu_url"],
      );

  Map<String, dynamic> toJson() => {
        "episode": episode,
        "slug": slug,
        "otakudesu_url": otakudesuUrl,
      };
}

class Genre {
  final String? name;
  final String? slug;
  final String? otakudesuUrl;

  Genre({
    this.name,
    this.slug,
    this.otakudesuUrl,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        name: json["name"],
        slug: json["slug"],
        otakudesuUrl: json["otakudesu_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "otakudesu_url": otakudesuUrl,
      };
}

class Recommendation {
  final String? title;
  final String? slug;
  final String? poster;
  final String? otakudesuUrl;

  Recommendation({
    this.title,
    this.slug,
    this.poster,
    this.otakudesuUrl,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
        title: json["title"],
        slug: json["slug"],
        poster: json["poster"],
        otakudesuUrl: json["otakudesu_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "poster": poster,
        "otakudesu_url": otakudesuUrl,
      };
}
