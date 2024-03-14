import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/constants/color.dart';
import 'package:ngewibu/app/data/models/genres.dart';
import 'package:ngewibu/app/data/models/home.dart';
import 'package:ngewibu/app/routes/app_pages.dart';
import 'package:ngewibu/widgets/sawer.dart';

import '../../../../widgets/anime_item.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: SizedBox(
          height: 300,
          width: 250,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.openBottomSheet();
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
          future: controller.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorDua),
                      child: const Center(
                        child: Text(
                          'Genre Anime',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => SizedBox(
                        height: 85,
                        child: GridView.builder(
                          itemCount: controller.genres.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 3 / 11),
                          itemBuilder: (context, index) {
                            final Genres genre = controller.genres[index];
                            return Container(
                                padding: const EdgeInsets.all(3),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.GENRE_DETAIL,
                                          arguments: genre);
                                    },
                                    child: Text('${genre.name}')));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorDua),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'On-Going Anime',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.ANIME_ONGOING);
                                },
                                child: const Text('Lihat Semua'))
                          ],
                        ),
                      ),
                    ),
                    Sawer(
                      gotoLink: () {
                        controller
                            .launchURL('https://trakteer.id/ngewibuu/tip');
                      },
                    ),
                    Obx(
                      () => Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: controller.dataHomeOnGoing.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 4),
                            itemBuilder: (context, index) {
                              final OngoingAnime animeOngoing =
                                  controller.dataHomeOnGoing[index];
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.ANIME_DETAIL, arguments: {
                                    'title': animeOngoing.title,
                                    'slug': animeOngoing.slug
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.white54)),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 350,
                                        width: 300,
                                        child: Image.network(
                                          '${animeOngoing.poster}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                            ),
                                            color: colorSatu.withOpacity(0.9)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            '${animeOngoing.currentEpisode}',
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color:
                                                  colorSatu.withOpacity(0.9)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              '${animeOngoing.releaseDay}',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          width: Get.width,
                                          color: colorSatu.withOpacity(0.9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              animeOngoing.title!.length >= 20
                                                  ? '${animeOngoing.title!.substring(0, 20)}...'
                                                  : '${animeOngoing.title}',
                                              maxLines: 1,
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 20),
                            height: 40,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colorDua),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Complate Anime',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.ANIME_COMPLATE);
                                    },
                                    child: const Text('Lihat Semua'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: controller.dataHomeComplate.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 4),
                            itemBuilder: (context, index) {
                              final CompleteAnime animeComplate =
                                  controller.dataHomeComplate[index];
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.ANIME_DETAIL, arguments: {
                                    'title': animeComplate.title,
                                    'slug': animeComplate.slug
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.white54)),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 350,
                                        width: 300,
                                        child: Image.network(
                                          '${animeComplate.poster}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                            ),
                                            color: colorSatu.withOpacity(0.9)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            '${animeComplate.episodeCount} Episode',
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color:
                                                  colorSatu.withOpacity(0.9)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              '${animeComplate.rating}',
                                              style: TextStyle(
                                                  color: Colors.amber[400]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          width: Get.width,
                                          color: colorSatu.withOpacity(0.9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              animeComplate.title!.length >= 20
                                                  ? '${animeComplate.title!.substring(0, 20)}...'
                                                  : '${animeComplate.title}',
                                              maxLines: 1,
                                              style:
                                                  const TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      height: 40,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorDua),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Genre Action',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(
                                    Routes.GENRE_DETAIL,
                                    arguments: Genres(
                                      name: 'Action',
                                      slug: 'action',
                                      otakudesuUrl:
                                          'https://otakudesu.cloud/genres/action/',
                                    ),
                                  );
                                },
                                child: const Text('Lihat Semua'))
                          ],
                        ),
                      ),
                    ),
                    AnimeItem(dataGenre: controller.dataGenreAction),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      height: 40,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorDua),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Genre Comedy',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(
                                    Routes.GENRE_DETAIL,
                                    arguments: Get.toNamed(
                                      Routes.GENRE_DETAIL,
                                      arguments: Genres(
                                        name: 'Comedy',
                                        slug: 'comedy',
                                        otakudesuUrl:
                                            "https://otakudesu.cloud/genres/comedy/",
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Lihat Semua'))
                          ],
                        ),
                      ),
                    ),
                    AnimeItem(dataGenre: controller.dataGenreComedy),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      height: 40,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorDua),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Genre Ecchi',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(
                                    Routes.GENRE_DETAIL,
                                    arguments: Get.toNamed(
                                      Routes.GENRE_DETAIL,
                                      arguments: Genres(
                                        name: 'Ecchi',
                                        slug: 'ecchi',
                                        otakudesuUrl:
                                            "https://otakudesu.cloud/genres/ecchi/",
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Lihat Semua'))
                          ],
                        ),
                      ),
                    ),
                    AnimeItem(dataGenre: controller.dataGenreEcchi),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
