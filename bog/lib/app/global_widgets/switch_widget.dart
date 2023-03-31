import 'dart:convert';

import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/data/model/user_details_model.dart';
import 'package:bog/app/modules/subscription/subscription_view.dart';
import 'package:flutter/cupertino.dart';
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
  final String image;
  const MainSwitchWidget(
      {super.key, required this.accountType, required this.image});

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
          Image.asset(image),
          const SizedBox(width: 20),
          Text(
            accountType,
            style: AppTextStyle.subtitle1.copyWith(
                fontSize: multiplier * 0.08,
                color: AppColors.primary,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          SizedBox(
            height: 26,
            width: 52,
            child: FittedBox(
              child: CupertinoSwitch(
                value: true,
                onChanged: (val) {
                  Get.snackbar(
                      'Error', "You're already logged in as $accountType",
                      backgroundColor: Colors.red);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PrimarySwitchWidget extends StatefulWidget {
  final String newCurrentType;
  final String detail;
  // final String backgroundAsset;
  final String iconAsset;
  final String sendType;
  const PrimarySwitchWidget(
      {super.key,
      required this.newCurrentType,
      required this.detail,
      // required this.backgroundAsset,
      required this.iconAsset,
      required this.sendType});

  @override
  State<PrimarySwitchWidget> createState() => _PrimarySwitchWidgetState();
}

class _PrimarySwitchWidgetState extends State<PrimarySwitchWidget> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    void updateuser(String type) async {
      final controller = Get.find<HomeController>();
      final newRes =
          await controller.userRepo.getData('/user/me?userType=$type');
      final userDetails = UserDetailsModel.fromJson(newRes.user);
      MyPref.userDetails.val = jsonEncode(userDetails);
    }

    void verifyKycComplete(String type, VoidCallback onPressed) async {
      final controller = Get.find<HomeController>();

      var logInDetails =
          LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
      final res = await controller.userRepo
          .getData('/kyc/user-kyc/${logInDetails.id}?userType=$type');

      final newRes =
          await controller.userRepo.getData('/user/me?userType=$type');

      final userDetails = UserDetailsModel.fromJson(newRes.user);

      final kyc = GenKyc.fromJson(res.data);
      MyPref.genKyc.val = jsonEncode(kyc);
      MyPref.userDetails.val = jsonEncode(userDetails);

      if (kyc.isKycCompleted != true) {
        MyPref.setOverlay.val = true;
        AppOverlay.showKycDialog(
            title: 'Kyc Not Complete',
            buttonText: 'Complete KYC',
            content:
                "You haven't completed your KYC yet, Kindly Complete your KYC now",
            onPressed: onPressed);
      } else if (userDetails.profile!.hasActiveSubscription != true) {
        MyPref.setSubscribeOverlay.val = true;
        AppOverlay.showKycDialog(
            title: 'No Active Subscriptions',
            buttonText: 'Subscribe',
            content:
                "You don't have an active subscription, select a subscription to enjoy full benefits",
            onPressed: () => Get.to(() => const SubscriptionScreen()));
      } else {
        MyPref.setOverlay.val = false;
        MyPref.setSubscribeOverlay.val = false;
      }
    }

    final width = Get.width;
    final height = Get.height;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.02),
        child: Row(
          children: [
            Image.asset(widget.iconAsset),
            const SizedBox(width: 20),
            Text(
              widget.newCurrentType,
              style: AppTextStyle.subtitle1.copyWith(
                  fontSize: multiplier * 0.08,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
            const Spacer(),
            SizedBox(
              height: 26,
              width: 52,
              child: FittedBox(
                child: CupertinoSwitch(
                  value: state,
                  onChanged: (val) {
                    setState(() {
                      state = val;
                    });
                    if (widget.sendType == 'vendor' ||
                        widget.sendType == 'professional') {
                      controller.currentType = widget.newCurrentType;
                      controller.update();
                      controller.updateNewUser(widget.newCurrentType);
                      var body = {
                        "userType": widget.sendType,
                      };
                      AppOverlay.loadingOverlay(asyncFunction: () async {
                        var response = await controller.userRepo
                            .postData("/user/switch-account", body);
                        if (response.isSuccessful) {
                          var logInInfo = LogInModel.fromJson(response.user);

                          MyPref.logInDetail.val = jsonEncode(logInInfo);
                          controller.currentBottomNavPage.value = 0;
                          controller.updateNewUser(controller.currentType);
                          controller.update(['home']);
                          Get.back();
                        }
                      });
                      verifyKycComplete(widget.sendType, () {
                        Get.to(() => const KYCPage());
                      });
                    } else {
                      // var kyc = GenKyc.fromJson(jsonDecode(MyPref.genKyc.val));
                      final oldUser = controller.currentType;
                      controller.currentType = widget.newCurrentType;
                      controller.update();
                      controller.updateNewUser(widget.newCurrentType);
                      var body = {
                        "userType": widget.sendType,
                      };
                      AppOverlay.loadingOverlay(asyncFunction: () async {
                        var response = await controller.userRepo
                            .postData("/user/switch-account", body);
                        updateuser(widget.sendType);
                        if (response.isSuccessful) {
                          var logInInfo = LogInModel.fromJson(response.user);
                          MyPref.logInDetail.val = jsonEncode(logInInfo);

                          if ((oldUser == 'Product Partner' ||
                                  oldUser == 'Service Partner') &&
                              (MyPref.setOverlay.val == true ||
                                  MyPref.setSubscribeOverlay.val == true)) {
                            Get.back();
                          }
                          // Get.back();
                          controller.currentBottomNavPage.value = 0;
                          controller.updateNewUser(controller.currentType);
                          controller.update(['home']);
                          Get.back();
                        }
                      });
                    }
                  },
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
