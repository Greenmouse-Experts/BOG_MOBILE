import 'dart:convert';

import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/providers/api.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/page_dropdown.dart';
import '../home/pages/CartTab.dart';


class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var lgaController = TextEditingController(text: 'Eti Osa');
  var sizeController = TextEditingController(text: '0 - 1000 sq.m');
  var typeController = TextEditingController(text:'Residential');
  var surveyController = TextEditingController(text: 'Perimeter Survey');

  @override
  Widget build(BuildContext context) {
    var title = Get.arguments as String?;
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
          id: 'OrderDetails',
          builder: (controller) {
            return Scaffold(
                backgroundColor: AppColors.backgroundVariant2,
                body: SizedBox(
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: kToolbarHeight),
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
                                    "Order Details",
                                    style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w600),
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
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          controller.currentType == "Service Partner" ? "Project ID :  LAN -SUV -132" :"Order ID :  SAN - 123- NDS ",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "Project Name ",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.065,color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: width*0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "Land Survey Project",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.068,color: Colors.black,fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(
                        height: width*0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "Service type",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.065,color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: width*0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "Land Survey",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.068,color: Colors.black,fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(
                        height: width*0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "Service Location",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.065,color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: width*0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "No 7, Street close, Ogba Ikeja, Lagos",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.068,color: Colors.black,fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(
                        height: width*0.15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Container(
                          height: 1,
                          width: width,
                          color: AppColors.grey.withOpacity(0.1),
                        ),
                      ),
                      SizedBox(
                        height: width*0.08,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.4,
                              child: AppButton(
                                title: "Decline",
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                border: Border.all(color: Color(0xFF24B53D)),
                                bckgrndColor: Colors.white,
                                fontColor: Color(0xFF24B53D),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.4,
                              child: AppButton(
                                title: "Accept",
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                border: Border.all(color: Color(0xFF24B53D)),
                                bckgrndColor: Colors.white,
                                fontColor: const Color(0xFF24B53D),
                              ),
                            ),
                          ],
                        ),
                      )
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
                      label: 'Chat',
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