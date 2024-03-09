// To parse this JSON data, do
//
//     final genres = genresFromJson(jsonString);

import 'dart:convert';

Genres genresFromJson(String str) => Genres.fromJson(json.decode(str));

String genresToJson(Genres data) => json.encode(data.toJson());

class Genres {
  final String? name;
  final String? slug;
  final String? otakudesuUrl;

  Genres({
    this.name,
    this.slug,
    this.otakudesuUrl,
  });

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
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
