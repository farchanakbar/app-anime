import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:ngewibu/app/constants/color.dart';
import 'package:ngewibu/app/data/models/anime_detail.dart';

import '../../../routes/app_pages.dart';
import '../controllers/anime_detail_controller.dart';
import 'list_detail.dart';

class AnimeDetailView extends GetView<AnimeDetailController> {
  const AnimeDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final title = Get.arguments['title'];
    final slug = Get.arguments['slug'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$title',
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white)),
                      height: 300,
                      width: Get.width * 0.8,
                      child: Image.network(
                        '${animeDetail?.poster}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListDetail(animeDetail: animeDetail),
                  const Text(
                    'Episode :',
                    style: TextStyle(fontSize: 15),
                  ),
                  ListView.builder(
                    itemCount: animeDetail?.episodeLists?.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed(
                                Routes.DETAIL_EPISODE,
                                arguments: {
                                  'poster': animeDetail.poster,
                                  'slug': animeDetail.episodeLists?[index].slug
                                },
                              );
                            },
                            child: Text(
                                '${animeDetail!.episodeLists?[index].episode}'),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 1,
                            width: Get.width,
                            color: Colors.white70,
                          )
                        ],
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorDua),
                    child: const Center(
                      child: Text(
                        'Rekomendasi Anime',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: animeDetail?.recommendations?.length ?? 0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3 / 4),
                    itemBuilder: (context, index) {
                      final Recommendation animeRecomendation =
                          animeDetail!.recommendations![index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.ANIME_DETAIL,
                              preventDuplicates: false,
                              arguments: {
                                'title': animeRecomendation.title,
                                'slug': animeRecomendation.slug
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white54)),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 350,
                                width: 300,
                                child: Image.network(
                                  '${animeRecomendation.poster}',
                                  fit: BoxFit.cover,
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
                                      animeRecomendation.title!.length >= 20
                                          ? '${animeRecomendation.title!.substring(0, 20)}...'
                                          : '${animeRecomendation.title}',
                                      maxLines: 1,
                                      style: const TextStyle(fontSize: 13),
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
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
