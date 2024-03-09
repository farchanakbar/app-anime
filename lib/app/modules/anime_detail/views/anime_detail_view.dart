import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/data/models/genres.dart';

import '../../../routes/app_pages.dart';
import '../controllers/anime_detail_controller.dart';

class AnimeDetailView extends GetView<AnimeDetailController> {
  const AnimeDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments['title'];
    final String slug = Get.arguments['slug'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getAnimeDetail(slug),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('tidak ada data'),
            );
          }

          final animeDetail = snapshot.data;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.amber,
                        height: 200,
                        width: Get.width * 0.4,
                        child: Image.network(
                          '${animeDetail?.poster}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '${animeDetail?.title} ${animeDetail?.japaneseTitle}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Rating : ',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        animeDetail?.rating != ''
                            ? '${animeDetail?.rating}'
                            : 'Unknown',
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 14),
                      ),
                    ],
                  ),
                  Text(
                    'Status : ${animeDetail?.status}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Studio : ${animeDetail?.studio}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Jumlah Episode : ${animeDetail?.episodeCount}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Durasi : ${animeDetail?.duration}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Text(
                          'Genre :',
                          style: TextStyle(fontSize: 14),
                        ),
                        for (var i in animeDetail!.genres!
                            .toList()
                            .where((item) => item.name != ' '))
                          TextButton(
                              onPressed: () {
                                Get.toNamed(
                                  Routes.GENRE_DETAIL,
                                  arguments: Genres(
                                    name: i.name,
                                    slug: i.slug,
                                    otakudesuUrl: i.otakudesuUrl,
                                  ),
                                );
                              },
                              child: Text('${i.name}'))
                      ],
                    ),
                  ),
                  Text(
                    animeDetail.synopsis != ''
                        ? 'Synopsis : ${animeDetail.synopsis}'
                        : 'Synopsis : tidak ada',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Text(
                    'Episode :',
                    style: TextStyle(fontSize: 14),
                  ),
                  GridView.builder(
                    itemCount: animeDetail.episodeLists?.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 9 / 3,
                    ),
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () {
                          Get.toNamed(
                            Routes.DETAIL_EPISODE,
                            arguments: {
                              'index': index,
                              'slug': slug,
                              'data': animeDetail
                            },
                          );
                        },
                        child: Text('Episode ${index + 1}'),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Rekomendasi Anime',
                    style: TextStyle(fontSize: 18),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: animeDetail.recommendations?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4),
                    itemBuilder: (context, index) {
                      final recomendation = animeDetail.recommendations![index];
                      return InkWell(
                        onTap: () {
                          Get.offAndToNamed(Routes.ANIME_DETAIL, arguments: {
                            'title': recomendation.title,
                            'slug': recomendation.slug
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
                                    '${recomendation.poster}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  '${recomendation.title}',
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
