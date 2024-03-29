import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../data/model/gen_kyc.dart';
import '../../data/model/log_in_model.dart';
import '../../data/model/user_details_model.dart';
import '../../data/providers/api.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_drawer.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/global_widgets.dart';
import '../../repository/user_repo.dart';
import '../settings/view_kyc.dart';
import '../subscription/subscription_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<void> getUser;
  @override
  void initState() {
    Get.put(HomeController(UserRepository(Api())));
    super.initState();

    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    var homeController = Get.find<HomeController>();
    var type = logInDetails.userType;
    getUser = homeController.getUser(type.toString());
    if (type == "private_client") {
      homeController.currentType = "Client";
      homeController.update();
      homeController.updateNewUser('Client');
    } else if (type == "vendor") {
      homeController.currentType = "Product Partner";
      homeController.update();
      homeController.updateNewUser('Product Partner');
      verifyKycComplete(
        'vendor',
      );
    } else if (type == 'professional') {
      homeController.currentType = 'Service Partner';
      homeController.update();
      homeController.updateNewUser('Service Partner');
      verifyKycComplete(
        'professional',
      );
    } else {
      homeController.currentType = "Corporate Client";
      homeController.update();
      homeController.updateNewUser('Corporate Client');
    }

    homeController.update();
  }

  void verifyKycComplete(
    String type,
  ) async {
    final controller = Get.find<HomeController>();
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    final res = await controller.userRepo
        .getData('/kyc/user-kyc/${logInDetails.id}?userType=$type');
    final newRes = await controller.userRepo.getData('/user/me?userType=$type');

    // print(newRes.message);

    final userDetails = UserDetailsModel.fromJson(newRes.user);
    final kyc = GenKyc.fromJson(res.data);
    MyPref.genKyc.val = jsonEncode(kyc);
    MyPref.userDetails.val = jsonEncode(userDetails);

    if (kyc.isKycCompleted != true) {
      MyPref.setOverlay.val = true;

      AppOverlay.showKycDialog(
          title: 'KYC NOT COMPLETE',
          buttonText: 'Complete KYC',
          content:
              "You haven't completed your KYC yet, Kindly Complete your KYC and subscribe to access all features",
          onPressed: () {
            Get.to(() => const KYCPage());
          });
    } else if (userDetails.profile!.hasActiveSubscription != true) {
      MyPref.setSubscribeOverlay.val = true;
      AppOverlay.showSubscribeDialog(
          title: 'No Active Subscriptions',
          buttonText: 'Subscribe',
          content:
              "You don't have an active subscription, select a subscription to enjoy full benefits",
          onPressed: () => Get.to(() => const SubscriptionScreen()));
    } else {
      MyPref.setOverlay.val = false;
      MyPref.setSubscribeOverlay.val = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get.put(HomeController(UserRepository(Api())));
    return WillPopScope(
      onWillPop: () async => false,
      child: AppBaseView(
        child: GetBuilder<HomeController>(
            id: 'home',
            builder: (controller) {
              return FutureBuilder(
                  future: getUser,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(child: AppLoader()),
                      );
                    }
                    return Scaffold(
                      body: SizedBox(
                        width: Get.width,
                        child: controller.currentBottomNavPage.value == 4 ||
                                controller.currentBottomNavPage.value == 0
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    controller.pages[
                                        controller.currentBottomNavPage.value],
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  controller.pages[
                                      controller.currentBottomNavPage.value],
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
                  });
            }),
      ),
    );
  }
}
