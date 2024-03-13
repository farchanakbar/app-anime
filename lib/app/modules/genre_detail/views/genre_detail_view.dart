import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/modules/home/controllers/home_controller.dart';
import 'package:ngewibu/widgets/anime_item.dart';
import 'package:ngewibu/widgets/sawer.dart';
import '../../../data/models/genres.dart';
import '../controllers/genre_detail_controller.dart';

class GenreDetailView extends GetView<GenreDetailController> {
  const GenreDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final url = Get.find<HomeController>();
    Genres data = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Genre ${data.name}'),
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
                        Sawer(
                          gotoLink: () {
                            url.launchURL('https://trakteer.id/ngewibuu/tip');
                          },
                        ),
                        AnimeItem(dataGenre: controller.allAnime),
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
