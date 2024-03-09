import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/constants/color.dart';
import 'package:ngewibu/app/data/models/genre_detail.dart' as genre;
import '../../../data/models/genres.dart';
import '../../../routes/app_pages.dart';
import '../controllers/genre_detail_controller.dart';

class GenreDetailView extends GetView<GenreDetailController> {
  const GenreDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    Genres data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('${data.name}'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getAllAnimeGenre(data.name.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (controller.allAnime.isEmpty) {
              return Center(
                child: Text('tidak ada anime genre ${data.name}'),
              );
            } else {
              return Obx(
                () => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.allAnime.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 250,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 3 / 4),
                          itemBuilder: (context, index) {
                            final genre.Anime animeOngoing =
                                controller.allAnime[index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(Routes.ANIME_DETAIL, arguments: {
                                  'title': animeOngoing.title,
                                  'slug': animeOngoing.slug
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            padding: const EdgeInsets.all(5),
                                            child: Text(animeOngoing
                                                        .episodeCount !=
                                                    null
                                                ? 'Total Eps ${animeOngoing.episodeCount}'
                                                : 'Unknown'),
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
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() => Text(controller.selesai.value
                            ? 'Halaman Terakhir'
                            : '')),
                        controller.selesai.value
                            ? const SizedBox()
                            : Obx(
                                () => controller.isLoading.value
                                    ? const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          controller.tambahAnime(
                                              data.name.toString());
                                        },
                                        child: const Text('Tambah Anime'),
                                      ),
                              ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
