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
import 'package:bog/core/utils/time_utils.dart';
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

class JobModel{
  final String name;
  final double value;
  final DateTime date;
  final PlatformFile? fileInfo;
  final int years;
  final String subsidiary;

  JobModel({
    required this.name,
    required this.value,
    required this.date,
    this.fileInfo,
    required this.years,
    required this.subsidiary});

}

class JobExperience extends StatefulWidget {
  const JobExperience({Key? key}) : super(key: key);

  static const route = '/JobExperience';

  @override
  State<JobExperience> createState() => _JobExperienceState();
}

class _JobExperienceState extends State<JobExperience> with InputMixin {

  List<JobModel> experiences = [];

  @override
  void initState() {
    super.initState();

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
          id: 'JobExperience',
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
                                          "Job Experience",
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

                                  Text("List your most relevant jobs by monetary value to with other companies",
                                  style: textStyle(false, 14, Colors.black),),

                                ],
                              ),
                            ),


                            addSpace(20),
                            Column(
                              children: List.generate(experiences.length, (index){

                                JobModel jobModel = experiences[index];
                                return Column(
                                  children: [
                                    Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(bottom: 20),
                                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        color: blue.withOpacity(.2),
                                        child: Row(
                                          children: [
                                            Flexible(fit: FlexFit.tight,child: Text("Job Experience (${index+1})",style: textStyle(true, 14, blackColor),)),
                                            Container(
                                              width: 24,height: 24,
                                              child: ElevatedButton(
                                                onPressed: (){
                                                  launchScreen(context, AddJob(jobModel: jobModel,),result:(_){
                                                    if(_==null)return;
                                                    experiences[index] = _;
                                                    setState(() {});
                                                  });
                                                },
                                                child: const Icon(Icons.edit,color: white,size: 12,),
                                                style: ElevatedButton.styleFrom(
                                                    shape: const CircleBorder(),backgroundColor: blue0,padding: EdgeInsets.zero
                                                ),
                                              ),
                                            ),
                                            addSpaceWidth(10),
                                            Container(
                                              width: 24,height: 24,
                                              child: ElevatedButton(
                                                onPressed: (){
                                                  experiences.removeAt(index);
                                                  setState(() {});
                                                },
                                                child: const Icon(Icons.close,color: white,size: 14,),
                                                style: ElevatedButton.styleFrom(
                                                    shape: const CircleBorder(),backgroundColor: red0,padding: EdgeInsets.zero
                                                ),
                                              ),
                                            ),

                                          ],
                                        )),
                                    Container(width: double.infinity,
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        rowItem("Name", jobModel.name),
                                        rowItem("Value", jobModel.value,isAmount: true),
                                        rowItem("Date of Execution", getSimpleDate(jobModel.date.millisecondsSinceEpoch)),
                                        rowItem("Provisional Document", jobModel.fileInfo!=null?jobModel.fileInfo!.name:""),
                                        rowItem("Years of Experience", jobModel.years),
                                        rowItem("Subsidiary Info", jobModel.subsidiary),

                                      ],
                                    ),)

                                  ],
                                );
                              }),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,20,0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      launchScreen(context, const AddJob(),
                                      result: (_){
                                        if(_==null)return;
                                        experiences.add(_);
                                        setState(() {});
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,height: 24,
                                          decoration: const BoxDecoration(
                                            color: blue0,shape: BoxShape.circle
                                          ),
                                          child: const Icon(Icons.add,color: white,size: 14,),
                                        ),
                                        addSpaceWidth(10),
                                        Flexible(child: Text("Add Job Experience",style: textStyle(true, 14, blackColor),))
                                      ],
                                    ),
                                  )
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

