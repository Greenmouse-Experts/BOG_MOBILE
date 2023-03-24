import 'dart:convert';

import 'package:bog/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../data/model/gen_kyc.dart';
import '../data/model/log_in_model.dart';
import '../data/providers/my_pref.dart';
import '../modules/settings/view_kyc.dart';
import 'overlays.dart';

class MainSwitchWidget extends StatelessWidget {
  final String accountType;
  const MainSwitchWidget({super.key, required this.accountType});

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.025),
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
            accountType,
            style: AppTextStyle.subtitle1.copyWith(
                fontSize: multiplier * 0.08,
                color: AppColors.primary,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}

class PrimarySwitchWidget extends StatelessWidget {
  final String newCurrentType;
  final String detail;
  final String backgroundAsset;
  final String iconAsset;
  final String sendType;
  const PrimarySwitchWidget(
      {super.key,
      required this.newCurrentType,
      required this.detail,
      required this.backgroundAsset,
      required this.iconAsset,
      required this.sendType});

  @override
  Widget build(BuildContext context) {
    void verifyKycComplete(String type, VoidCallback onPressed) async {
      final controller = Get.find<HomeController>();
      var logInDetails =
          LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
      final res = await controller.userRepo
          .getData('/kyc/user-kyc/${logInDetails.id}?userType=$type');

      final kyc = GenKyc.fromJson(res.data);
      MyPref.genKyc.val = jsonEncode(kyc);
      MyPref.genKyc.val = jsonEncode(kyc);

      if (kyc.isKycCompleted != true) {
        MyPref.setOverlay.val = true;
        AppOverlay.showKycDialog(
            title: 'Kyc Not Complete',
            buttonText: 'Complete KYC',
            content:
                "You haven't completed your KYC yet, Kindly Complete your KYC now",
            onPressed: onPressed);
      }
    }

    final width = Get.width;
    final height = Get.height;

    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.01),
        child: InkWell(
          onTap: () async {
            if (sendType == 'vendor' || sendType == 'professional') {
              controller.currentType = newCurrentType;
              controller.update();
              controller.updateNewUser(newCurrentType);
              var body = {
                "userType": sendType,
              };
              AppOverlay.loadingOverlay(asyncFunction: () async {
                var response = await controller.userRepo
                    .postData("/user/switch-account", body);
                if (response.isSuccessful) {
                  var logInInfo = LogInModel.fromJson(response.user);
                  MyPref.logInDetail.val = jsonEncode(logInInfo);

                  Get.back();
                }
              });
              verifyKycComplete('vendor', () {
                Get.to(() => const KYCPage());
              });
            } else {
              var kyc = GenKyc.fromJson(jsonDecode(MyPref.genKyc.val));
              final oldUser = controller.currentType;
              controller.currentType = "Client";
              controller.update();
              controller.updateNewUser("Client");
              var body = {
                "userType": "private_client",
              };
              AppOverlay.loadingOverlay(asyncFunction: () async {
                var response = await controller.userRepo
                    .postData("/user/switch-account", body);
                if (response.isSuccessful) {
                  var logInInfo = LogInModel.fromJson(response.user);
                  MyPref.logInDetail.val = jsonEncode(logInInfo);

                  if ((oldUser == 'Product Partner' ||
                          oldUser == 'Service Partner') &&
                      (MyPref.setOverlay.val == true)) {
                    Get.back();
                  }

                  Get.back();
                }
              });
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                backgroundAsset,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  Image.asset(
                    iconAsset,
                    width: Get.width * 0.15,
                    height: Get.width * 0.15,
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newCurrentType,
                        style: AppTextStyle.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        detail,
                        style: AppTextStyle.headline4.copyWith(
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
      );
    });
  }
}
