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
        itemCount: dataGenre?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisExtent: 250,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4),
        itemBuilder: (context, index) {
          final genre.Anime dataAnime = dataGenre![index];
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.ANIME_DETAIL, arguments: {
                'title': dataAnime.title,
                'slug': dataAnime.slug
              });
            },
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white54)),
              child: Stack(
                children: [
                  SizedBox(
                    height: 350,
                    width: 300,
                    child: Image.network(
                      '${dataAnime.poster}',
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
                        dataAnime.episodeCount != null
                            ? '${dataAnime.episodeCount} Episode'
                            : 'On-Going',
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
                          dataAnime.rating != ''
                              ? '${dataAnime.rating}'
                              : 'No Rating',
                          style: TextStyle(color: Colors.amber[400]),
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
                          dataAnime.title!.length >= 20
                              ? '${dataAnime.title!.substring(0, 20)}...'
                              : '${dataAnime.title}',
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
    );
  }
}
