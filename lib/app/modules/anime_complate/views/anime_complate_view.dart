import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/constants/color.dart';

import '../../../data/models/detail_complate.dart' as complate;
import '../../../routes/app_pages.dart';
import '../controllers/anime_complate_controller.dart';

class AnimeComplateView extends GetView<AnimeComplateController> {
  const AnimeComplateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Complate'),
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
                          final complate.Datum animeComplate =
                              controller.allAnime[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.ANIME_DETAIL, arguments: {
                                'title': animeComplate.title,
                                'slug': animeComplate.slug
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
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      '${animeComplate.title}',
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
