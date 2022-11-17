import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/model/log_in_model.dart';
import '../../../data/providers/api_response.dart';
import '../../../data/providers/my_pref.dart';
import '../../../global_widgets/app_avatar.dart';
import '../../../global_widgets/app_drawer.dart';
import '../../../global_widgets/horizontal_item_tile.dart';
import '../../create/create.dart';
import '../../notifications/notification.dart';
import '../../shop/shop.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    return GetBuilder<HomeController>(builder: (controller) {
      return SizedBox(
        height: Get.height * 0.936,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: kToolbarHeight/1.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
              child: Row(
                children: [
                  Builder(
                      builder: (context1) {
                        return SizedBox(
                          width: Get.width * 0.16,
                          height: Get.width * 0.16,
                          child: IconButton(
                            icon: AppAvatar(
                              imgUrl: (logInDetails.photo).toString(),
                              radius: Get.width * 0.16,
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        );
                      }
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
                              "Hello,",
                              style: AppTextStyle.subtitle1.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              logInDetails.name.toString(),
                              style: AppTextStyle.subtitle1.copyWith(
                                color: Colors.black,
                                fontSize: Get.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                        //Alarm Icon
                        IconButton(
                          icon: const Icon(Icons.notifications,color: Colors.grey),
                          onPressed: () {
                            Get.to(() => const NotificationPage());
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Get.height * 0.18,
                  width: Get.width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/house.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
            //indicator
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.018,
                  height: Get.width * 0.018,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05,top: 10.0),
                      child: Text(
                        "What would you like to do?",
                        style: AppTextStyle.subtitle1.copyWith(
                          color: Colors.black,
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(Create.route);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.03,top: Get.width*0.05,bottom: Get.width*0.05),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Create A Project',
                                          style: AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 19,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Start a project with skilled \nprofessionals',
                                          style: AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Image.asset(
                                      'assets/images/image 808.png',
                                      width: Get.width*0.15,
                                      height: Get.width*0.15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Shop.route);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.03,top: Get.width*0.05,bottom: Get.width*0.05),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Shop Products',
                                          style: AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 19,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Procure construction materials \nfor your projects',
                                          style: AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: Get.width * 0.02),
                                      child: Image.asset(
                                        'assets/images/image 809.png',
                                        width: Get.width*0.15,
                                        height: Get.width*0.15,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05,top: 10.0),
                      child: Text(
                        "Need Help?",
                        style: AppTextStyle.subtitle1.copyWith(
                          color: Colors.black,
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/Group 47034.png",
                          height: Get.height * 0.2,
                          width: Get.width*0.5,
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          "assets/images/Group 47035.png",
                          height: Get.height * 0.2,
                          width: Get.width*0.5,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}