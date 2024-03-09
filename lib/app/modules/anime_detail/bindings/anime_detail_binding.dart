import 'package:get/get.dart';

import '../controllers/anime_detail_controller.dart';

class AnimeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimeDetailController>(
      () => AnimeDetailController(),
    );
  }
}
