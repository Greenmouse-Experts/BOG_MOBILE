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
import '../../../global_widgets/app_input.dart';
import '../../../global_widgets/horizontal_item_tile.dart';
import '../../../global_widgets/page_input.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Messages",
                        style: AppTextStyle.subtitle1.copyWith(
                          color: Colors.black,
                          fontSize: Get.width * 0.045,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                AppInput(
                  hintText: 'Search with name or keyword ...',
                  filledColor: Colors.grey.withOpacity(.1),
                  prefexIcon: Icon(
                    FeatherIcons.search,
                    color: Colors.black.withOpacity(.5),
                    size: Get.width * 0.05,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.7,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: Get.height * 0.08,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "BOG Engineer",
                                  style: AppTextStyle.subtitle1.copyWith(
                                    color: Colors.black,
                                    fontSize: Get.width * 0.04
                                  ),
                                ),
                                Text(
                                  "Have you seen the things i sent ?",
                                  style: AppTextStyle.subtitle1.copyWith(
                                      color: Colors.grey,
                                      fontSize: Get.width * 0.035
                                  ),
                                ),
                                //Divider
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Container(
                                  height: 1,
                                  width: Get.width * 0.7,
                                  color: Colors.grey.withOpacity(.2),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            //floating action button
            FloatingActionButton(
              onPressed: (){},
              backgroundColor: AppColors.primary,
              child: Stack(
                children: [
                  SizedBox(
                    width: Get.width * 0.05,
                    height: Get.width * 0.05,
                      child: Image.asset("assets/images/chat_new.png")
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}