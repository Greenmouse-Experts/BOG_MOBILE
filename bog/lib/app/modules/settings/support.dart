import 'dart:convert';

// import 'package:bog/app/global_widgets/app_button.dart';
// import 'package:bog/app/modules/create/inner_pages/building_approval.dart';
// import 'package:bog/app/modules/create/inner_pages/construction_drawing.dart';
// import 'package:bog/app/modules/create/inner_pages/contractor_or_smart_calculator.dart';
// import 'package:bog/app/modules/create/inner_pages/geotechnical_investigation.dart';
// import 'package:bog/app/modules/create/inner_pages/land_survey.dart';
// import 'package:feather_icons/feather_icons.dart';
import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/bottom_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';
// import '../../global_widgets/app_avatar.dart';
// import '../../global_widgets/app_input.dart';
// import '../../global_widgets/tabs.dart';

class Support extends GetView<HomeController> {
  const Support({Key? key}) : super(key: key);

  static const route = '/create';

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@greenmousetech.com',
      queryParameters: {'subject': 'BOG Test', 'body': 'This works BOG'},
    );

    void launchEmail() async {
      if (await canLaunchUrl(emailLaunchUri)) {
        print('object');
        await launchUrl(emailLaunchUri);
      } else {
        debugPrint('Could not launch email');
      }
    }

    const String twitterUsername = 'flutterdev';
    final Uri twitterProfileUri = Uri(
        scheme: 'twitter',
        path: 'user',
        queryParameters: {'screen_name': twitterUsername});

    void launchTwitterProfile() async {
      if (await canLaunchUrl(twitterProfileUri)) {
        await launchUrl(twitterProfileUri);
      } else {
        debugPrint('Could not launch Twitter profile');
      }
    }

    // final String _url =
    //     'https://www.example.com'; // Replace with the link you want to launch
    final Uri url = Uri.parse('https://wa.me/09034248267');
    launchURL() async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    const String instagramUsername =
        'flutter'; // Replace with Instagram username
    final Uri instagramProfileUri = Uri(
        scheme: 'instagram',
        path: 'user',
        queryParameters: {'username': instagramUsername});

    void launchInstagramProfile() async {
      if (await canLaunchUrl(instagramProfileUri)) {
        await launchUrl(instagramProfileUri);
      } else {
        debugPrint('Could not launch Instagram profile');
      }
    }

    // void launchInstagramProfile() async {
    //   const nativeUrl = "instagram://user?username=severinas_app";
    //   const webUrl = "https://www.instagram.com/severinas_app/";
    //   if (await canLaunchUrl(Uri.parse(nativeUrl))) {
    //     await launchUrl(Uri.parse(nativeUrl));
    //   }
    //   //  else if (await canLaunch(webUrl)) {
    //   //   await launch(webUrl);
    //   // }
    //   else {
    //     print("can't open Instagram");
    //   }
    // }

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'Support',
          builder: (controller) {
            // var logInDetails =
            //     LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
            return Scaffold(
                backgroundColor: AppColors.backgroundVariant2,
                body: SizedBox(
                  width: Get.width,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: width * 0.05,
                                left: width * 0.045,
                                top: kToolbarHeight),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/back.svg",
                                    height: width * 0.045,
                                    width: width * 0.045,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.04,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Support",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.07,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.04,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: width * 0.04,
                          ),
                          Container(
                            height: 1,
                            width: width,
                            color: AppColors.grey.withOpacity(0.1),
                          ),
                          SizedBox(
                            height: width * 0.04,
                          ),
                          _TextButton(
                            text: "Message",
                            onPressed: () {
                              Get.back();
                              controller.currentBottomNavPage.value = 1;
                              controller.updateNewUser(controller.currentType);
                              controller.update(['home']);
                            },
                            imageAsset: "assets/images/grp.png",
                          ),
                          const SizedBox(
                            height: kToolbarHeight / 3,
                          ),
                          _TextButton(
                            text: "Email",
                            onPressed: () {
                              launchEmail();
                            },
                            imageAsset: "assets/images/mess.png",
                          ),
                          const SizedBox(
                            height: kToolbarHeight / 3,
                          ),
                          _TextButton(
                            text: "Twitter",
                            onPressed: () {
                              launchTwitterProfile();
                            },
                            imageAsset: "assets/images/twitter.png",
                          ),
                          const SizedBox(
                            height: kToolbarHeight / 3,
                          ),
                          _TextButton(
                            text: "Instagram",
                            onPressed: () async {
                              launchURL();
                            },
                            imageAsset: "assets/images/instagram.png",
                          ),
                        ]),
                  ),
                ),
                bottomNavigationBar:
                    HomeBottomWidget(controller: controller, isHome: false)

                //  BottomNavigationBar(
                //     backgroundColor: AppColors.backgroundVariant2,
                //     showSelectedLabels: true,
                //     showUnselectedLabels: true,
                //     type: BottomNavigationBarType.fixed,
                //     items: <BottomNavigationBarItem>[
                //       BottomNavigationBarItem(
                //         icon: Padding(
                //           padding: const EdgeInsets.only(bottom: 5),
                //           child: Image.asset(
                //             controller.homeIcon,
                //             width: 20,
                //             //color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                //           ),
                //         ),
                //         label: controller.homeTitle,
                //         backgroundColor: AppColors.background,
                //       ),
                //       BottomNavigationBarItem(
                //         icon: Padding(
                //           padding: const EdgeInsets.only(bottom: 5),
                //           child: Image.asset(
                //             controller.currentBottomNavPage.value == 1
                //                 ? 'assets/images/chat_filled.png'
                //                 : 'assets/images/chatIcon.png',
                //             width: 22,
                //             //color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                //           ),
                //         ),
                //         label: 'Chat',
                //       ),
                //       BottomNavigationBarItem(
                //         icon: Padding(
                //           padding: const EdgeInsets.only(bottom: 5),
                //           child: Image.asset(
                //             controller.projectIcon,
                //             width: 20,
                //             //color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                //           ),
                //         ),
                //         label: controller.projectTitle,
                //       ),
                //       BottomNavigationBarItem(
                //         icon: Padding(
                //           padding: const EdgeInsets.only(bottom: 5),
                //           child: Image.asset(
                //             controller.cartIcon,
                //             width: 25,
                //             //color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                //           ),
                //         ),
                //         label: controller.cartTitle,
                //       ),
                //       BottomNavigationBarItem(
                //         icon: Padding(
                //           padding: const EdgeInsets.only(bottom: 5),
                //           child: Image.asset(
                //             controller.profileIcon,
                //             width: 25,
                //             //color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                //           ),
                //         ),
                //         label: 'Profile',
                //       ),
                //     ],
                //     currentIndex: controller.currentBottomNavPage.value,
                //     selectedItemColor: AppColors.primary,
                //     unselectedItemColor: Colors.grey,
                //     onTap: (index) {
                //       controller.currentBottomNavPage.value = index;
                //       controller.updateNewUser(controller.currentType);
                //       Get.back();
                //     }),
                );
          }),
    );
  }
}

class _TextButton extends StatelessWidget {
  final String imageAsset;
  final String text;
  final String? subtitle;

  final Function() onPressed;
  const _TextButton({
    required this.imageAsset,
    required this.text,
    required this.onPressed,
    this.subtitle,
  });

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
              width: Get.width * 0.09,
              height: Get.width * 0.09,
              decoration: BoxDecoration(
                color: const Color(0xffE8F4FE),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image.asset(
                  imageAsset,
                  width: Get.width * 0.04,
                  height: Get.width * 0.04,
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
                            color: Colors.black,
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
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                  size: Get.width * 0.04,
                ))
          ],
        ),
      ),
    );
  }
}
