import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ngewibu/app/constants/color.dart';
import 'package:ngewibu/app/data/models/genre_detail.dart';
import 'package:ngewibu/app/data/models/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/genres.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  late TextEditingController textEditingController = TextEditingController();
  var searchResults = [].obs;
  var genres = [].obs;
  var dataHomeOnGoing = [].obs;
  var dataHomeComplate = [].obs;
  var dataGenreAction = [].obs;
  var dataGenreComedy = [].obs;
  var dataGenreEcchi = [].obs;

  void launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> getAllData() async {
    await getAllGenres();
    await getHome();
    await getGenreAction();
    await getGenreComedy();
    await getGenreEcchi();
  }

  void searchAnime(String query) async {
    try {
      final response = await http.get(Uri.parse(
          'https://otakudesu-unofficial-api.vercel.app/v1/search/$query'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        searchResults.value = data['data'];
        if (query == '') {
          searchResults.value = [];
        }
      } else {
        // Handle error response
        searchResults.value = [];
      }
    } catch (e) {
      // Handle exception
      searchResults.value = [];
    }
  }

  Future<void> getHome() async {
    Uri url = Uri.parse('https://otakudesu-unofficial-api.vercel.app/v1/home');
    var res = await http.get(url);
    var data = Home.fromJson(json.decode(res.body)['data']);
    dataHomeOnGoing.value = data.ongoingAnime;
    dataHomeComplate.value = data.completeAnime;
  }

  Future<void> getAllGenres() async {
    Uri url =
        Uri.parse('https://otakudesu-unofficial-api.vercel.app/v1/genres');
    var res = await http.get(url);
    List? data = (json.decode(res.body) as Map<String, dynamic>)['data'];
    List<Genres> dataAnime = data!.map((e) => Genres.fromJson(e)).toList();
    genres.value = dataAnime;
  }

  Future<void> getGenreAction() async {
    Uri url = Uri.parse(
        'https://otakudesu-unofficial-api.vercel.app/v1/genres/action');
    var res = await http.get(url);
    List? data =
        (json.decode(res.body) as Map<String, dynamic>)['data']['anime'];
    List<Anime> dataAnime = data!.map((e) => Anime.fromJson(e)).toList();
    dataGenreAction.value = dataAnime;
  }

  Future<void> getGenreComedy() async {
    Uri url = Uri.parse(
        'https://otakudesu-unofficial-api.vercel.app/v1/genres/comedy');
    var res = await http.get(url);
    List? data =
        (json.decode(res.body) as Map<String, dynamic>)['data']['anime'];
    List<Anime> dataAnime = data!.map((e) => Anime.fromJson(e)).toList();
    dataGenreComedy.value = dataAnime;
  }

  Future<void> getGenreEcchi() async {
    Uri url = Uri.parse(
        'https://otakudesu-unofficial-api.vercel.app/v1/genres/ecchi');
    var res = await http.get(url);

    List? data =
        (json.decode(res.body) as Map<String, dynamic>)['data']['anime'];
    List<Anime> dataAnime = data!.map((e) => Anime.fromJson(e)).toList();
    dataGenreEcchi.value = dataAnime;
  }

  void openBottomSheet() {
    if (Get.isBottomSheetOpen == false) {
      textEditingController.clear();
      searchResults.value = [];
    }
    Get.bottomSheet(
      Container(
        height: Get.height * 0.5,
        width: Get.width,
        decoration: const BoxDecoration(
          color: colorSatu,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Cari Judul Anime',
                  labelText: 'Judul Anime',
                  labelStyle: const TextStyle(color: colorEmpat),
                  hintStyle: const TextStyle(color: colorEmpat),
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  searchAnime(value);
                },
              ),
              Obx(() => Expanded(
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final anime = searchResults[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorDua,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ListTile(
                                    onTap: () async {
                                      await Get.toNamed(Routes.ANIME_DETAIL,
                                          arguments: {
                                            'title': anime['title'],
                                            'slug': anime['slug']
                                          });
                                      textEditingController.clear();
                                      Get.back();
                                    },
                                    leading: Image.network(anime['poster']),
                                    title: Text(
                                      '${anime['title']}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
