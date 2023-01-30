import 'dart:convert';

import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/modules/create/inner_pages/building_approval.dart';
import 'package:bog/app/modules/create/inner_pages/construction_drawing.dart';
import 'package:bog/app/modules/create/inner_pages/contractor_or_smart_calculator.dart';
import 'package:bog/app/modules/create/inner_pages/geotechnical_investigation.dart';
import 'package:bog/app/modules/create/inner_pages/land_survey.dart';
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
import '../chat/chat.dart';

class Reviews extends GetView<HomeController> {
  const Reviews({Key? key}) : super(key: key);

  static const route = '/notification';

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
          id: 'Reviews',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: Get.width*0.04, right: Get.width*0.03,top: kToolbarHeight),
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
                                      "Reviews",
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
                          color: AppColors.background,
                        ),
                        SizedBox(
                          height: width*0.04,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                          child: AppInput(
                            hintText: 'Search with name or keyword ...',
                            filledColor: Colors.grey.withOpacity(.1),
                            prefexIcon: Icon(
                              FeatherIcons.search,
                              color: Colors.black.withOpacity(.5),
                              size: Get.width * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        SizedBox(
                          height: Get.height * 0.65,
                          child: ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: Get.height * 0.02,left: Get.width*0.03, right: Get.width*0.03),
                                child: Container(
                                  height: Get.height * 0.12,
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundVariant2,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.14,
                                            height: Get.width * 0.14,
                                            child: IconButton(
                                              icon: AppAvatar(
                                                imgUrl: "",
                                                radius: Get.width * 0.14,
                                                name: "Greenmouse"
                                              ),
                                              onPressed: () {

                                              },
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Text(
                                                "Godson Oluwaseun",
                                                style: AppTextStyle.subtitle1.copyWith(
                                                    color: Colors.black,
                                                    fontSize: Get.width * 0.04
                                                ),
                                              ),
                                              AppRating(onRatingUpdate: (value) {}, rating: 4.5),
                                              //Divider
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: Get.width * 0.025),
                                        child: Text(
                                          "The product was of good quality. Always nice and easy doing business with you guys",
                                          style: AppTextStyle.subtitle1.copyWith(
                                              color: Colors.grey,
                                              fontSize: Get.width * 0.035
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: AppColors.backgroundVariant2,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.homeIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.homeTitle,
                      backgroundColor: AppColors.background,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.currentBottomNavPage.value == 1 ? 'assets/images/chat_filled.png' : 'assets/images/chatIcon.png',
                          width: 22,
                          //color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Message',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.projectIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.projectTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.cartIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.cartTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.profileIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: controller.currentBottomNavPage.value,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    controller.currentBottomNavPage.value = index;
                    controller.updateNewUser(controller.currentType);
                    Get.back();
                  }
              ),

            );
          }),
    );
  }
}