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
import '../../data/model/ProjectListModel.dart';
import '../../data/providers/api.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/page_dropdown.dart';
import '../home/pages/CartTab.dart';


class ProjectInfo extends StatefulWidget {
  const ProjectInfo({Key? key}) : super(key: key);

  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var project = Get.arguments as ProjectListModel;
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
          id: 'ProjectInfo',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                height: Get.height * 0.78,
                child: SingleChildScrollView(
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
                                    "Project Info",
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
                      Image.asset(
                        'assets/images/Rectangle 18671.png',
                        fit: BoxFit.cover,
                        width: width,
                        height: Get.height*0.2,
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),


                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "Project Name",
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
                          project.title.toString(),
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.068,color: Colors.black,fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(
                        height: width*0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "Project ID",
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
                          project.id.toString(),
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.068,color: Colors.black,fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(
                        height: width*0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "Service Type",
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
                          project.projectTypes.toString().capitalizeFirst.toString().replaceAll("_", " "),
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.068,color: Colors.black,fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(
                        height: width*0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: 10),
                        child: Text(
                          "Project Description",
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
                          project.description == null ? "No Description Available" : project.description.toString(),
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.068,color: Colors.black,fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(
                        height: width*0.05,
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
                    Get.back();
                  }
              ),
            );
          }),
    );
  }
}

class _TextButton extends StatelessWidget {
  final String imageAsset;
  final String text;
  final String? subtitle;
  final bool showArrow;
  final Function() onPressed;
  const _TextButton({required this.imageAsset,required this.text, required this.onPressed, this.subtitle,this.showArrow = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width * 0.1,
              height: Get.width * 0.1,
              decoration: BoxDecoration(
                color: const Color(0xffE8F4FE),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image.asset(
                  imageAsset,
                  width: Get.width * 0.05,
                  height: Get.width * 0.05,
                ),
              ),
            ),
            SizedBox(
              width: Get.width*0.7,
              child: Padding(
                padding: EdgeInsets.only(left: Get.width*0.01),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: Get.height*0.01,
                      ),
                      Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: AppTextStyle.subtitle1.copyWith(color: text == "Log Out" ? AppColors.bostonUniRed : Colors.black,fontSize: Get.width*0.04,fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: Get.height*0.01,
                      ),
                      if(subtitle!=null)
                        Text(
                          subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: AppTextStyle.subtitle1.copyWith(color: Colors.black),
                        ),
                      if(subtitle!=null)
                        SizedBox(
                          height: Get.height*0.01,
                        ),
                    ]
                ),
              ),
            ),

            IconButton(
              onPressed: onPressed,
              padding: EdgeInsets.zero,
              icon: showArrow ? Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: Get.width*0.04,) : Container(),
            )
          ],
        ),
      ),
    );
  }
}