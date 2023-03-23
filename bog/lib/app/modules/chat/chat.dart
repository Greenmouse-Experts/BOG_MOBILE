import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_input.dart';

class Chat extends GetView<HomeController> {
  const Chat({Key? key}) : super(key: key);

  static const route = '/chat';

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: GetBuilder<HomeController>(
          id: 'Chat',
          builder: (controller) {
            return Scaffold(
              body: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05,
                          left: width * 0.03,
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
                              height: width * 0.05,
                              width: width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.12,
                                  height: Get.width * 0.12,
                                  child: IconButton(
                                    icon: AppAvatar(
                                        imgUrl: "",
                                        radius: Get.width * 0.12,
                                        name: "BOG"),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "BOG Engineer",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.065,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Divider
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: Get.height * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        const Icon(
                          Icons.add,
                          color: AppColors.primary,
                          size: 30,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        const Expanded(
                          child: AppInput(
                            hintText: '',
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        const Icon(
                          Icons.camera_alt_rounded,
                          color: AppColors.primary,
                          size: 30,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        const Icon(
                          Icons.mic,
                          color: AppColors.primary,
                          size: 30,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
