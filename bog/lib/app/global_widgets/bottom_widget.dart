// import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';
// import '../data/model/log_in_model.dart';
// import '../data/providers/my_pref.dart';

class HomeBottomWidget extends StatefulWidget {
  final bool isHome;
  final HomeController controller;
  const HomeBottomWidget(
      {super.key, required this.controller, required this.isHome});

  @override
  State<HomeBottomWidget> createState() => _HomeBottomWidgetState();
}

class _HomeBottomWidgetState extends State<HomeBottomWidget> {
  //   var homeController = Get.find<HomeController>();

  // @override
  // void initState() {
  //   super.initState();
  //   var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
   
  //   var type = logInDetails.userType;
  //       // .toString()
  //       // .replaceAll("_", " ")
  //       // .capitalizeFirst
  //       // .toString();
  //       // print('fhdhoef');
  //       //  print('fhdhwvwoef'); print('fhdhoreef');
  //       //  print(type);
  //   if (type == "private_client") {
  //     homeController.currentType = "Client";
  //   } else if (type == "vendor") {
  //     homeController.currentType = "Product Partner";
  //   } else if (type == 'professional'){
  //     homeController.currentType = 'Service Partner';
  //   }
  //   else {
  //     homeController.currentType = "Corporate Client";
  //   }
  //   homeController.updateNewUser(
  //       logInDetails.userType
  //           .toString()
  //           .replaceAll("_", " ")
  //           .capitalizeFirst
  //           .toString(),
  //       updatePages: true);
  // }

  
  @override
  Widget build(BuildContext context) {
    return widget.isHome
        ? BottomNavigationBar(
            backgroundColor: AppColors.backgroundVariant2,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    widget.controller.homeIcon,
                    width: 20,
                    //color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                  ),
                ),
                label: widget.controller.homeTitle,
                backgroundColor: AppColors.background,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    widget.controller.currentBottomNavPage.value == 1
                        ? 'assets/images/chat_filled.png'
                        : 'assets/images/chatIcon.png',
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
                    widget.controller.projectIcon,
                    width: 20,
                    //color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                  ),
                ),
                label: widget.controller.projectTitle,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: badges.Badge(
                    badgeContent: Text(widget.controller.cartLength.toString()),
                    badgeStyle: const badges.BadgeStyle(badgeColor: AppColors.primary,padding: EdgeInsets.all(5)),
                    child: Image.asset(
                      widget.controller.cartIcon,
                      width: 25,
                      //color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                    ),
                  ),
                ),
                label: widget.controller.cartTitle,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    widget.controller.profileIcon,
                    width: 25,
                    //color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                  ),
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: widget.controller.currentBottomNavPage.value,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              widget.controller.currentBottomNavPage.value = index;
              widget.controller.updateNewUser(widget.controller.currentType);
              widget.controller.update(['home']);
            })
        : BottomNavigationBar(
            backgroundColor: AppColors.backgroundVariant2,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    widget.controller.homeIcon,
                    width: 20,
                    //color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                  ),
                ),
                label: widget.controller.homeTitle,
                backgroundColor: AppColors.background,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    widget.controller.currentBottomNavPage.value == 1
                        ? 'assets/images/chat_filled.png'
                        : 'assets/images/chatIcon.png',
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
                    widget.controller.projectIcon,
                    width: 20,
                    //color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                  ),
                ),
                label: widget.controller.projectTitle,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: badges.Badge(
                    badgeContent: Text(widget.controller.cartLength.toString()),
                    badgeStyle: const badges.BadgeStyle(badgeColor: AppColors.primary,padding: EdgeInsets.all(5)),
                    child: Image.asset(
                      widget.controller.cartIcon,
                      width: 25,
                      //color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                    ),
                  ),
                ),
                label: widget.controller.cartTitle,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(
                    widget.controller.profileIcon,
                    width: 25,
                    //color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                  ),
                ),
                label: 'Profile',
              ),
            ],
            currentIndex: widget.controller.currentBottomNavPage.value,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              widget.controller.currentBottomNavPage.value = index;
              widget.controller.updateNewUser(widget.controller.currentType);
              Get.back();
            });
  }
}
