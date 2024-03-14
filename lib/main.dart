import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:ngewibu/app/constants/color.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    GetMaterialApp(
      theme: CustomTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      title: "NgeWibuu",
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    ),
  );
}
