class Home {
  Home({
    required this.ongoingAnime,
    required this.completeAnime,
  });

  final List<OngoingAnime> ongoingAnime;
  final List<CompleteAnime> completeAnime;

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      ongoingAnime: json["ongoing_anime"] == null
          ? []
          : List<OngoingAnime>.from(
              json["ongoing_anime"]!.map((x) => OngoingAnime.fromJson(x))),
      completeAnime: json["complete_anime"] == null
          ? []
          : List<CompleteAnime>.from(
              json["complete_anime"]!.map((x) => CompleteAnime.fromJson(x))),
    );
  }
}

class CompleteAnime {
  CompleteAnime({
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

  factory CompleteAnime.fromJson(Map<String, dynamic> json) {
    return CompleteAnime(
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

class OngoingAnime {
  OngoingAnime({
    required this.title,
    required this.slug,
    required this.poster,
    required this.currentEpisode,
    required this.releaseDay,
    required this.newestReleaseDate,
    required this.otakudesuUrl,
  });

  final String? title;
  final String? slug;
  final String? poster;
  final String? currentEpisode;
  final String? releaseDay;
  final String? newestReleaseDate;
  final String? otakudesuUrl;

  factory OngoingAnime.fromJson(Map<String, dynamic> json) {
    return OngoingAnime(
      title: json["title"],
      slug: json["slug"],
      poster: json["poster"],
      currentEpisode: json["current_episode"],
      releaseDay: json["release_day"],
      newestReleaseDate: json["newest_release_date"],
      otakudesuUrl: json["otakudesu_url"],
    );
  }
}
