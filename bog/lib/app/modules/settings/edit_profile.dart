import 'dart:convert';

import 'package:bog/app/global_widgets/app_button.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/page_input.dart';
import '../../global_widgets/tabs.dart';

class EditProfile extends GetView<HomeController> {
  const EditProfile({Key? key}) : super(key: key);

  static const route = '/EditProfile';

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    TextEditingController firstName = TextEditingController(text: logInDetails.fname);
    TextEditingController lastName = TextEditingController(text: logInDetails.lname);
    TextEditingController email = TextEditingController(text: logInDetails.email);
    TextEditingController phoneNumber = TextEditingController(text: logInDetails.phone);
    TextEditingController address = TextEditingController(text: logInDetails.address);
    TextEditingController state = TextEditingController(text: logInDetails.state);
    TextEditingController city = TextEditingController(text: logInDetails.city);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: GetBuilder<HomeController>(
          id: 'EditProfile',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
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
                                    "Edit Info",
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
                      Row(
                        children: [
                          SizedBox(
                            width: width*0.03,
                          ),
                          SizedBox(
                            width: Get.width * 0.22,
                            height: Get.width * 0.22,
                            child: IconButton(
                              icon: AppAvatar(
                                imgUrl: (logInDetails.photo).toString(),
                                radius: Get.width * 0.16,
                                name: "${logInDetails.fname} ${logInDetails.lname}",
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
                                "${logInDetails.fname} ${logInDetails.lname}",
                                style: AppTextStyle.subtitle1.copyWith(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.045,
                                ),
                              ),
                              Text(
                                logInDetails.userType.toString().replaceAll("_", " ").capitalizeFirst.toString(),
                                style: AppTextStyle.subtitle1.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: Get.width * 0.035,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.03,right: width*0.03),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width*0.45,
                                  child: PageInput(
                                    hint: '',
                                    label: 'First Name',
                                    isCompulsory: true,
                                    controller: firstName,
                                  ),
                                ),

                                SizedBox(
                                  width: width*0.45,
                                  child: PageInput(
                                    hint: '',
                                    label: 'Last Name',
                                    isCompulsory: true,
                                    controller: lastName,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: width*0.04,
                            ),
                            PageInput(
                              hint: '',
                              label: 'Email',
                              isCompulsory: true,
                              readOnly: true,
                              controller: email,
                            ),
                            SizedBox(
                              height: width*0.04,
                            ),
                            PageInput(
                              hint: '',
                              label: 'Phone Number',
                              isCompulsory: true,
                              controller: phoneNumber,
                            ),
                            SizedBox(
                              height: width*0.04,
                            ),
                            PageInput(
                              hint: 'Enter your address',
                              label: 'Address',
                              isCompulsory: false,
                              controller: address,
                            ),
                            SizedBox(
                              height: width*0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width*0.45,
                                  child: PageInput(
                                    hint: 'Enter State',
                                    label: 'State',
                                    isCompulsory: false,
                                    controller: state,
                                  ),
                                ),

                                SizedBox(
                                  width: width*0.45,
                                  child: PageInput(
                                    hint: 'Enter City',
                                    label: 'City',
                                    isCompulsory: false,
                                    controller: city,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height*0.05,
                            ),
                            AppButton(
                              title: "Save Changes",
                              onPressed: (){},
                            )
                          ],
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
                  }
              ),

            );
          }),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    Key? key,
    required this.width,
    required this.function,
    required this.asset,
    required this.title,
    required this.multiplier,
  }) : super(key: key);

  final double width;
  final Function() function;
  final String asset;
  final String title;
  final double multiplier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
      child: InkWell(
        onTap: function,
        child: Container(
          height: width*0.4,
          width: width*0.4,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: width*0.15,
                width: width*0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(asset),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: width*0.04,
              ),
              Text(
                title,
                style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.065,color: Colors.black,fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
