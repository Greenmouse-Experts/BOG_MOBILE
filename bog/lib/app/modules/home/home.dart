import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';

import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_drawer.dart';
import '../../global_widgets/bottom_widget.dart';

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
    return WillPopScope(
      onWillPop: () async => false,
      child: AppBaseView(
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
      ),
    );
  }
}
