import 'package:bog/app/base/app_builder.dart';
import 'package:bog/app/blocs/mode_controller.dart';
import 'package:bog/app/blocs/nav_controller.dart';
import 'package:bog/app/blocs/trigger_mode_controller.dart';
import 'package:bog/core/widgets/popup_widget/bloc/popup_controller.dart';
import 'package:bog/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'core/theme/app_themes.dart';
import 'core/widgets/loading_widget/loading_widget.dart';

Future<void> main() async {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //wait three seconds
  await Future.delayed(const Duration(seconds: 3));
  await GetStorage.init('MyPref');
  Get.put(LoadingController());
  Get.put(PopupController());
  Get.put(ModeController());
  Get.put(NavController());
  Get.put(TriggerModeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //FlutterNativeSplash.remove();
    return AppBuilder(
      theme: AppThemes.lightTheme,
      builder: (theme) {
        return GetMaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        );
      }
    );
  }
}