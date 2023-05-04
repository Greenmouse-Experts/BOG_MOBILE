import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/model/user_details_model.dart';
import '../../../data/providers/my_pref.dart';
import '../../../global_widgets/app_avatar.dart';
import '../../../global_widgets/confirm_logout.dart';
import '../../settings/profile_info.dart';
import '../../settings/update_password.dart';
import '../../settings/view_kyc.dart';
import '../../subscription/subscription_view.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    Key? key,
  }) : super(key: key);

  static const route = '/profileTab';
  @override
  Widget build(BuildContext context) {
    var logInDetails =
        UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));

    final Uri about = Uri.parse('https://bog-project-new.netlify.app/about');
    final Uri terms = Uri.parse('https://bog-project-new.netlify.app/terms');

    launchURL(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return GetBuilder<HomeController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.03, right: Get.width * 0.03, top: 10),
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
              height: kToolbarHeight / 2,
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
                        onPressed: () {},
                      ),
                    ),
                    Text(
                      "${logInDetails.fname} ${logInDetails.lname}",
                      style: AppTextStyle.subtitle1.copyWith(
                        color: Colors.black,
                        fontSize: Get.width * 0.045,
                      ),
                    ),
                    Text(
                      controller.currentType,
                      style: AppTextStyle.subtitle1.copyWith(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: Get.width * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: kToolbarHeight / 3,
                ),
                _TextButton(
                  text: "Profile Info",
                  onPressed: () {
                    Get.to(() => const ProfileInfo());
                  },
                  imageAsset: "assets/images/prifile.png",
                ),
                if (controller.currentType == "Product Partner" ||
                    controller.currentType == "Service Partner")
                  const SizedBox(
                    height: kToolbarHeight / 3,
                  ),
                if (controller.currentType == "Product Partner" ||
                    controller.currentType == "Service Partner")
                  _TextButton(
                    text: "KYC",
                    onPressed: () {
                      Get.to(() => const KYCPage());
                    },
                    imageAsset: "assets/images/kyc.png",
                  ),
                if (controller.currentType == "Product Partner" ||
                    controller.currentType == "Service Partner")
                  const SizedBox(
                    height: kToolbarHeight / 3,
                  ),
                if (controller.currentType == "Product Partner" ||
                    controller.currentType == "Service Partner")
                  _TextButton(
                    text: "Subscribe",
                    useIcon: true,
                    onPressed: () {
                      final userDetails = UserDetailsModel.fromJson(
                          jsonDecode(MyPref.userDetails.val));
                      if (userDetails.profile!.hasActiveSubscription == true) {
                        Get.snackbar(
                            'Error', 'You already have an active subscription',
                            backgroundColor: Colors.red,
                            colorText: AppColors.background);
                      } else {
                        Get.to(() => const SubscriptionScreen());
                      }
                    },
                    imageAsset: "assets/images/sales.png",
                  ),
                const SizedBox(
                  height: kToolbarHeight / 3,
                ),
                _TextButton(
                  text: "Security ",
                  onPressed: () {
                    Get.to(() => const UpdatePassword());
                  },
                  imageAsset: "assets/images/sheild.png",
                ),
                const SizedBox(
                  height: kToolbarHeight / 3,
                ),
                _TextButton(
                  text: "About ",
                  onPressed: () {
                    launchURL(about);
                  },
                  imageAsset: "assets/images/i.png",
                ),
                const SizedBox(
                  height: kToolbarHeight / 3,
                ),
                _TextButton(
                  text: "Terms & Conditions",
                  onPressed: () {
                    launchURL(terms);
                  },
                  imageAsset: "assets/images/tac.png",
                ),
                const SizedBox(
                  height: kToolbarHeight / 3,
                ),
                _TextButton(
                  text: "Log Out",
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) =>
                            const ConfirmLogout());
                    // Get.toNamed(OnboardingPage.route);
                  },
                  imageAsset: "assets/images/log_out.png",
                  showArrow: false,
                ),
              ],
            ),
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
  final bool useIcon;
  const _TextButton(
      {required this.imageAsset,
      required this.text,
      required this.onPressed,
      this.useIcon = false,
      this.subtitle,
      this.showArrow = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.0),
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
                child: !useIcon
                    ? Image.asset(
                        imageAsset,
                        width: Get.width * 0.05,
                        height: Get.width * 0.05,
                      )
                    : const Icon(
                        Icons.subscriptions_outlined,
                        color: Colors.black,
                      ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.7,
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
                            color: text == "Log Out"
                                ? AppColors.bostonUniRed
                                : Colors.black,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.w500),
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
                      size: Get.width * 0.04,
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
