import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ngewibu/app/data/models/detail_complate.dart';

class AnimeComplateController extends GetxController {
  var allAnime = [].obs;
  var page = 1.obs;
  int? limit;
  var selesai = false.obs;
  var isLoading = false.obs;

  Future<void> getAllOngoing() async {
    try {
      final response = await http.get(Uri.parse(
          'https://otakudesu-unofficial-api.vercel.app/v1/complete-anime/$page'));

      if (response.statusCode == 200) {
        final data = DetailComplate.fromJson(json.decode(response.body));
        allAnime.value = data.data;
        limit = data.pagination?.lastVisiblePage;
      } else {
        // Handle error response
        allAnime.value = [];
      }
    } catch (e) {
      // Handle exception
      allAnime.value = [];
    }
  }

  void tambahAnime() async {
    if (page.toInt() == limit) {
      selesai.value = true;
    } else {
      try {
        isLoading.value = true;
        page++;
        final response = await http.get(Uri.parse(
            'https://otakudesu-unofficial-api.vercel.app/v1/complete-anime/$page'));

        if (response.statusCode == 200) {
          final data = DetailComplate.fromJson(json.decode(response.body));
          allAnime.addAll(data.data);
          isLoading.value = false;
        } else {
          // Handle error response
          allAnime.addAll([]);
        }
      } catch (e) {
        // Handle exception
        allAnime.addAll([]);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllOngoing();
  }
}
