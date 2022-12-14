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


class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
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
          id: 'AddProject',
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
                                  "Add Product",
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
                      child: SizedBox(
                        height: Get.height*0.82,
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
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: width*0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                            child: PageInput(
                                              hint: "Enter your product name ",
                                              label: "Product Name",
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter the name of your property";
                                                }
                                                return null;
                                              },
                                              //controller: nameController,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height*0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                            child: AppInput(
                                              hintText: "Tell us about your product",
                                              label: "Product Description",
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter the location of your property";
                                                }
                                                return null;
                                              },
                                              //controller: locationController,
                                              maxLines: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height*0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                            child: PageInput(
                                              hint: "Enter your product price",
                                              label: "Product Price",
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter the location of your property";
                                                }
                                                return null;
                                              },
                                              //controller: locationController,
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height*0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                            child: PageDropButton(
                                              label: "Product Category",
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
                                            child: PageInput(
                                              hint: "Pick a photo to upload",
                                              label: "Upload Product Photo",
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter the location of your property";
                                                }
                                                return null;
                                              },
                                              isFilePicker: true,
                                              //controller: locationController,
                                            ),
                                          ),



                                          SizedBox(
                                            height: Get.height*0.04,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                            child: AppButton(
                                              title: "Submit Product",
                                              onPressed: () async{
                                                /*if(formKey.currentState!.validate()){
                                                  var body = {
                                                    "title": title,
                                                    "propertyName": nameController.text,
                                                    "propertyLocation": locationController.text,
                                                    "propertyLga": lgaController.text,
                                                    "landSize": sizeController.text,
                                                    "propertyType": typeController.text,
                                                    "surveyType": surveyController.text,
                                                  };
                                                  var response = await Api().postData("/projects/land-survey/request",body: body,hasHeader: true);
                                                  if(response.isSuccessful){
                                                    pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                                  }else{
                                                    Get.snackbar("Error", response.data.toString());
                                                  }
                                                }*/
                                                pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
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
                                      "Product Submitted",
                                      style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: Get.height*0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                                      child: Text(
                                        "Congratulations,  your product has been submitted successfully. ",
                                        style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.06,color: Colors.black,fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: width*0.2),
                                  child: AppButton(
                                    title: "See My Products",
                                    onPressed: (){
                                      controller.currentBottomNavPage.value = 3;
                                      controller.update(['home']);
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