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
   
    var type = logInDetails.userType;
    if (type == "private_client") {
      homeController.currentType = "Client";
    } else if (type == "vendor") {
      homeController.currentType = "Product Partner";
    } else if (type == 'professional'){
      homeController.currentType = 'Service Partner';
    }
    else {
      homeController.currentType = "Corporate Client";
    }
    homeController.updateNewUser(
        logInDetails.userType
            .toString()
            .replaceAll("_", " ")
            .capitalizeFirst
            .toString(),
        updatePages: true);
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
                  HomeBottomWidget(controller: controller, isHome: true, doubleNavigate: false,),
                drawer: const AppDrawer(),
              );
            }),
      ),
    );
  }
}
