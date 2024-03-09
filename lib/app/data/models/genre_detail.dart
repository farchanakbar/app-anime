class DetailGenre {
  DetailGenre({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  factory DetailGenre.fromJson(Map<String, dynamic> json) {
    return DetailGenre(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.anime,
    required this.pagination,
  });

  final List<Anime> anime;
  final Pagination? pagination;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      anime: json["anime"] == null
          ? []
          : List<Anime>.from(json["anime"]!.map((x) => Anime.fromJson(x))),
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
    );
  }
}

class Anime {
  Anime({
    required this.title,
    required this.slug,
    required this.poster,
    required this.rating,
    required this.episodeCount,
    required this.season,
    required this.studio,
    required this.genres,
    required this.synopsis,
    required this.otakudesuUrl,
  });

  final String? title;
  final String? slug;
  final String? poster;
  final String? rating;
  final String? episodeCount;
  final String? season;
  final String? studio;
  final List<Genre> genres;
  final String? synopsis;
  final String? otakudesuUrl;

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json["title"],
      slug: json["slug"],
      poster: json["poster"],
      rating: json["rating"],
      episodeCount: json["episode_count"],
      season: json["season"],
      studio: json["studio"],
      genres: json["genres"] == null
          ? []
          : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
      synopsis: json["synopsis"],
      otakudesuUrl: json["otakudesu_url"],
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

class Pagination {
  Pagination({
    required this.currentPage,
    required this.lastVisiblePage,
    required this.hasNextPage,
    required this.nextPage,
    required this.hasPreviousPage,
    required this.previousPage,
  });

  final int? currentPage;
  final int? lastVisiblePage;
  final bool? hasNextPage;
  final int? nextPage;
  final bool? hasPreviousPage;
  final dynamic previousPage;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json["current_page"],
      lastVisiblePage: json["last_visible_page"],
      hasNextPage: json["has_next_page"],
      nextPage: json["next_page"],
      hasPreviousPage: json["has_previous_page"],
      previousPage: json["previous_page"],
    );
  }
}
