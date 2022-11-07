import 'dart:convert';

import 'package:bog/app/global_widgets/app_button.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/tabs.dart';

class Create extends GetView<HomeController> {
  const Create({Key? key}) : super(key: key);

  static const route = '/create';

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: GetBuilder<HomeController>(
          id: 'Create',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: kToolbarHeight),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                "assets/images/back.svg",
                                height: width*0.045,
                                width: width*0.045,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: width*0.04,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Create",
                                    style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width*0.04,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),
                      Container(
                        height: 1,
                        width: width,
                        color: AppColors.grey.withOpacity(0.1),
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        child: Text(
                          "What's your project name ? ",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.08,color: Colors.black,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        child: const AppInput(hintText: "Enter your desired project name "),
                      ),
                      SizedBox(
                        height: width*0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        child: Text(
                          "What your service do you need ? ",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.08,color: Colors.black,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ServiceWidget(
                              width: width,
                              function: (){},
                              asset: "assets/images/oneS.png",
                              title: "Land Surveyor",
                              multiplier: multiplier
                          ),

                          ServiceWidget(
                              width: width,
                              function: (){},
                              asset: "assets/images/twoS.png",
                              title: "Construction Drawing",
                              multiplier: multiplier
                          ),
                        ],
                      ),

                      SizedBox(
                        height: width*0.04,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ServiceWidget(
                              width: width,
                              function: (){},
                              asset: "assets/images/threeS.png",
                              title: "Geotechnical \nInvestigation",
                              multiplier: multiplier
                          ),

                          ServiceWidget(
                              width: width,
                              function: (){},
                              asset: "assets/images/fourS.png",
                              title: "Contractor or \nSmart Calculator",
                              multiplier: multiplier
                          ),
                        ],
                      ),

                      SizedBox(
                        height: width*0.04,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ServiceWidget(
                              width: width,
                              function: (){},
                              asset: "assets/images/fiveS.png",
                              title: "Building Approval",
                              multiplier: multiplier
                          ),
                        ],
                      ),

                      SizedBox(
                        height: width*0.07,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        child: AppButton(
                          title: "Proceed",
                          onPressed: (){},
                        ),
                      )
                    ],
                  ),
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
                        color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Home',
                      backgroundColor: AppColors.background,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        controller.currentBottomNavPage.value == 1 ? 'assets/images/chat_filled.png' : 'assets/images/chatIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/projectIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Project',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/cartIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/profileIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
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
                  }
              ),
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
      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
      child: InkWell(
        onTap: function,
        child: Container(
          height: width*0.4,
          width: width*0.4,
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
                height: width*0.15,
                width: width*0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(asset),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: width*0.04,
              ),
              Text(
                title,
                style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.065,color: Colors.black,fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
