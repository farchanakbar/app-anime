import 'dart:convert';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:ngewibu/app/data/models/detail_episode.dart';

class DetailEpisodeController extends GetxController {
  Future<DetailEpisode> getDetailEpisode(String slug) async {
    Uri url = Uri.parse(
        'https://otakudesu-unofficial-api.vercel.app/v1/episode/$slug');
    var res = await http.get(url);
    Map<String, dynamic> data = json.decode(res.body)['data'];

    return DetailEpisode.fromJson(data);
  }

  Future<void> launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
