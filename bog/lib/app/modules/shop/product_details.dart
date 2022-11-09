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
import '../../global_widgets/app_button.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/app_ratings.dart';
import '../../global_widgets/item_counter.dart';

class ProductDetails extends GetView<HomeController> {
  const ProductDetails({Key? key}) : super(key: key);

  static const route = '/productDetails';

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
          id: 'productDetails',
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
                                  "Product Details",
                                  style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width*0.04,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              "assets/images/upload_up.svg",
                              height: width*0.045,
                              width: width*0.045,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width*0.08,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                      child: Container(
                        height: Get.height*0.28,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.bostonUniRed,
                          image: const DecorationImage(
                            image: AssetImage("assets/images/dummy_image.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width * 0.018,
                          height: Get.width * 0.018,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width*0.02, right: Get.width*0.03),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: Get.width * 0.015,bottom: Get.height * 0.01),
                                  child: Text("30 Tonnes Sharp Sand",
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.08,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500)),
                                ),
                                AppRating(onRatingUpdate: (value) {}, rating: 4,size: 25),
                                Padding(
                                  padding: EdgeInsets.only(left: Get.width * 0.015,top: Get.height*0.01),
                                  child: Text(
                                    'N 115,000',
                                    style: AppTextStyle.caption.copyWith(
                                      color: AppColors.primary,
                                      fontSize: Get.width * 0.045,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //Love Button
                              Container(
                                height: Get.width * 0.07,
                                width: Get.width * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: AppColors.grey.withOpacity(0.2),
                                  ),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                    onPressed: (){},
                                    icon: Icon(FeatherIcons.heart,color: AppColors.grey.withOpacity(0.2),size: Get.width*0.05,),
                                ),
                              ),
                              SizedBox(
                                height: Get.height*0.04,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: Get.width * 0.0),
                                child: ItemCounter(
                                  initialCount: 1,
                                  onCountChanged: (count) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width*0.0, right: Get.width*0.03),
                      child: const DefaultTabController(
                        length: 3,
                        child: TabBar(
                          padding: EdgeInsets.zero,
                          labelColor: Colors.black,
                          unselectedLabelColor: Color(0xff9A9A9A),
                          indicatorColor: AppColors.primary,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          tabs: [
                            Tab(text: 'Description',iconMargin: EdgeInsets.zero,),
                            Tab(text: 'Specification',iconMargin: EdgeInsets.zero,),
                            Tab(text: 'Reviews',iconMargin: EdgeInsets.zero,),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                      child: Container(
                        height: 1,
                        width: width,
                        color: AppColors.grey.withOpacity(0.1),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                      child: Text(
                        "This is a washed concreting sand suitable for concrete manufacture when mixed with gravel and cement. It is also ideal for bedding flagstones and block paving. This is a Sharp Sand with larger grain size, commonly used as a bedding material for paving. Delivered to your construction site",
                        style: AppTextStyle.subtitle1.copyWith(
                          fontSize: multiplier * 0.075,
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width*0.45,
                          child: Padding(
                            padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                            child: AppButton(
                              title: 'Add To Cart',
                              onPressed: () {},
                              borderRadius: 10,
                              padding: EdgeInsets.symmetric(vertical: Get.height*0.02),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: Get.width*0.45,
                          child: Padding(
                            padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                            child: AppButton(
                              title: 'Buy Now',
                              onPressed: () {},
                              borderRadius: 10,
                              padding: EdgeInsets.symmetric(vertical: Get.height*0.02),
                              border: Border.all(color: AppColors.primary),
                              bckgrndColor: Colors.white,
                              fontColor: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: AppColors.backgroundVariant2,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/homeIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Home',
                      backgroundColor: AppColors.background,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        controller.currentBottomNavPage.value == 1 ? 'assets/images/chat_filled.png' : 'assets/images/chatIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/projectIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Project',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/cartIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/profileIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: controller.currentBottomNavPage.value,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    controller.currentBottomNavPage.value = index;
                    controller.update(['home']);
                    Get.back();
                  }
              ),
            );
          }),
    );
  }
}