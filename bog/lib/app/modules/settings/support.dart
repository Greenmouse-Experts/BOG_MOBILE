import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/new_app_bar.dart';

class Support extends GetView<HomeController> {
  const Support({Key? key}) : super(key: key);

  static const route = '/create';

  @override
  Widget build(BuildContext context) {
    var width = Get.width;

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@buildonthego.com',
      queryParameters: {'subject': 'BOG Support', 'body': 'I have a problem'},
    );

    final Uri smsUri = Uri(
      scheme: 'sms',
      path: '+2347039773218', // Replace with the desired phone number
      queryParameters: {
        'body':
            'Hello, I want to report a problem from BOG!', // Replace with your desired message
      },
    );

    void launchEmail() async {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        debugPrint('Could not launch email');
      }
    }

    void launchSms() async {
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      } else {
        debugPrint('Could not launch email');
      }
    }

    Future<void> launchSocialMediaAppIfInstalled({
      required Uri url,
    }) async {
      try {
        bool launched =
            await launchUrl(url, mode: LaunchMode.externalApplication);

        if (!launched) {
          launchUrl(url);
        }
      } catch (e) {
        launchUrl(url);
      }
    }

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'Support',
          builder: (controller) {
            return Scaffold(
                backgroundColor: AppColors.backgroundVariant2,
                appBar: newAppBarBack(context, 'Support'),
                body: SizedBox(
                  width: Get.width,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: width * 0.04,
                          ),
                          _TextButton(
                            text: "Message",
                            onPressed: () {
                              launchSms();
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
                              launchSocialMediaAppIfInstalled(
                                  url: Uri.parse(
                                      'https://twitter.com/Twitter?s=20'));
                            },
                            imageAsset: "assets/images/twitter.png",
                          ),
                          const SizedBox(
                            height: kToolbarHeight / 3,
                          ),
                          _TextButton(
                            text: "Instagram",
                            onPressed: () async {
                              launchSocialMediaAppIfInstalled(
                                  url: Uri.parse(
                                      'https://www.instagram.com/build_on_the_go/'));
                            },
                            imageAsset: "assets/images/instagram.png",
                          ),
                        ]),
                  ),
                ),
                bottomNavigationBar: HomeBottomWidget(
                  controller: controller,
                  isHome: false,
                  doubleNavigate: false,
                ));
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
