import 'dart:convert';

import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/modules/settings/kyc/job_experience.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/extensions.dart';
import 'package:bog/core/utils/input_mixin.dart';
import 'package:bog/core/utils/widget_util.dart';
import 'package:bog/core/widgets/click_text.dart';
import 'package:bog/core/widgets/custom_expandable.dart';
import 'package:bog/core/widgets/date_picker_widget.dart';
import 'package:bog/core/widgets/file_picker_widget.dart';
import 'package:bog/core/widgets/input_text_field.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddJob extends StatefulWidget {

  final JobModel? jobModel;
  const AddJob({this.jobModel,
    Key? key}) : super(key: key);

  static const route = '/AddJob';

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> with InputMixin {
  DateTime? date;
  int? yearOfExperience;
  PlatformFile? fileInfo;
  JobModel? jobModel;

  @override
  void initState() {
    super.initState();
    jobModel = widget.jobModel;
    date = jobModel!=null?jobModel!.date:null;
    fileInfo = jobModel!=null?jobModel!.fileInfo:null;

    inputModels.add(InputTextFieldModel(
      "Name",
      hint: "Enter the name",prefill: jobModel!=null?jobModel!.name:null
    ));

    inputModels.add(
        InputTextFieldModel("Value (NGN)", hint: "Enter the monetary value",
        prefill: jobModel!=null?jobModel!.value:null));

    inputModels.add(InputTextFieldModel(
        "If this company is a subsidiary, what involvement, if any will the arent company have",
        hint: "State the involvement of the parent company (If any)",
        optional: true,prefill: jobModel!=null?jobModel!.subsidiary:null));
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    // double multiplier = 25 * size.height * 0.01;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: GetBuilder<HomeController>(
          id: 'AddJob',
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
                              padding: EdgeInsets.only(
                                  right: width * 0.05,
                                  left: width * 0.045,
                                  top: kToolbarHeight),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Add Job Experience",
                                          style: AppTextStyle.subtitle1
                                              .copyWith(
                                                  fontSize: 20,
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
                                children: [
                                  InputTextField(
                                      inputTextFieldModel: inputModels[0]),
                                  addSpace(20),
                                  InputTextField(
                                      inputTextFieldModel: inputModels[1],isAmount: true,),
                                  addSpace(20),

                                  DatePickerWidget((d){
                                    date = d;
                                    setState(() {});
                                  },label:"Date of Incorporation",hint: "dd/mm/yy",date: date,),
                                  addSpace(20),
                                  FilePickerWidget(onSelected: (PlatformFile file) {
                                    setState(() {
                                      fileInfo = file;
                                    });
                                  },title: "Upload Provisional Documents (If any)"),
                                  addSpace(20),
                                  ClickText("Select Years", yearOfExperience==null?"":"${yearOfExperience} year${yearOfExperience==1?"":"s"} of experience", (){
                                    showListDialog(context, List.generate(31, (index) => "$index year${index==1?"":"s"} of experience"), (_){

                                      setState(() {
                                        yearOfExperience = _;
                                      });
                                    },returnIndex: true);

                                  },label:"Years of Experience as a Contractor/Sub Contractor"),
                                  addSpace(20),
                                  InputTextField(
                                      inputTextFieldModel: inputModels[2],maxLine: 4,),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    addSpace(20),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: AppButton(
                        title: "Add",
                        onPressed: () async {
                          Map studs = {};
                          studs[2] = () {
                            if (date==null) {
                              return "Select date of incorporation";
                            }
                            return null;
                          };
                          studs[4] = () {
                            if (yearOfExperience==null) {
                              return "Select years of experience";
                            }
                            return null;
                          };
                          bool proceed = validateInputModels(studs: studs);
                          if (proceed) {

                            String name = inputModels[0].text;
                            String value = inputModels[1].text.replaceAll(",", "");
                            String incorp = inputModels[2].text;

                            Navigator.pop(context,JobModel(name: name,
                                value: double.parse(value),
                                date: date!, fileInfo: fileInfo!, years: yearOfExperience!,
                                subsidiary: incorp));

                          }

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
                  }),
            );
          }),
    );
  }
}
