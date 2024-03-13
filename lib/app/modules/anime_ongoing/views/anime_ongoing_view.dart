import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/constants/color.dart';
import 'package:ngewibu/app/data/models/detail_ongoing.dart';

import '../../../routes/app_pages.dart';
import '../controllers/anime_ongoing_controller.dart';

class AnimeOngoingView extends GetView<AnimeOngoingController> {
  const AnimeOngoingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime OnGoing'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getAllOngoing(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                          final Datum animeOngoing = controller.allAnime[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.ANIME_DETAIL, arguments: {
                                'title': animeOngoing.title,
                                'slug': animeOngoing.slug
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
                                      '${animeOngoing.poster}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
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
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          color: colorSatu.withOpacity(0.9)),
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
                      ),
                      Obx(() => Text(
                          controller.selesai.value ? 'Halaman Terakhir' : '')),
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
                                        controller.tambahAnime();
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
