import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';

class HomeBottomWidget extends StatelessWidget {
  final bool isHome;
  final HomeController controller;
  final bool doubleNavigate;
  const HomeBottomWidget(
      {super.key,
      required this.isHome,
      required this.controller,
      required this.doubleNavigate});

  @override
  Widget build(BuildContext context) {
    return isHome
        ? GetBuilder<HomeController>(
            builder: (controller) => BottomNavigationBar(
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
                      ),
                    ),
                    label: controller.projectTitle,
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: controller.currentType == 'Client' ||
                              controller.currentType == 'Corporate Client'
                          ? badges.Badge(
                              badgeContent: Text(
                                controller.cartLength.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              badgeStyle: const badges.BadgeStyle(
                                  badgeColor: AppColors.primary,
                                  padding: EdgeInsets.all(5)),
                              child: Image.asset(
                                controller.cartIcon,
                                width: 25,
                              ),
                            )
                          : Image.asset(
                              controller.cartIcon,
                              width: 25,
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
                }),
          )
        : GetBuilder<HomeController>(builder: (controller) {
            return BottomNavigationBar(
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
                      ),
                    ),
                    label: controller.projectTitle,
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: controller.currentType == 'Client' ||
                              controller.currentType == 'Corporate Client'
                          ? badges.Badge(
                              badgeContent: Text(
                                controller.cartLength.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              badgeStyle: const badges.BadgeStyle(
                                  badgeColor: AppColors.primary,
                                  padding: EdgeInsets.all(5)),
                              child: Image.asset(
                                controller.cartIcon,
                                width: 25,
                              ),
                            )
                          : Image.asset(
                              controller.cartIcon,
                              width: 25,
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
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: controller.currentBottomNavPage.value,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: Colors.grey,
                onTap: doubleNavigate
                    ? (index) {
                        Get.back();
                        Get.back();
                        controller.currentBottomNavPage.value = index;
                        controller.updateNewUser(controller.currentType);
                      }
                    : (index) {
                        controller.currentBottomNavPage.value = index;
                        controller.updateNewUser(controller.currentType);
                        Get.back();
                      });
          });
  }
}
