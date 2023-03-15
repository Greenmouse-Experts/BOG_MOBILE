import 'package:bog/app/global_widgets/app_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/providers/api.dart';
import '../../../global_widgets/app_input.dart';
import '../../../global_widgets/page_dropdown.dart';

class LandSurvey extends StatefulWidget {
  const LandSurvey({Key? key}) : super(key: key);

  @override
  State<LandSurvey> createState() => _LandSurveyState();
}

class _LandSurveyState extends State<LandSurvey> {
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var lgaController = TextEditingController(text: 'Eti Osa');
  var sizeController = TextEditingController(text: '0 - 1000 sq.m');
  var typeController = TextEditingController(text: 'Residential');
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
          systemNavigationBarIconBrightness: Brightness.dark),
      child: GetBuilder<HomeController>(
          id: 'LandSurvey',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05,
                          left: width * 0.045,
                          top: kToolbarHeight),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              "assets/images/back.svg",
                              height: width * 0.045,
                              width: width * 0.045,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Create A Project",
                                  style: AppTextStyle.subtitle1.copyWith(
                                      fontSize: multiplier * 0.07,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Container(
                      height: 1,
                      width: width,
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: Get.height * 0.82,
                        child: PageView(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: Text(
                                      "Request for Land Survey",
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.08,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    height: width * 0.015,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: Image.asset(
                                      "assets/images/line_coloured.png",
                                      width: width * 0.3,
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: width * 0.08,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: AppInput(
                                              hintText:
                                                  "Enter the name of your property",
                                              label: "Name of property ",
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter the name of your property";
                                                }
                                                return null;
                                              },
                                              controller: nameController,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: AppInput(
                                              hintText:
                                                  "Enter the location of your property",
                                              label: "Location of property",
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter the location of your property";
                                                }
                                                return null;
                                              },
                                              controller: locationController,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageDropButton(
                                              label:
                                                  "Local Government of the property",
                                              hint: '',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              onChanged: (val) {
                                                lgaController.text = val;
                                              },
                                              value: "Eti Osa",
                                              items: [
                                                "Eti Osa",
                                                "Lagos Island",
                                                "Ikeja",
                                                "Apapa",
                                                "Agege",
                                                "Alimosho",
                                                "Amuwu Odofin",
                                                "Ibeju Lekki",
                                                "Ifako Ijaye",
                                                "Kosofe",
                                                "Lagos Mainland",
                                                "Mushin",
                                                "Oshodi Isolo",
                                                "Ojo",
                                                "Shomolu",
                                                "Surulere",
                                                "Ajeromi-Ifelodun",
                                                "Badagry",
                                                "Epe",
                                                "Ikorodu"
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageDropButton(
                                              label: "Size of land",
                                              hint: '',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              onChanged: (val) {
                                                sizeController.text = val;
                                              },
                                              value: "0 - 1000 sq.m",
                                              items: [
                                                "0 - 1000 sq.m",
                                                "1001 - 2000 sq.m",
                                                "2001 - 4000 sq.m",
                                                "40001 - 5000 sq.m",
                                                "5001 - 1 HA",
                                                "1.01 HA - 2 HA",
                                                "2.01 HA - 4 HA",
                                                "4.01 HA - 6 HA",
                                                "6.01 HA - 8 HA",
                                                "8.01 HA - 10 HA",
                                                "10.01 HA - 15 HA",
                                                "15.01 HA - 20 HA",
                                                "20.01 HA - 25 HA",
                                                "25.01 HA - 30 HA",
                                                "30.01 HA - 35 HA",
                                                "35.01 HA - 40 HA",
                                                "40.01 HA - 45 HA",
                                                "45.01 HA -50 HA",
                                                "Over 50 HA"
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageDropButton(
                                              label:
                                                  "Type of property to be built ",
                                              hint: '',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              onChanged: (val) {
                                                typeController.text = val;
                                              },
                                              value: "Residential",
                                              items: [
                                                "Residential",
                                                "Commercial",
                                                "Industrial",
                                                "Educational",
                                                "Religious"
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageDropButton(
                                              label: "Type of survey ",
                                              hint: '',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              onChanged: (val) {
                                                surveyController.text = val;
                                              },
                                              value: "Perimeter Survey",
                                              items: [
                                                "Perimeter Survey",
                                                "Detailed Survey",
                                                "As-built survey",
                                                "Re-establishment of beacons",
                                                "Compilation of plans",
                                                "Court Appearance",
                                                "Engineering Survey",
                                                "Change of Title"
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: AppButton(
                                              title: "Submit",
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  var body = {
                                                    "title": title,
                                                    "propertyName":
                                                        nameController.text,
                                                    "propertyLocation":
                                                        locationController.text,
                                                    "propertyLga":
                                                        lgaController.text,
                                                    "landSize":
                                                        sizeController.text,
                                                    "propertyType":
                                                        typeController.text,
                                                    "surveyType":
                                                        surveyController.text,
                                                  };
                                                  var response = await Api()
                                                      .postData(
                                                          "/projects/land-survey/request",
                                                          body: body,
                                                          hasHeader: true);
                                                  if (response.isSuccessful) {
                                                    pageController.animateToPage(
                                                        1,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        curve: Curves.easeIn);
                                                  } else {
                                                    Get.snackbar(
                                                        "Error",
                                                        response.data
                                                            .toString());
                                                  }
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Project Created",
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.05,
                                          right: width * 0.05),
                                      child: Text(
                                        "Your project has been created. You would be notified when you get a service provider.  ",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.06,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05,
                                      right: width * 0.05,
                                      bottom: width * 0.2),
                                  child: AppButton(
                                    title: "View My Projects",
                                    onPressed: () {
                                      controller.currentBottomNavPage.value = 2;
                                      controller.updateNewUser(
                                          controller.currentType);
                                      Get.back();
                                      Get.back();
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
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
                    controller.update(['home']);
                    Get.back();
                    Get.back();
                  }),
            );
          }),
    );
  }
}
