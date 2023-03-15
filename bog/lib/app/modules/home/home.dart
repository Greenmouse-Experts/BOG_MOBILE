import 'dart:convert';

import 'package:bog/app/data/model/gen_kyc.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/modules/settings/view_kyc.dart';
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
      homeController.update();
      homeController.updateNewUser('Client');
    } else if (type == "vendor") {
      homeController.currentType = "Product Partner";
      homeController.update();
      homeController.updateNewUser('Product Partner');
      verifyKycComplete('vendor', () {});
    } else if (type == 'professional') {
      homeController.currentType = 'Service Partner';
      homeController.update();
      homeController.updateNewUser('Service Partner');
      verifyKycComplete('professional', () {
        Get.to(() => const KYCPage());
      });
    } else {
      homeController.currentType = "Corporate Client";
      homeController.update();
      homeController.updateNewUser('Corporate Client');
    }

    homeController.update();
  }

  void verifyKycComplete(String type, VoidCallback onPressed) async {
    final controller = Get.find<HomeController>();
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    final res = await controller.userRepo
        .getData('/kyc/user-kyc/${logInDetails.id}?userType=$type');
    final kyc = GenKyc.fromJson(res.data);
    if (kyc.isKycCompleted != true) {
      AppOverlay.showInfoDialog(
          title: 'Kyc Not Complete',
          buttonText: 'Complete KYC',
          content:
              "You haven't completed your KYC yet, Kindly Complete your KYC now",
          onPressed: onPressed);
    }
  }

  @override
  Widget build(BuildContext context) {
    // verifyKycComplete();
    // var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    // if (logInDetails.userType == 'vendor' ||
    //     logInDetails.userType == 'professional') {
    //   verifyKycComplete(logInDetails.userType!);
    // }

    return WillPopScope(
      onWillPop: () async => false,
      child: AppBaseView(
        child: GetBuilder<HomeController>(
            id: 'home',
            builder: (controller) {
              return Scaffold(
                body: SizedBox(
                  width: Get.width,
                  child: controller.currentBottomNavPage.value == 4 ||
                          controller.currentBottomNavPage.value == 0
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              controller
                                  .pages[controller.currentBottomNavPage.value],
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            controller
                                .pages[controller.currentBottomNavPage.value],
                          ],
                        ),
                ),
                bottomNavigationBar: HomeBottomWidget(
                  controller: controller,
                  isHome: true,
                  doubleNavigate: false,
                ),
                drawer: const AppDrawer(),
              );
            }),
      ),
    );
  }
}
