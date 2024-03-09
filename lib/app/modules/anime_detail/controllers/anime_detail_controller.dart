import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ngewibu/app/data/models/anime_detail.dart';

class AnimeDetailController extends GetxController {
  Future<AnimeDetail> getAnimeDetail(String slug) async {
    Uri url =
        Uri.parse('https://otakudesu-unofficial-api.rzkfyn.xyz/v1/anime/$slug');
    var res = await http.get(url);
    Map<String, dynamic> data = json.decode(res.body)['data'];

    return AnimeDetail.fromJson(data);
  }
  //TODO: Implement AnimeDetailController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
