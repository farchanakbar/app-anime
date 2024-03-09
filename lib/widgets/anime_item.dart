import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngewibu/app/constants/color.dart';
import 'package:ngewibu/app/data/models/genre_detail.dart' as genre;
import 'package:ngewibu/app/routes/app_pages.dart';

class AnimeItem extends StatelessWidget {
  const AnimeItem({
    super.key,
    required this.dataGenre,
  });

  final RxList<dynamic>? dataGenre;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: dataGenre?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisExtent: 250,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4),
        itemBuilder: (context, index) {
          final genre.Anime genredataGenre = dataGenre![index];
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.ANIME_DETAIL, arguments: {
                'title': dataGenre![index].title,
                'slug': dataGenre![index].slug
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
                        '${genredataGenre.poster}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        color: colorDua.withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(genredataGenre.episodeCount != null
                              ? 'Total Eps ${genredataGenre.episodeCount}'
                              : 'Unknown'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        color: colorDua.withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            genredataGenre.rating != ''
                                ? '${genredataGenre.rating}'
                                : '0.0',
                            style: const TextStyle(color: Colors.yellow),
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
                      '${genredataGenre.title}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
