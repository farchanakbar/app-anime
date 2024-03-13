import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ngewibu/app/data/models/genres.dart';
import 'package:ngewibu/app/routes/app_pages.dart';
import '../../../data/models/anime_detail.dart';

class ListDetail extends StatelessWidget {
  const ListDetail({
    super.key,
    required this.animeDetail,
  });

  final AnimeDetail? animeDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailAnime(title: 'Judul', data: animeDetail!.title.toString()),
        DetailAnime(
            title: 'Japanese', data: animeDetail!.japaneseTitle.toString()),
        Row(
          children: [
            const Text(
              'Rating : ',
              style: TextStyle(fontSize: 15),
            ),
            Expanded(
              child: Text(
                '${animeDetail?.rating}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15, color: Colors.amber),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 1,
          width: Get.width,
          color: Colors.white70,
        ),
        DetailAnime(title: 'Produser', data: '${animeDetail!.produser}'),
        DetailAnime(title: 'Tipe', data: '${animeDetail!.type}'),
        DetailAnime(title: 'Status', data: '${animeDetail!.status}'),
        DetailAnime(
            title: 'Total Episode', data: '${animeDetail!.episodeCount}'),
        DetailAnime(title: 'Durasi', data: '${animeDetail!.duration}'),
        DetailAnime(
            title: 'Tanggal Rilis', data: '${animeDetail!.releaseDate}'),
        DetailAnime(title: 'Studio', data: '${animeDetail!.studio}'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const Text(
                'Genre : ',
                style: TextStyle(fontSize: 15),
              ),
              for (var i in animeDetail!.genres!
                  .toList()
                  .where((element) => element.name != ' '))
                TextButton(
                    onPressed: () {
                      final Genres data = Genres(
                          name: i.name,
                          slug: i.slug,
                          otakudesuUrl: i.otakudesuUrl);
                      Get.toNamed(Routes.GENRE_DETAIL, arguments: data);
                    },
                    child: Text('${i.name}')),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 1,
          width: Get.width,
          color: Colors.white70,
        ),
        Text(
          '${animeDetail?.synopsis}',
          style: const TextStyle(fontSize: 15, color: Colors.white60),
        ),
      ],
    );
  }
}

class DetailAnime extends StatelessWidget {
  const DetailAnime({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$title : ',
              style: const TextStyle(fontSize: 15),
            ),
            Expanded(
              child: Text(
                data,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15, color: Colors.white60),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 1,
          width: Get.width,
          color: Colors.white70,
        )
      ],
    );
  }
}
