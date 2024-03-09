import 'package:get/get.dart';

import '../controllers/anime_complate_controller.dart';

class AnimeComplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimeComplateController>(
      () => AnimeComplateController(),
    );
  }
}
