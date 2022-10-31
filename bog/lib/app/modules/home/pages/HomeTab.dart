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
import '../../../data/providers/api_response.dart';
import '../../../data/providers/my_pref.dart';
import '../../../global_widgets/app_avatar.dart';
import '../../../global_widgets/horizontal_item_tile.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Column(
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
                SizedBox(
                  width: Get.width * 0.16,
                  height: Get.width * 0.16,
                  child: IconButton(
                    icon: AppAvatar(
                      imgUrl: "",
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
                            "Hello,",
                            style: AppTextStyle.subtitle1.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Chukka",
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
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Image.asset(
            "assets/images/house.png",
            height: Get.height * 0.2,
            width: Get.width*0.95,
            fit: BoxFit.contain,
          ),
          //indicator
          const SizedBox(
            height: 10.0,
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
          const SizedBox(
            height: 10.0,
          ),
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
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}