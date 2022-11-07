import 'dart:convert';

import 'package:bog/app/modules/shop/product_details.dart';
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
import '../../global_widgets/tabs.dart';

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
                      height: width*0.04,
                    ),
                    Container(
                      height: 1,
                      width: width,
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: width*0.04,
                    ),
                    SizedBox(
                      height: Get.height*0.8,
                      child: VerticalTabs(
                        backgroundColor: AppColors.backgroundVariant2,
                        tabBackgroundColor: AppColors.backgroundVariant2,
                        indicatorColor: AppColors.primary,
                        tabsShadowColor: AppColors.backgroundVariant2,
                        tabsWidth: Get.width*0.25,
                        initialIndex: 0,
                        tabs: const <Tab>[
                          Tab(child: Text('Sand')),
                          Tab(child: Text('Granite')),
                          Tab(child: Text('Cement')),
                          Tab(child: Text('Steel')),
                        ],
                        contents: <Widget>[
                          SizedBox(
                            height: Get.height * 0.75,
                            width: Get.width * 0.7,
                            child: GridView.builder(
                              itemCount: 20,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: width*0.0),
                                  child: InkWell(
                                    onTap: (){
                                      Get.to(const ProductDetails(key: Key('ProductDetails')));
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/Group 47037.png"),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.75,
                            width: Get.width * 0.7,
                            child: GridView.builder(
                              itemCount: 20,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: width*0.0),
                                  child: InkWell(
                                    onTap: (){
                                      Get.to(const ProductDetails(key: Key('ProductDetails')));
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/Group 47037.png"),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.75,
                            width: Get.width * 0.7,
                            child: GridView.builder(
                              itemCount: 20,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: width*0.0),
                                  child: InkWell(
                                    onTap: (){
                                      Get.to(const ProductDetails(key: Key('ProductDetails')));
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/Group 47037.png"),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.75,
                            width: Get.width * 0.7,
                            child: GridView.builder(
                              itemCount: 20,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: width*0.0),
                                  child: InkWell(
                                    onTap: (){
                                      Get.to(const ProductDetails(key: Key('ProductDetails')));
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/Group 47037.png"),
                                          fit: BoxFit.fitHeight,
                                        ),
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
