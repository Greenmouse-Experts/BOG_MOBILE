import 'dart:convert';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_input.dart';

class Shop extends GetView<HomeController> {
  const Shop({Key? key}) : super(key: key);

  static const route = '/shop';

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
          systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: GetBuilder<HomeController>(
          id: 'shop',
          builder: (controller) {
            return Scaffold(
              body: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: width*0.05,left: width*0.03,top: kToolbarHeight),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              "assets/images/back.svg",
                              height: width*0.045,
                              width: width*0.045,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width*0.04,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Shop",
                                  style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width*0.04,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width*0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width*0.025,right: width*0.05),
                      child: Text(
                        "Find and purchase materials for \nyour projects  ",
                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.075,color: Colors.black,fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: width*0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width*0.025,right: width*0.025),
                      child: AppInput(
                        hintText: 'Search with keyword ...',
                        filledColor: Colors.grey.withOpacity(.1),
                        prefexIcon: Icon(
                          FeatherIcons.search,
                          color: Colors.black.withOpacity(.5),
                          size: Get.width * 0.05,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width*0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width*0.025,right: width*0.025),
                      child: Text(
                        "Categories",
                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: width*0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width*0.025,right: width*0.025),
                      child: Image.asset(
                        "assets/images/Group 47099.png",
                        height: width*0.2,
                        width: width*0.8,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: width*0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width*0.025,right: width*0.025),
                      child: Text(
                        "New Arrivals",
                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: width*0.05,
                    ),
                    SizedBox(
                      height: Get.height * 0.20,
                      width: Get.width,
                      child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: width*0.025,right: width*0.0),
                            child: Container(
                              width: Get.width * 0.4,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/Group 47037.png"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: width*0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width*0.025,right: width*0.025),
                      child: Text(
                        "Top Picks",
                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: width*0.05,
                    ),
                    SizedBox(
                      height: Get.height * 0.20,
                      width: Get.width,
                      child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: width*0.025,right: width*0.0),
                            child: Container(
                              width: Get.width * 0.4,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/Group 47037.png"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
