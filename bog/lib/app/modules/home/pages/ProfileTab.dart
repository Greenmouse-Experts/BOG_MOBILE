import 'dart:convert';

import 'package:flutter/material.dart';
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
import '../../../global_widgets/app_input.dart';
import '../../../global_widgets/horizontal_item_tile.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    return GetBuilder<HomeController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03,top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Accounts",
                  style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black,
                    fontSize: Get.width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: kToolbarHeight/2,
          ),
          Container(
            width: Get.width,
            height: Get.height * 0.25,
            color: const Color(0xffFFF8F0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width * 0.28,
                    height: Get.width * 0.28,
                    child: IconButton(
                      icon: AppAvatar(
                        imgUrl: (logInDetails.photo).toString(),
                        radius: Get.width * 0.16,
                      ),
                      onPressed: () {

                      },
                    ),
                  ),
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
            ),
          ),

          const SizedBox(
            height: kToolbarHeight/3,
          ),
          _TextButton(text: "Profile Info", onPressed: () {},imageAsset: "assets/images/prifile.png",),

          const SizedBox(
            height: kToolbarHeight/3,
          ),
          _TextButton(text: "Security ", onPressed: () {},imageAsset: "assets/images/sheild.png",),

          const SizedBox(
            height: kToolbarHeight/3,
          ),
          _TextButton(text: "About ", onPressed: () {},imageAsset: "assets/images/i.png",),

          const SizedBox(
            height: kToolbarHeight/3,
          ),
          _TextButton(text: "Terms & Conditions", onPressed: () {},imageAsset: "assets/images/tac.png",),

          const SizedBox(
            height: kToolbarHeight/3,
          ),
          _TextButton(text: "Log Out", onPressed: () {},imageAsset: "assets/images/log_out.png",showArrow: false,),
        ],
      );
    });
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
        padding: EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.0),
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
              width: Get.width*0.7,
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
                        style: AppTextStyle.subtitle1.copyWith(color: Colors.black,fontSize: Get.width*0.04,fontWeight: FontWeight.w600),
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
