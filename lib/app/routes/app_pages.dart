import 'package:get/get.dart';

import '../modules/anime_complate/bindings/anime_complate_binding.dart';
import '../modules/anime_complate/views/anime_complate_view.dart';
import '../modules/anime_detail/bindings/anime_detail_binding.dart';
import '../modules/anime_detail/views/anime_detail_view.dart';
import '../modules/anime_ongoing/bindings/anime_ongoing_binding.dart';
import '../modules/anime_ongoing/views/anime_ongoing_view.dart';
import '../modules/detail_episode/bindings/detail_episode_binding.dart';
import '../modules/detail_episode/views/detail_episode_view.dart';
import '../modules/genre_detail/bindings/genre_detail_binding.dart';
import '../modules/genre_detail/views/genre_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GENRE_DETAIL,
      page: () => const GenreDetailView(),
      binding: GenreDetailBinding(),
    ),
    GetPage(
      name: _Paths.ANIME_DETAIL,
      page: () => const AnimeDetailView(),
      binding: AnimeDetailBinding(),
    ),
    GetPage(
      name: _Paths.ANIME_ONGOING,
      page: () => const AnimeOngoingView(),
      binding: AnimeOngoingBinding(),
    ),
    GetPage(
      name: _Paths.ANIME_COMPLATE,
      page: () => const AnimeComplateView(),
      binding: AnimeComplateBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_EPISODE,
      page: () => const DetailEpisodeView(),
      binding: DetailEpisodeBinding(),
    ),
  ];
}
