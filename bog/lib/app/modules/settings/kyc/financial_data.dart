import 'dart:convert';

import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/modules/settings/kyc/add_job.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/extensions.dart';
import 'package:bog/core/utils/input_mixin.dart';
import 'package:bog/core/utils/widget_util.dart';
import 'package:bog/core/widgets/click_text.dart';
import 'package:bog/core/widgets/custom_expandable.dart';
import 'package:bog/core/widgets/input_text_field.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';


class FinancialData extends StatefulWidget {
  const FinancialData({Key? key}) : super(key: key);

  static const route = '/FinancialData';

  @override
  State<FinancialData> createState() => _FinancialDataState();
}

class _FinancialDataState extends State<FinancialData> with InputMixin {

  String bankName = "";
  String bankId = "";
  List bankList = ["Zenith Bank","Access Bank","UBA","Eco Bank"];

  String accountType = "";
  List accountTypes = ["Current Account","Savings Account"];



  @override
  void initState() {
    super.initState();

    inputModels.add(InputTextFieldModel(
        "Account Holder Name",
        hint: "Enter account name",
    ));

    inputModels.add(InputTextFieldModel(
        "Account Number",
        hint: "Enter account number",
    ));

    inputModels.add(InputTextFieldModel(
        "Level of Current Overdraft Facility",
        hint: "Enter the level of overdraft facility",
    ));


inputModels.add(InputTextFieldModel(
        "Bankers Name",
        hint: "Enter name of banker",
    ));

inputModels.add(InputTextFieldModel(
        "Bankers Address",
        hint: "Enter bankers address",
    ));







  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery
        .of(context)
        .size;
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
          id: 'FinancialData',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.05,
                                  left: width * 0.045,
                                  top: kToolbarHeight),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          "Financial Data",
                                          style: AppTextStyle.subtitle1
                                              .copyWith(fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
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

                            addSpace(40),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  InputTextField(inputTextFieldModel: inputModels[0],),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[1],keyBoardType: TextInputType.number,),

                                  addSpace(20),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text("Type of Account",style: textStyle(false, 14, blackColor),)),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                          accountTypes.length, (index) {
                                        String name = accountTypes[index];
                                        bool selected = accountType == name;
                                        return GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              accountType=name;
                                            });
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                checkBox(selected),
                                                addSpaceWidth(5),
                                                Text(name, style: textStyle(
                                                    false, 14, blackColor),)
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  addSpace(30),
                                  InputTextField(inputTextFieldModel: inputModels[2]),




                                ],
                              ),
                            ),

                            addSpace(20),
                            Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                color: blue0.withOpacity(.2),
                                child: Text("Reference Bankers(s) Details",style: textStyle(true, 14, blackColor),)),


                            Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,20,0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputTextField(inputTextFieldModel: inputModels[3]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[4],maxLine: 4),
                                ],
                              ),
                            ),


                            addSpace(20),
                            

                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: AppButton(
                        title: "Save",
                        onPressed: () async {

                        },
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
                  }
              ),

            );
          }),
    );
  }
}

