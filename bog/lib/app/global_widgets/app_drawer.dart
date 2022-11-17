import 'dart:convert';

import 'package:bog/app/modules/onboarding/onboarding.dart';
import 'package:bog/app/modules/settings/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../controllers/home_controller.dart';

import '../data/model/log_in_model.dart';
import '../data/providers/my_pref.dart';
import '../modules/multiplexor/multiplexor.dart';

import '../modules/switch/switch.dart';
import 'app_avatar.dart';
import 'app_button.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  static const String route = "/drawer";

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<HomeController>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.background,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.background,
            systemNavigationBarIconBrightness: Brightness.dark
        ),
        child: GetBuilder<HomeController>(
            builder: (controller) {
              var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
              return SizedBox(
                width: Get.width*0.7,
                child: Scaffold(
                    backgroundColor: AppColors.background,
                    body: SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Get.width*0.015,right: 10.0,top: 10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Get.width * 0.16,
                                  height: Get.width * 0.16,
                                  child: IconButton(
                                    icon: AppAvatar(
                                      imgUrl: (logInDetails.photo).toString(),
                                      radius: Get.width * 0.16,
                                    ),
                                    onPressed: () {

                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            logInDetails.name.toString(),
                                            style: AppTextStyle.subtitle1.copyWith(
                                              color: Colors.black,
                                              fontSize: Get.width * 0.045,
                                            ),
                                          ),
                                          Text(
                                            logInDetails.userType.toString().replaceAll("_", " ").capitalizeFirst.toString(),
                                            style: AppTextStyle.subtitle1.copyWith(
                                              color: Colors.black.withOpacity(0.5),
                                              fontSize: Get.width * 0.035,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          _TextButton(
                            text: "Account",
                            onPressed: () {
                              //Get.toNamed(OnboardingPage.route);
                            },
                            imageAsset: "assets/images/one1.png",
                            showArrow: true),

                          _TextButton(
                              text: "Orders",
                              onPressed: () {
                                //Get.toNamed(OnboardingPage.route);
                              },
                              imageAsset: "assets/images/two1.png",
                              showArrow: true),

                          _TextButton(
                              text: "Transactions",
                              onPressed: () {
                                //Get.toNamed(OnboardingPage.route);
                              },
                              imageAsset: "assets/images/three1.png",
                              showArrow: true),

                          _TextButton(
                              text: "Meetings",
                              onPressed: () {
                                //Get.toNamed(OnboardingPage.route);
                              },
                              imageAsset: "assets/images/four1.png",
                              showArrow: true),

                          _TextButton(
                              text: "Smart Calculator",
                              onPressed: () {
                                //Get.toNamed(OnboardingPage.route);
                              },
                              imageAsset: "assets/images/five1.png",
                              showArrow: true),


                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _TextButton(
                                  text: "Switch Account",
                                  onPressed: () {
                                    Get.back();
                                    Get.to(() => const SwitchUser());
                                    //Get.toNamed(OnboardingPage.route);
                                  },
                                  imageAsset: "assets/images/six1.png",
                                  showArrow: true),

                              _TextButton(
                                  text: "Support",
                                  onPressed: () {
                                    Get.back();
                                    Get.to(() => const Support());
                                    //Get.toNamed(OnboardingPage.route);
                                  },
                                  imageAsset: "assets/images/seven1.png",
                                  showArrow: true),

                              _TextButton(
                                  text: "Log Out",
                                  onPressed: () {
                                    Get.back();
                                    Get.toNamed(OnboardingPage.route);
                                  },
                                  imageAsset: "assets/images/log_out.png",
                                  showArrow: false),

                              SizedBox(
                                height: Get.height * 0.05,
                              ),
                            ],
                          )),
                        ],
                      ),
                    )),
              );
            })
    );
  }
}

class _TextButton extends StatelessWidget {
  final String imageAsset;
  final String text;
  final String? subtitle;
  final bool showArrow;
  final Function() onPressed;
  const _TextButton({required this.imageAsset,required this.text, required this.onPressed, this.subtitle,this.showArrow = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.0,top: Get.height*0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width * 0.1,
              height: Get.width * 0.1,
              decoration: BoxDecoration(
                color: const Color(0xffE8F4FE),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image.asset(
                  imageAsset,
                  width: Get.width * 0.05,
                  height: Get.width * 0.05,
                ),
              ),
            ),
            SizedBox(
              width: Get.width*0.43,
              child: Padding(
                padding: EdgeInsets.only(left: Get.width*0.01),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: Get.height*0.01,
                      ),
                      Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: AppTextStyle.subtitle1.copyWith(color: showArrow ? Colors.black : Colors.red,fontSize: Get.width*0.038,fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: Get.height*0.01,
                      ),
                      if(subtitle!=null)
                        Text(
                          subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: AppTextStyle.subtitle1.copyWith(color: Colors.black),
                        ),
                      if(subtitle!=null)
                        SizedBox(
                          height: Get.height*0.01,
                        ),
                    ]
                ),
              ),
            ),

            IconButton(
              onPressed: onPressed,
              padding: EdgeInsets.zero,
              icon: showArrow ? Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: Get.width*0.04,) : Container(),
            )
          ],
        ),
      ),
    );
  }
}

