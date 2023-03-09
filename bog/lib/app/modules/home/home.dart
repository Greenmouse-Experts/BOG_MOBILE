import 'dart:convert';

import 'package:bog/app/global_widgets/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';
// import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    var type = logInDetails.userType
        .toString()
        .replaceAll("_", " ")
        .capitalizeFirst
        .toString();
    if (type == "Client") {
      homeController.currentType = "Client";
    } else if (type == "Vendor") {
      homeController.currentType = "Product Partner";
    } else {
      homeController.currentType = "Service Partner";
    }
    homeController.updateNewUser(
        logInDetails.userType
            .toString()
            .replaceAll("_", " ")
            .capitalizeFirst
            .toString(),
        updatePages: false);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: GetBuilder<HomeController>(
          id: 'home',
          builder: (controller) {
            return Scaffold(
              body: SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    controller.pages[controller.currentBottomNavPage.value],
                  ],
                ),
              ),
              bottomNavigationBar:
                  HomeBottomWidget(controller: controller, isHome: true),
              drawer: const AppDrawer(),
            );
          }),
    );
  }
}
