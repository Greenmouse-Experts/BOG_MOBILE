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
import '../../data/model/MyProducts.dart';
import '../../data/model/ShopCategory.dart';
import '../../data/providers/api_response.dart';
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
                child: SingleChildScrollView(
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
                            Row(
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
                      FutureBuilder<ApiResponse>(
                          future: controller.userRepo.getData("/product/category"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.data!.isSuccessful) {
                              final posts = ShopCategory.fromJsonList(snapshot.data!.data);
                              List<Tab> tabs = [];
                              List<Widget> contents = [];
                              for (var element in posts) {
                                tabs.add(Tab(
                                    child: Text(element.name.toString())
                                ));

                                contents.add(
                                  FutureBuilder<ApiResponse>(
                                      future: controller.userRepo.getData("/products"),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done && snapshot.data!.isSuccessful) {
                                          final posts = MyProducts.fromJsonList(snapshot.data!.data);
                                          posts.removeWhere((e) => e.categoryId != element.id);
                                          if(posts.isEmpty){
                                            return SizedBox(
                                              height: Get.height*0.7,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "No Products Available",
                                                    style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          return SizedBox(
                                            height: Get.height * 0.75,
                                            width: Get.width * 0.7,
                                            child: GridView.builder(
                                              itemCount: posts.length,
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5),
                                              scrollDirection: Axis.vertical,
                                              padding: const EdgeInsets.all(0),
                                              itemBuilder: (BuildContext context, int index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(left: width*0.03,right: width*0.03),
                                                  child: InkWell(
                                                    onTap: (){
                                                      Get.to(const ProductDetails(key: Key('ProductDetails')),arguments: posts[index]);
                                                    },
                                                    child: Container(
                                                      width: width*0.35,
                                                      height: Get.height*0.35,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.backgroundVariant2,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: AppColors.grey.withOpacity(0.1),width: 1),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            height: Get.height*0.1,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(top: width*0.01,left: width*0.01,right: width*0.01),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(10), child: Image.network(
                                                                posts[index].productImage!.isEmpty ? "https://www.woolha.com/media/2020/03/eevee.png" :
                                                                posts[index].productImage![0].url.toString(),
                                                                fit: BoxFit.cover,
                                                                errorBuilder: (context, error, stackTrace) {
                                                                  return Container(
                                                                    width: width*0.35,
                                                                    height: Get.height*0.1,
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.primary,
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      border: Border.all(color: AppColors.grey.withOpacity(0.1),width: 1),
                                                                    ),
                                                                    child: Center(
                                                                      child: Icon(
                                                                        Icons.image_not_supported,
                                                                        color: AppColors.background,
                                                                        size: width*0.1,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: width*0.02,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: width*0.01,right: width*0.01),
                                                            child: Text(
                                                              posts[index].name.toString(),
                                                              style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.055,color: Colors.black,fontWeight: FontWeight.w600),
                                                              textAlign: TextAlign.start,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: width*0.02,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: width*0.01,right: width*0.01),
                                                            child: Text(
                                                              "N${posts[index].price} /${posts[index].unit}",
                                                              style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.055,color: AppColors.primary,fontWeight: FontWeight.normal),
                                                              textAlign: TextAlign.start,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: width*0.02,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: width*0.01,right: width*0.01),
                                                            child: Text(
                                                              posts[index].createdAt.toString(),
                                                              style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.05,color: AppColors.grey,fontWeight: FontWeight.normal),
                                                              textAlign: TextAlign.start,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }else{
                                          if(snapshot.connectionState == ConnectionState.done){
                                            return SizedBox(
                                              height: Get.height*0.7,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "No Products Found",
                                                    style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                          return SizedBox(
                                            height: Get.height*0.7,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const CircularProgressIndicator(
                                                  color: AppColors.primary,
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      })
                                );
                              }
                              return SizedBox(
                                height: Get.height*0.8,
                                child: VerticalTabs(
                                  backgroundColor: AppColors.backgroundVariant2,
                                  tabBackgroundColor: AppColors.backgroundVariant2,
                                  indicatorColor: AppColors.primary,
                                  tabsShadowColor: AppColors.backgroundVariant2,
                                  tabsWidth: Get.width*0.25,
                                  initialIndex: 0,
                                  tabs: tabs,
                                  contents: contents,
                                ),
                              );
                            }else{
                              if(snapshot.connectionState == ConnectionState.done){
                                return SizedBox(
                                  height: Get.height*0.7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "No Products Categories Found",
                                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return SizedBox(
                                height: Get.height*0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: AppColors.backgroundVariant2,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.homeIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.homeTitle,
                      backgroundColor: AppColors.background,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.currentBottomNavPage.value == 1 ? 'assets/images/chat_filled.png' : 'assets/images/chatIcon.png',
                          width: 22,
                          //color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Message',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.projectIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.projectTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.cartIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.cartTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.profileIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: controller.currentBottomNavPage.value,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    controller.currentBottomNavPage.value = index;
                    controller.updateNewUser(controller.currentType);
                    Get.back();
                  }
              ),
            );
          }),
    );
  }
}
