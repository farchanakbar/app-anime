import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/constants/color.dart';
import 'package:ngewibu/app/data/models/genres.dart';
import 'package:ngewibu/app/data/models/home.dart';
import 'package:ngewibu/app/routes/app_pages.dart';

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
          height: 200,
          width: 150,
          child: Image.asset('assets/images/logo.png'),
        ),
        actions: [
          Obx(() => IconButton(
              onPressed: () {
                controller.switchTheme();
                Get.changeThemeMode(controller.currentTheme.value);
              },
              icon: Icon(controller.currentTheme.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode))),
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  height: Get.height * 0.5,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: colorSatu,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: controller.textEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Cari Judul Anime',
                            labelText: 'Judul Anime',
                            labelStyle: const TextStyle(color: colorEmpat),
                            hintStyle: const TextStyle(color: colorEmpat),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.textEditingController.clear();
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            controller.searchAnime(value);
                          },
                        ),
                        Obx(() => Expanded(
                              child: ListView.builder(
                                itemCount: controller.searchResults.length,
                                itemBuilder: (context, index) {
                                  final anime = controller.searchResults[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () async {
                                            await Get.toNamed(
                                                Routes.ANIME_DETAIL,
                                                arguments: {
                                                  'title': anime['title'],
                                                  'slug': anime['slug']
                                                });
                                            controller.textEditingController
                                                .clear();
                                            Get.back();
                                          },
                                          leading:
                                              Image.network(anime['poster']),
                                          title: Text(
                                            '${anime['title']}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          height: 1,
                                          width: Get.width,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
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
                      height: 20,
                    ),
                    const Text(
                      'Genre Anime',
                      style: TextStyle(fontSize: 20),
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
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Update Terbaru',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.ANIME_ONGOING);
                            },
                            child: const Text('Lihat Semua'))
                      ],
                    ),
                    SingleChildScrollView(
                      child: Obx(
                        () => Column(
                          children: [
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
                                    Get.toNamed(Routes.ANIME_DETAIL,
                                        arguments: {
                                          'title': animeOngoing.title,
                                          'slug': animeOngoing.slug
                                        });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: 200,
                                            width: 300,
                                            child: Image.network(
                                              '${animeOngoing.poster}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              color: colorDua.withOpacity(0.8),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  '${animeOngoing.currentEpisode}',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            '${animeOngoing.title}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Anime Complate',
                                  style: TextStyle(fontSize: 20),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.ANIME_COMPLATE);
                                    },
                                    child: const Text('Lihat Semua'))
                              ],
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
                                    Get.toNamed(Routes.ANIME_DETAIL,
                                        arguments: {
                                          'title': animeComplate.title,
                                          'slug': animeComplate.slug
                                        });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: 200,
                                            width: 300,
                                            child: Image.network(
                                              '${animeComplate.poster}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              color: colorDua.withOpacity(0.8),
                                              child: const Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Text('Complate'),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              color: colorDua.withOpacity(0.8),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: Text(
                                                  animeComplate.rating != ''
                                                      ? '${animeComplate.rating}'
                                                      : '0.0',
                                                  style: const TextStyle(
                                                      color: Colors.yellow),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            '${animeComplate.title}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Genre Action',
                          style: TextStyle(fontSize: 20),
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
                    AnimeItem(dataGenre: controller.dataGenreAction),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Genre Comedy',
                          style: TextStyle(fontSize: 20),
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
                    AnimeItem(dataGenre: controller.dataGenreComedy),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Genre Ecchi',
                          style: TextStyle(fontSize: 20),
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
                    AnimeItem(dataGenre: controller.dataGenreEcchi),
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
