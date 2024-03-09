class DetailComplate {
  DetailComplate({
    required this.status,
    required this.data,
    required this.pagination,
  });

  final String? status;
  final List<Datum> data;
  final Pagination? pagination;

  factory DetailComplate.fromJson(Map<String, dynamic> json) {
    return DetailComplate(
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
    );
  }
}

class Datum {
  Datum({
    required this.title,
    required this.slug,
    required this.poster,
    required this.episodeCount,
    required this.rating,
    required this.lastReleaseDate,
    required this.otakudesuUrl,
  });

  final String? title;
  final String? slug;
  final String? poster;
  final String? episodeCount;
  final String? rating;
  final String? lastReleaseDate;
  final String? otakudesuUrl;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      title: json["title"],
      slug: json["slug"],
      poster: json["poster"],
      episodeCount: json["episode_count"],
      rating: json["rating"],
      lastReleaseDate: json["last_release_date"],
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
  final int? previousPage;

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
