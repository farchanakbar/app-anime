import 'package:get/get.dart';

import '../controllers/anime_ongoing_controller.dart';

class AnimeOngoingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimeOngoingController>(
      () => AnimeOngoingController(),
    );
  }
}
