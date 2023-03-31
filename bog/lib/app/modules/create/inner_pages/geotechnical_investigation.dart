import 'dart:io';

import 'package:bog/app/global_widgets/app_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/providers/api.dart';

import '../../../global_widgets/page_dropdown.dart';
import '../../../global_widgets/page_input.dart';

import 'package:dio/dio.dart' as dio;

class GeotechnicalInvestigation extends StatefulWidget {
  const GeotechnicalInvestigation({Key? key}) : super(key: key);

  @override
  State<GeotechnicalInvestigation> createState() =>
      _GeotechnicalInvestigationState();
}

class _GeotechnicalInvestigationState extends State<GeotechnicalInvestigation> {
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();
  var formKey1 = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var sizeController = TextEditingController();
  var intendedController = TextEditingController(text: 'Residential Building');
  var isController = TextEditingController(text: 'Yes');
  var picture = TextEditingController();
  var boreholeController = TextEditingController();
  var depthController = TextEditingController();
  var cptController = TextEditingController();
  var tonnageController = TextEditingController(text: '2.5 Tons');
  var typeController = TextEditingController(text: 'Mechanical');
  var specialController = TextEditingController(text: "Yes");
  var specifyController = TextEditingController();

  File? picturePlan;

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
          id: 'GeotechnicalInvestigation',
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
                        height: Get.height * 1.2,
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
                                      "Request for Geotechnical \nAnd Geophysical Information",
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
                                  SizedBox(
                                    height: width * 0.08,
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
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageInput(
                                              hint: "Enter your name  ",
                                              label: "Name of client",
                                              controller: nameController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your name";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageInput(
                                              hint: "Enter location  ",
                                              label: "Location Of Site",
                                              controller: locationController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter location";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageInput(
                                              hint: "Enter land size  ",
                                              label: "Size Of Land",
                                              controller: sizeController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter land size";
                                                }
                                                return null;
                                              },
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
                                              label: "Intended Project",
                                              hint: '',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              onChanged: (val) {
                                                intendedController.text = val;
                                              },
                                              value: "Residential Building",
                                              items: [
                                                "Residential Building",
                                                "Industrial Building",
                                                "High Rise Building",
                                                "Road",
                                                "Estate",
                                                "Dumping Site",
                                                "Water Borehole"
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
                                                  "Is there a building on the site?",
                                              hint: '',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              onChanged: (val) {
                                                isController.text = val;
                                              },
                                              value: "Yes",
                                              items: [
                                                "Yes",
                                                "No"
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
                                              title: "Proceed",
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  pageController.animateToPage(
                                                      1,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeIn);
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
                            Form(
                              key: formKey1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    child: Text(
                                      "Request for Geotechnical \nAnd Geophysical Information",
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
                                  SizedBox(
                                    height: width * 0.08,
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
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageInput(
                                              hint: "Enter your name  ",
                                              label:
                                                  "Upload available picture of the land or property",
                                              isFilePicker: true,
                                              controller: picture,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please pick a picture to upload";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                picturePlan = file;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageInput(
                                              hint: "Enter number  ",
                                              label:
                                                  "Number of intended geotechnical borehole",
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: boreholeController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter number of borehole";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageInput(
                                              hint: "Enter depth  ",
                                              label: "Depth of borehole",
                                              keyboardType: const TextInputType
                                                      .numberWithOptions(
                                                  decimal: true),
                                              controller: depthController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter depth of borehole";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.05,
                                                right: width * 0.05),
                                            child: PageInput(
                                              hint: "Enter CPT number  ",
                                              label: "Number of CPT",
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: cptController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter number of CPT";
                                                }
                                                return null;
                                              },
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
                                              label: "Tonnage of CPT",
                                              hint: '',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              onChanged: (val) {
                                                tonnageController.text = val;
                                              },
                                              value: "2.5 Tons",
                                              items: [
                                                "2.5 Tons",
                                                "10 Tons",
                                                "20 Tons"
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
                                              label: "Types of CPT",
                                              hint: '',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              onChanged: (val) {
                                                typeController.text = val;
                                              },
                                              value: "Mechanical",
                                              items: [
                                                "Mechanical",
                                                "Electrical",
                                                "Dynamic"
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
                                                  "Apart from borehole and CPT, are there any special test or \ninvestigation you intend to run?",
                                              hint: '',
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              onChanged: (val) {
                                                specialController.text = val;
                                              },
                                              value: "Yes",
                                              items: [
                                                "Yes",
                                                "No"
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
                                            child: PageInput(
                                              hint: "",
                                              label: "If yes, please specify",
                                              controller: specifyController,
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
                                                if (formKey1.currentState!
                                                    .validate()) {
                                                  Map<String, dynamic> body = {
                                                    'title': title,
                                                    'clientName':
                                                        nameController.text,
                                                    'projectLocation':
                                                        locationController.text,
                                                    "projectType":
                                                        intendedController.text,
                                                    "siteHasBuilding":
                                                        isController.text ==
                                                                "Yes"
                                                            ? true
                                                            : false,
                                                    "noOfIntentendedBorehole":
                                                        boreholeController.text,
                                                    "depthOfBorehole":
                                                        depthController.text,
                                                    "noOfCpt":
                                                        cptController.text,
                                                    "tonnageOfCpt":
                                                        tonnageController.text,
                                                    "typeOfCpt":
                                                        typeController.text,
                                                    "anySpecialInvestigation":
                                                        specialController
                                                                    .text ==
                                                                "Yes"
                                                            ? true
                                                            : false,
                                                    "comment":
                                                        specifyController.text,
                                                  };
                                                  body['propertyPicture'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    picturePlan!.path,
                                                    filename: picturePlan!.path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  var formData =
                                                      dio.FormData.fromMap(
                                                          body);
                                                  var response = await Api()
                                                      .postData(
                                                          "/projects/geotechnical/request",
                                                          body: formData,
                                                          hasHeader: true);
                                                  if (response.isSuccessful) {
                                                    pageController.animateToPage(
                                                        2,
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
