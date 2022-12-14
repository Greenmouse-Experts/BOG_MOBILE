import 'dart:convert';
import 'dart:io';

import 'package:bog/app/global_widgets/app_button.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/providers/api.dart';
import '../../../global_widgets/app_input.dart';
import '../../../global_widgets/page_dropdown.dart';
import '../../../global_widgets/page_input.dart';
import '../../home/home.dart';
import 'package:dio/dio.dart' as dio;



class ContractorOrSmartCalculator extends StatefulWidget {
  const ContractorOrSmartCalculator({Key? key}) : super(key: key);

  @override
  State<ContractorOrSmartCalculator> createState() => _ContractorOrSmartCalculatorState();
}

class _ContractorOrSmartCalculatorState extends State<ContractorOrSmartCalculator> {
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var typeController = TextEditingController(text: 'Residential');
  var type2Controller = TextEditingController(text: 'Bungalow');
  var surveyController = TextEditingController();
  var architecturalController = TextEditingController();
  var structuralController = TextEditingController();
  var mechanicalController = TextEditingController();

  File? surveyPlan;
  File? structuralPlan;
  File? architecturalPlan;
  File? mechanicalPlan;

  @override
  Widget build(BuildContext context) {
    var title  = Get.arguments as String?;
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
          id: 'ContractorOrSmartCalculator',
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
                                  "Create A Project",
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: Get.height*0.85,
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
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: Text(
                                        "Request for Constructor",
                                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.08,color: Colors.black,fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: width*0.015,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: Image.asset(
                                        "assets/images/line_coloured.png",
                                        width: width*0.3,
                                      ),
                                    ),
                                    SizedBox(
                                      height: width*0.08,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: AppInput(
                                        hintText: "Enter your name  ",
                                        label: "Name of client",
                                        controller: nameController,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Please enter your name";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height*0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: AppInput(
                                        hintText: "Enter the location of your project",
                                        label: "Location of project",
                                        controller: locationController,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Please enter the location of your project";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height*0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: PageDropButton(
                                        label: "Type of project",
                                        hint: '',
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        onChanged: (val) {
                                          typeController.text = val;
                                        },
                                        value:  "Residential",
                                        items: ["Residential","Commercial","Industrial","Educational","Religious"].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height*0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: PageDropButton(
                                        label: "If Residential, select type",
                                        hint: '',
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        onChanged: (val) {
                                          type2Controller.text = val;
                                        },
                                        value:  "Bungalow",
                                        items: ["Bungalow","Duplex","Multi-storey","Terraced building","High rise building"].map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height*0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: AppButton(
                                        title: "Proceed to upload documents",
                                        onPressed: (){
                                          if(formKey.currentState!.validate()){
                                            pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: Text(
                                        "Request for Constructor or Smart \nCalculator",
                                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.08,color: Colors.black,fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: width*0.015,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: Image.asset(
                                        "assets/images/line_coloured.png",
                                        width: width*0.3,
                                      ),
                                    ),
                                    SizedBox(
                                      height: width*0.08,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: PageInput(
                                        hint: "Enter your name  ",
                                        label: "Upload survey plan ",
                                        isFilePicker: true,
                                        controller: surveyController,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Please upload survey plan";
                                          }
                                          return null;
                                        },
                                        onFilePicked: (file){
                                          surveyPlan = file;
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: Get.height*0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: PageInput(
                                        hint: "Enter your name  ",
                                        label: "Upload architectural plan",
                                        isFilePicker: true,
                                        controller: architecturalController,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Please upload architectural plan";
                                          }
                                          return null;
                                        },
                                        onFilePicked: (file){
                                          architecturalPlan = file;
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: Get.height*0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: PageInput(
                                        hint: "Enter your name  ",
                                        label: "Upload structural plan (If available) ",
                                        isFilePicker: true,
                                        controller: structuralController,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Please upload structural plan";
                                          }
                                          return null;
                                        },
                                        onFilePicked: (file){
                                          structuralPlan = file;
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: Get.height*0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: PageInput(
                                        hint: "Enter your name  ",
                                        label: "Upload mechanical plan (If available) ",
                                        isFilePicker: true,
                                        controller: mechanicalController,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return "Please upload mechanical plan";
                                          }
                                          return null;
                                        },
                                        onFilePicked: (file){
                                          mechanicalPlan = file;
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: Get.height*0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: AppButton(
                                        title: "Submit",
                                        onPressed: () async {
                                          if(formKey.currentState!.validate()){
                                            Map<String, dynamic> body = {
                                              'title': title,
                                              'clientName': nameController.text,
                                              'projectLocation': locationController.text,
                                              "projectType": typeController.text,
                                              "buildingType": type2Controller.text,
                                            };
                                            body['surveyPlan'] = await dio.MultipartFile.fromFile(
                                              surveyPlan!.path,
                                              filename: surveyPlan!.path.split('/').last,
                                            );
                                            body['structuralPlan'] = await dio.MultipartFile.fromFile(
                                              structuralPlan!.path,
                                              filename: structuralPlan!.path.split('/').last,
                                            );
                                            body['architecturalPlan'] = await dio.MultipartFile.fromFile(
                                              architecturalPlan!.path,
                                              filename: architecturalPlan!.path.split('/').last,
                                            );
                                            body['mechanicalPlan'] = await dio.MultipartFile.fromFile(
                                              mechanicalPlan!.path,
                                              filename: mechanicalPlan!.path.split('/').last,
                                            );
                                            var formData = dio.FormData.fromMap(body);
                                            var response = await Api().postData("/projects/contractor/request",body: formData,hasHeader: true);
                                            if(response.isSuccessful){
                                              pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                            }else{
                                              Get.snackbar("Error", response.data.toString());
                                            }
                                          }
                                        },
                                      ),
                                    )
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
                                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: Get.height*0.02,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                        child: Text(
                                          "Your project has been created. You would be notified when you get a Service Partner.  ",
                                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.06,color: Colors.black,fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: width*0.2),
                                    child: AppButton(
                                      title: "View My Projects",
                                      onPressed: (){
                                        controller.currentBottomNavPage.value = 2;
                                        controller.updateNewUser(controller.currentType);
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
                    controller.update(['home']);
                    Get.back();
                    Get.back();
                  }
              ),
            );
          }),
    );
  }
}