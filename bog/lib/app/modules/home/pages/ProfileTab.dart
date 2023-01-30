import 'dart:convert';

import 'package:bog/app/base/base.dart';
import 'package:bog/app/blocs/homeswitch_controller.dart';
import 'package:bog/app/modules/onboarding/onboarding.dart';
import 'package:bog/core/utils/http_utils.dart';
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
import '../../settings/profile_info.dart';
import '../../settings/update_bank.dart';
import '../../settings/update_kyc.dart';
import '../../settings/update_password.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    return GetBuilder<HomeController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            // addSpace(15),
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
                          name: "${logInDetails.fname} ${logInDetails.lname}",
                        ),
                        onPressed: () {

                        },
                      ),
                    ),
                    Text(
                      "${logInDetails.fname} ${logInDetails.lname}",
                      style: AppTextStyle.subtitle1.copyWith(
                        color: Colors.black,
                        fontSize: Get.width * 0.045,
                      ),
                    ),
                    // Text(
                    //   controller.currentType,
                    //   style: AppTextStyle.subtitle1.copyWith(
                    //     color: Colors.black.withOpacity(0.5),
                    //     fontSize: Get.width * 0.035,
                    //   ),
                    // ),
                    addSpace(5),
                    Container(
                      height: 20,
                      child: TextButton(onPressed: (){

                        HomeSwitchController.instance.clickSwitch(context);


                      },
                          style: TextButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(controller.currentType,style: textStyle(false, 12, white),),
                              addSpaceWidth(5),
                              const Icon(Icons.expand_circle_down,color: white,size: 12,)
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ),

            /*const SizedBox(
              height: kToolbarHeight/3,
            ),*/
            addSpace(15),
            _TextButton(text: "Profile Info", onPressed: () {

              Get.to(() => const ProfileInfo());


            },imageAsset: "assets/images/prifile.png",),

            if(controller.currentType == "Product Partner" || controller.currentType == "Service Partner" )
              const SizedBox(
              height: kToolbarHeight/3,
            ),
            if(controller.currentType == "Product Partner" || controller.currentType == "Service Partner")
              _TextButton(text: controller.currentType == "Product Partner" ? "Uploaded Document" : "KYC", onPressed: () {
                Get.to(() => const UpdateKyc());
              },imageAsset: "assets/images/kyc.png",),

            if(controller.currentType == "Product Partner" || controller.currentType == "Service Partner")
              const SizedBox(
              height: kToolbarHeight/3,
            ),
            if(controller.currentType == "Product Partner" || controller.currentType == "Service Partner")
              _TextButton(text: "Bank Details", onPressed: () {
              Get.to(() => const UpdateBank());
            },imageAsset: "assets/images/bank.png",),

            const SizedBox(
              height: kToolbarHeight/3,
            ),
            _TextButton(text: "Security ", onPressed: () {
              Get.to(() => const UpdatePassword());
            },imageAsset: "assets/images/sheild.png",),

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
            _TextButton(text: "Log Out", onPressed: () {
              Get.toNamed(OnboardingPage.route);
            },imageAsset: "assets/images/log_out.png",showArrow: false,),
          ],
        ),
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
                        style: AppTextStyle.subtitle1.copyWith(color: text == "Log Out" ? AppColors.bostonUniRed : Colors.black,fontSize: Get.width*0.04,fontWeight: FontWeight.w500),
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
