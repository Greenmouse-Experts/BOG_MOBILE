import 'dart:convert';


import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';


class SwitchUser extends GetView<HomeController> {
  const SwitchUser({Key? key}) : super(key: key);

  static const route = '/create';

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AppBaseView(
      child: GetBuilder<HomeController>(
            id: 'Switch',
            builder: (controller) {
              var logInDetails =
                  LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
              return Scaffold(
                backgroundColor: AppColors.backgroundVariant2,
                body: SizedBox(
                  width: Get.width,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: width * 0.05,
                                left: width * 0.045,
                                top: kToolbarHeight),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/back.svg",
                                    height: width * 0.045,
                                    width: width * 0.045,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.04,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Switch Account",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.07,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.04,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: width * 0.04,
                          ),
                          Container(
                            height: 1,
                            width: width,
                            color: AppColors.grey.withOpacity(0.1),
                          ),
                          SizedBox(
                            height: width * 0.04,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: Row(
                              children: [
                                Text(
                                  "Currently logged in as : ",
                                  style: AppTextStyle.subtitle1.copyWith(
                                      fontSize: multiplier * 0.08,
                                      color: Colors.black.withOpacity(.7),
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  controller.currentType,
                                  style: AppTextStyle.subtitle1.copyWith(
                                      fontSize: multiplier * 0.08,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: width * 0.1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.05, right: width * 0.05),
                            child: Text(
                              "Switch To :",
                              style: AppTextStyle.subtitle1.copyWith(
                                  fontSize: multiplier * 0.08,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          if (controller.currentType != "Client")
                            SizedBox(
                              height: Get.height * 0.04,
                            ),
                          if (controller.currentType != "Client")
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.05),
                              child: InkWell(
                                onTap: () async {
                                  controller.currentType = "Client";
                                  controller.update();
                                  controller.updateNewUser("Client");
                                  Get.back();
                                  var body = {
                                    "userType": "private_client",
                                  };
                                  var response = await controller.userRepo
                                      .postData("/user/switch-account", body);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/client_bg.png',
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Image.asset(
                                          'assets/images/m2.png',
                                          width: Get.width * 0.15,
                                          height: Get.width * 0.15,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Client',
                                              style:
                                                  AppTextStyle.headline4.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Access services and products',
                                              style:
                                                  AppTextStyle.headline4.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          if (controller.currentType != "Service Partner")
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                          if (controller.currentType != "Service Partner")
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.05),
                              child: InkWell(
                                onTap: () async {
                                  controller.currentType = "Service Partner";
                                  controller.update();
                                  controller.updateNewUser("Service Partner");
                                  Get.back();
                                  var body = {
                                    "userType": "professional",
                                  };
                                  var response = await controller.userRepo
                                      .postData("/user/switch-account", body);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/service_provider.png',
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Image.asset(
                                          'assets/images/m1.png',
                                          width: Get.width * 0.15,
                                          height: Get.width * 0.15,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Service Partner',
                                              style:
                                                  AppTextStyle.headline4.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Render services to users in need ',
                                              style:
                                                  AppTextStyle.headline4.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          if (controller.currentType != "Product Partner")
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                          if (controller.currentType != "Product Partner")
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.05),
                              child: InkWell(
                                onTap: () async {
                                  controller.currentType = "Product Partner";
                                  controller.update();
                                  controller.updateNewUser("Product Partner");
                                  Get.back();
                                  var body = {
                                    "userType": "vendor",
                                  };
                                  var response = await controller.userRepo
                                      .postData("/user/switch-account", body);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/rect3.png',
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Image.asset(
                                          'assets/images/m3.png',
                                          width: Get.width * 0.15,
                                          height: Get.width * 0.15,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Product Partner',
                                              style:
                                                  AppTextStyle.headline4.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Sell your products online ',
                                              style:
                                                  AppTextStyle.headline4.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          if (controller.currentType != "Corporate Client")
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                          if (controller.currentType != "Corporate Client")
                            Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.05),
                              child: InkWell(
                                onTap: () async {
                                  controller.currentType = "Corporate Client";
                                  controller.update();
                                  controller.updateNewUser("Corporate Client");
                                  Get.back();
                                  var body = {
                                    "userType": "corporate_client",
                                  };
                                  var response = await controller.userRepo
                                      .postData("/user/switch-account", body);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/client_bg.png',
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        Image.asset(
                                          'assets/images/m2.png',
                                          width: Get.width * 0.15,
                                          height: Get.width * 0.15,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Corporate Client',
                                              style:
                                                  AppTextStyle.headline4.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Access services and products',
                                              style:
                                                  AppTextStyle.headline4.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ]),
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: AppColors.backgroundVariant2,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/homeIcon.png',
                          width: 25,
                          color: controller.currentBottomNavPage.value == 0
                              ? AppColors.primary
                              : AppColors.grey,
                        ),
                        label: 'Home',
                        backgroundColor: AppColors.background,
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          controller.currentBottomNavPage.value == 1
                              ? 'assets/images/chat_filled.png'
                              : 'assets/images/chatIcon.png',
                          width: 25,
                          color: controller.currentBottomNavPage.value == 1
                              ? AppColors.primary
                              : AppColors.grey,
                        ),
                        label: 'Chat',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/projectIcon.png',
                          width: 25,
                          color: controller.currentBottomNavPage.value == 2
                              ? AppColors.primary
                              : AppColors.grey,
                        ),
                        label: 'Project',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/cartIcon.png',
                          width: 25,
                          color: controller.currentBottomNavPage.value == 3
                              ? AppColors.primary
                              : AppColors.grey,
                        ),
                        label: 'Cart',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/profileIcon.png',
                          width: 25,
                          color: controller.currentBottomNavPage.value == 4
                              ? AppColors.primary
                              : AppColors.grey,
                        ),
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: controller.currentBottomNavPage.value,
                    selectedItemColor: AppColors.primary,
                    unselectedItemColor: Colors.grey,
                    onTap: (index) {
                      controller.currentBottomNavPage.value = index;
                      controller.update(['home']);
                      Get.back();
                    }),
              );
            }),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    Key? key,
    required this.width,
    required this.function,
    required this.asset,
    required this.title,
    required this.multiplier,
  }) : super(key: key);

  final double width;
  final Function() function;
  final String asset;
  final String title;
  final double multiplier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      child: InkWell(
        onTap: function,
        child: Container(
          height: width * 0.4,
          width: width * 0.4,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: width * 0.15,
                width: width * 0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(asset),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Text(
                title,
                style: AppTextStyle.subtitle1.copyWith(
                    fontSize: multiplier * 0.065,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
