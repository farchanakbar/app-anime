import 'package:get/get.dart';

import '../controllers/detail_episode_controller.dart';

class DetailEpisodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailEpisodeController>(
      () => DetailEpisodeController(),
    );
  }
}
