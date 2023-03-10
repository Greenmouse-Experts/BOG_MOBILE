import 'package:bog/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';

class HomeBottomWidget extends StatelessWidget {
  final bool isHome;
  final HomeController controller;
  const HomeBottomWidget(
      {super.key, required this.controller, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return isHome
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
                    controller.currentBottomNavPage.value == 1
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
              controller.update(['home']);
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
                    controller.currentBottomNavPage.value == 1
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
            });
  }
}