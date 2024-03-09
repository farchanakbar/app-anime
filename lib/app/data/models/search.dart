class Search {
  Search({
    required this.title,
    required this.slug,
    required this.poster,
    required this.genres,
    required this.status,
    required this.rating,
    required this.url,
  });

  final String? title;
  final String? slug;
  final String? poster;
  final List<Genre> genres;
  final String? status;
  final String? rating;
  final String? url;

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      title: json["title"],
      slug: json["slug"],
      poster: json["poster"],
      genres: json["genres"] == null
          ? []
          : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
      status: json["status"],
      rating: json["rating"],
      url: json["url"],
    );
  }
}

class Genre {
  Genre({
    required this.name,
    required this.slug,
    required this.otakudesuUrl,
  });

  final String? name;
  final String? slug;
  final String? otakudesuUrl;

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      name: json["name"],
      slug: json["slug"],
      otakudesuUrl: json["otakudesu_url"],
    );
  }
}
