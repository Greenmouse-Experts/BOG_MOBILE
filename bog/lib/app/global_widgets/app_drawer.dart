import 'dart:convert';

// import 'package:bog/app/modules/chat/load_chats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../controllers/home_controller.dart';

import '../data/model/log_in_model.dart';
import '../data/providers/my_pref.dart';

// import '../modules/chat/load_chats.dart';
import '../modules/meetings/meeting.dart';
import '../modules/orders/my_orders.dart';
// import '../modules/reviews/reviews.dart';
import '../modules/settings/support.dart';
import '../modules/switch/switch.dart';
import '../modules/transactions/transaction.dart';
import 'app_avatar.dart';
import 'app_base_view.dart';
import 'confirm_logout.dart';

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
    return AppBaseView(
      child: GetBuilder<HomeController>(builder: (controller) {
        var logInDetails =
            LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
        return SizedBox(
          width: Get.width * 0.7,
          height: Get.height,
          child: Scaffold(
              backgroundColor: AppColors.background,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    width: Get.width * 0.7,
                    height: Get.height * 0.95,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Frame 466391.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.015, right: 10.0, top: 10.0),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.16,
                                    height: Get.width * 0.16,
                                    child: IconButton(
                                      icon: AppAvatar(
                                        imgUrl: (logInDetails.photo).toString(),
                                        radius: Get.width * 0.16,
                                        name:
                                            "${logInDetails.fname} ${logInDetails.lname}",
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${logInDetails.fname}",
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                color: Colors.black,
                                                fontSize: Get.width * 0.045,
                                              ),
                                            ),
                                            Text(
                                              controller.currentType,
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: Get.width > 600
                                                    ? Get.width * 0.025
                                                    : Get.width * 0.035,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Image.asset(
                                    "assets/images/Group 47364.png",
                                    width: Get.width * 0.05,
                                    height: Get.width * 0.05,
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        _TextButton(
                            text: "Account",
                            onPressed: () {
                              Get.back();
                              controller.currentBottomNavPage.value = 4;
                              controller.updateNewUser(controller.currentType);
                              controller.update(['home']);
                            },
                            imageAsset: "assets/images/one1.png",
                            showArrow: true),
                        if (controller.currentType == "Client" ||
                            controller.currentType == "Corporate Client")
                          _TextButton(
                              text: "Orders",
                              onPressed: () {
                                Get.back();
                                Get.to(() => const MyOrderScreen());
                              },
                              imageAsset: "assets/images/two1.png",
                              showArrow: true),
                        if (controller.currentType == "Client" ||
                            controller.currentType == "Corporate Client")
                          _TextButton(
                              imageAsset: 'assets/images/project_icon.png',
                              text: 'Projects',
                              showArrow: true,
                              onPressed: () {
                                Get.back();
                                controller.currentBottomNavPage.value = 2;
                                controller
                                    .updateNewUser(controller.currentType);
                                controller.update(['home']);
                              }),
                        _TextButton(
                            text: "Transactions",
                            onPressed: () {
                              Get.back();
                              Get.to(() => const TransactionPage());
                            },
                            imageAsset: "assets/images/three1.png",
                            showArrow: true),
                        _TextButton(
                            text: "Meetings",
                            onPressed: () {
                              Get.back();
                              if (controller.currentType == 'Service Partner') {
                                controller.currentBottomNavPage.value = 3;
                                controller
                                    .updateNewUser(controller.currentType);
                                controller.update(['home']);
                              } else {
                                Get.to(() => const NewMeetings());
                              }
                            },
                            imageAsset: "assets/images/four1.png",
                            showArrow: true),
                        // _TextButton(
                        //     text: "Chat",
                        //     onPressed: () {
                        //       Get.back();

                        //       Navigator.of(context).push(
                        //         MaterialPageRoute(
                        //             builder: (context) => const LoadChats()),
                        //       );

                        //       //   Get.to(() => const LoadChats());
                        //     },
                        //     imageAsset: "assets/images/chat-sas.png",
                        //     showArrow: true),
                        // if (controller.currentType != "Client" &&
                        //     controller.currentType != "Corporate Client")
                        //   _TextButton(
                        //       text: "Reviews",
                        //       onPressed: () {
                        //         Get.back();
                        //         Get.to(() => const Reviews());
                        //       },
                        //       imageAsset: "assets/images/carbon_review.png",
                        //       showArrow: true),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _TextButton(
                                text: "Switch Account",
                                onPressed: () {
                                  Get.back();
                                  Get.to(() => const SwitchUser());
                                },
                                imageAsset: "assets/images/six1.png",
                                showArrow: true),
                            _TextButton(
                                text: "Support",
                                onPressed: () {
                                  Get.back();
                                  Get.to(() => const Support());
                                },
                                imageAsset: "assets/images/seven1.png",
                                showArrow: true),
                            _TextButton(
                                text: "Log Out",
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                          const ConfirmLogout());
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
                  ),
                ),
              )),
        );
      }),
    );
  }
}

class _TextButton extends StatelessWidget {
  final String imageAsset;
  final String text;
  final String? subtitle;
  final bool showArrow;
  final Function() onPressed;
  const _TextButton(
      {required this.imageAsset,
      required this.text,
      required this.onPressed,
      this.subtitle,
      required this.showArrow});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(
            left: Get.width * 0.03,
            right: Get.width * 0.0,
            top: Get.height * 0.02),
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
                  width: Get.width > 600 ? Get.width * 0.3 : Get.width * 0.05,
                  height: Get.width > 600 ? Get.width * 0.3 : Get.width * 0.05,
                ),
              ),
            ),
            SizedBox(
              width: Get.width > 600 ? Get.width * 0.4 : Get.width * 0.43,
              child: Padding(
                padding: EdgeInsets.only(left: Get.width * 0.01),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: AppTextStyle.subtitle1.copyWith(
                            color: showArrow ? Colors.black : Colors.red,
                            fontSize: Get.width * 0.038,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: AppTextStyle.subtitle1
                              .copyWith(color: Colors.black),
                        ),
                      if (subtitle != null)
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                    ]),
              ),
            ),
            IconButton(
              onPressed: onPressed,
              padding: EdgeInsets.zero,
              icon: showArrow
                  ? Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                      size:
                          Get.width > 600 ? Get.width * 0.03 : Get.width * 0.04,
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
