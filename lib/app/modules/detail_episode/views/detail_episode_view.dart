import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/constants/color.dart';
import 'package:ngewibu/app/data/models/detail_episode.dart';
import 'package:ngewibu/app/routes/app_pages.dart';

import '../controllers/detail_episode_controller.dart';

class DetailEpisodeView extends GetView<DetailEpisodeController> {
  const DetailEpisodeView({super.key});
  @override
  Widget build(BuildContext context) {
    final slug = Get.arguments['slug'];
    final poster = Get.arguments['poster'];
    return Scaffold(
      body: FutureBuilder<DetailEpisode>(
        future: controller.getDetailEpisode(slug.toString()),
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
          final episodeDetail = snapshot.data;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Kembali')),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 1,
                          color: Colors.white,
                        )),
                        height: 300,
                        width: Get.width * 0.8,
                        child: Image.network(
                          '$poster',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      '${episodeDetail?.episode}',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        episodeDetail?.hasPreviousEpisode == false
                            ? const SizedBox()
                            : TextButton(
                                onPressed: () {
                                  Get.offNamed(
                                      preventDuplicates: false,
                                      Routes.DETAIL_EPISODE,
                                      arguments: {
                                        'poster': poster,
                                        'slug': episodeDetail
                                            ?.previousEpisode['slug']
                                      });
                                  print(
                                      '${episodeDetail?.previousEpisode['slug']}');
                                },
                                child: const Text('Sebelumnya')),
                        episodeDetail?.hasNextEpisode != true
                            ? const SizedBox()
                            : TextButton(
                                onPressed: () {
                                  Get.offNamed(Routes.DETAIL_EPISODE,
                                      preventDuplicates: false,
                                      arguments: {
                                        'poster': poster,
                                        'slug': episodeDetail?.nextEpisode?.slug
                                      });
                                  print('${episodeDetail?.nextEpisode?.slug}');
                                  ;
                                },
                                child: const Text('Selanjutnya')),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorDua),
                      child: const Center(
                        child: Text(
                          'Download',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i in episodeDetail!.downloadUrls['mp4']!
                                  .toList())
                                Row(
                                  children: [
                                    Text('${i.resolution}'),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    for (var link in i.urls.toList())
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 30,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      controller.launchURL(
                                                          '${link.url}');
                                                    },
                                                    child: Text(
                                                        '${link.provider}')),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 40,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colorDua),
                      child: const Center(
                        child: Text(
                          'Streaming Anime',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          controller.launchURL('${episodeDetail.streamUrl}');
                        },
                        icon: const Icon(Icons.live_tv),
                        label: const Text('Streaming')),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
