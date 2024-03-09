import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/data/models/anime_detail.dart';
import 'package:ngewibu/app/data/models/detail_episode.dart';

import '../controllers/detail_episode_controller.dart';

class DetailEpisodeView extends GetView<DetailEpisodeController> {
  const DetailEpisodeView({super.key});
  @override
  Widget build(BuildContext context) {
    final int episode = Get.arguments['index'];
    final String slug = Get.arguments['slug'];
    final AnimeDetail animeDetail = Get.arguments['data'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Episode ${episode + 1}'),
        centerTitle: true,
      ),
      body: FutureBuilder<DetailEpisode>(
        future: controller.getDetailEpisode(slug, '${episode + 1}'),
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

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 300,
                      width: 200,
                      child: Image.network(
                        '${animeDetail.poster}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    '${episodeDetail?.episode}',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Download',
                    textAlign: TextAlign.start,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            for (var i
                                in episodeDetail!.downloadUrls['mp4']!.toList())
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
                                                  child:
                                                      Text('${link.provider}')),
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
                  const Text('Streaming'),
                  ElevatedButton.icon(
                      onPressed: () {
                        controller.launchURL('${episodeDetail.streamUrl}');
                      },
                      icon: const Icon(Icons.live_tv),
                      label: const Text('Streaming'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
