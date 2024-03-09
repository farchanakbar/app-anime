class DetailEpisode {
  DetailEpisode({
    required this.episode,
    required this.anime,
    required this.hasNextEpisode,
    required this.nextEpisode,
    required this.hasPreviousEpisode,
    required this.previousEpisode,
    required this.streamUrl,
    required this.downloadUrls,
  });

  final String? episode;
  final Anime? anime;
  final bool? hasNextEpisode;
  final Anime? nextEpisode;
  final bool? hasPreviousEpisode;
  final dynamic previousEpisode;
  final String? streamUrl;
  final Map<String, List<DownloadUrl>> downloadUrls;

  factory DetailEpisode.fromJson(Map<String, dynamic> json) {
    return DetailEpisode(
      episode: json["episode"],
      anime: json["anime"] == null ? null : Anime.fromJson(json["anime"]),
      hasNextEpisode: json["has_next_episode"],
      nextEpisode: json["next_episode"] == null
          ? null
          : Anime.fromJson(json["next_episode"]),
      hasPreviousEpisode: json["has_previous_episode"],
      previousEpisode: json["previous_episode"],
      streamUrl: json["stream_url"],
      downloadUrls: Map.from(json["download_urls"]).map((k, v) =>
          MapEntry<String, List<DownloadUrl>>(
              k,
              v == null
                  ? []
                  : List<DownloadUrl>.from(
                      v!.map((x) => DownloadUrl.fromJson(x))))),
    );
  }
}

class Anime {
  Anime({
    required this.slug,
    required this.otakudesuUrl,
  });

  final String? slug;
  final String? otakudesuUrl;

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      slug: json["slug"],
      otakudesuUrl: json["otakudesu_url"],
    );
  }
}

class DownloadUrl {
  DownloadUrl({
    required this.resolution,
    required this.urls,
  });

  final String? resolution;
  final List<Url> urls;

  factory DownloadUrl.fromJson(Map<String, dynamic> json) {
    return DownloadUrl(
      resolution: json["resolution"],
      urls: json["urls"] == null
          ? []
          : List<Url>.from(json["urls"]!.map((x) => Url.fromJson(x))),
    );
  }
}

class Url {
  Url({
    required this.provider,
    required this.url,
  });

  final String? provider;
  final String? url;

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      provider: json["provider"],
      url: json["url"],
    );
  }
}
