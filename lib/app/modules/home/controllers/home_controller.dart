import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ngewibu/app/data/models/genre_detail.dart';
import 'package:ngewibu/app/data/models/home.dart';

import '../../../data/models/genres.dart';

class HomeController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  late TextEditingController textEditingController = TextEditingController();
  var searchResults = [].obs;
  var genres = [].obs;
  var dataHomeOnGoing = [].obs;
  var dataHomeComplate = [].obs;
  var dataGenreAction = [].obs;
  var dataGenreComedy = [].obs;
  var dataGenreEcchi = [].obs;

  Future<void> getAllData() async {
    await getHome();
    await getAllGenres();
    await getGenreAction();
    await getGenreComedy();
    await getGenreEcchi();
  }

  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  void searchAnime(String query) async {
    try {
      final response = await http.get(Uri.parse(
          'https://otakudesu-unofficial-api.rzkfyn.xyz/v1/search/$query'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        searchResults.value = data['data'];
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
    Uri url = Uri.parse('https://otakudesu-unofficial-api.rzkfyn.xyz/v1/home');
    var res = await http.get(url);
    var data = Home.fromJson(json.decode(res.body)['data']);
    dataHomeOnGoing.value = data.ongoingAnime;
    dataHomeComplate.value = data.completeAnime;
  }

  Future<void> getAllGenres() async {
    Uri url =
        Uri.parse('https://otakudesu-unofficial-api.rzkfyn.xyz/v1/genres');
    var res = await http.get(url);
    List? data = (json.decode(res.body) as Map<String, dynamic>)['data'];
    List<Genres> dataAnime = data!.map((e) => Genres.fromJson(e)).toList();
    genres.value = dataAnime;
  }

  Future<void> getGenreAction() async {
    Uri url = Uri.parse(
        'https://otakudesu-unofficial-api.rzkfyn.xyz/v1/genres/action');
    var res = await http.get(url);
    List? data =
        (json.decode(res.body) as Map<String, dynamic>)['data']['anime'];
    List<Anime> dataAnime = data!.map((e) => Anime.fromJson(e)).toList();
    dataGenreAction.value = dataAnime;
  }

  Future<void> getGenreComedy() async {
    Uri url = Uri.parse(
        'https://otakudesu-unofficial-api.rzkfyn.xyz/v1/genres/comedy');
    var res = await http.get(url);
    List? data =
        (json.decode(res.body) as Map<String, dynamic>)['data']['anime'];
    List<Anime> dataAnime = data!.map((e) => Anime.fromJson(e)).toList();
    dataGenreComedy.value = dataAnime;
  }

  Future<void> getGenreEcchi() async {
    Uri url = Uri.parse(
        'https://otakudesu-unofficial-api.rzkfyn.xyz/v1/genres/ecchi');
    var res = await http.get(url);

    List? data =
        (json.decode(res.body) as Map<String, dynamic>)['data']['anime'];
    List<Anime> dataAnime = data!.map((e) => Anime.fromJson(e)).toList();
    dataGenreEcchi.value = dataAnime;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    textEditingController.clear();
    super.onClose();
  }

  void increment() => count.value++;
}
