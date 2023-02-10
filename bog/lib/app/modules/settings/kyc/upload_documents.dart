
import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:bog/core/utils/input_mixin.dart';
import 'package:bog/core/utils/widget_util.dart';
import 'package:bog/core/widgets/file_picker_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UploadDocuments extends StatefulWidget {

  static const route = '/UploadDocuments';

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> with InputMixin {

  PlatformFile? companyProfile;
  PlatformFile? orgChart;
  PlatformFile? certOfIncorp;
  PlatformFile? statementOfShares;
  PlatformFile? memoOfAssot;
  PlatformFile? healthPoilcy;
  PlatformFile? qualityProcedure;
  PlatformFile? taxClearance;
  PlatformFile? vatCert;
  PlatformFile? refLetter;
  PlatformFile? compBankStatement;
  PlatformFile? workmenCompensation;
  PlatformFile? passportOfMD;
  PlatformFile? financeAudi;
  PlatformFile? operationArea;
  PlatformFile? passportOfVendor;

  @override
  void initState() {
    super.initState();



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
          id: 'UploadDocuments',
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
                                          "Upload Documents",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text("Upload your available documents",style: textStyle(true, 16, blackColor),)),

                                  Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text("(The more documents you have the higher your ratings)",style: textStyle(false, 14, blackColor.withOpacity(.5)),)),


                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      companyProfile=_;
                                    });
                                  },title: "Company's corporate profile",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      orgChart=_;
                                    });
                                  },title: "Organization Chart",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      certOfIncorp=_;
                                    });
                                  },title: "Certificate of Incorporation/Registration",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      statementOfShares=_;
                                    });
                                  },title: "Statement of Allotment of Shares form (CO2)",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      memoOfAssot=_;
                                    });
                                  },title: "Memorandum and Article of Association",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      healthPoilcy=_;
                                    });
                                  },title: "Health, Safety and Environmental (HSE) Policies",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      qualityProcedure=_;
                                    });
                                  },title: "Quality Management Procedure",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      taxClearance=_;
                                    });
                                  },title: "Three years tax Clearance Certificate",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      vatCert=_;
                                    });
                                  },title: "VAT Registration Certificate",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      refLetter=_;
                                    });
                                  },title: "Reference Letter from Company's Bank",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      refLetter=_;
                                    });
                                  },title: "Workman's Compensation Insurance (NSITF)",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      passportOfMD=_;
                                    });
                                  },title: "Passport of MD/Rep and directors",),

                                  addSpace(20),

                                  FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      financeAudi=_;
                                    });
                                  },title: "Last three(3) years Audited Financials of Company",),

                                  addSpace(20),

                                 FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      operationArea=_;
                                    });
                                  },title: "Three(3) sided photograph of operational Areas",),

                                  addSpace(20),

                                 FilePickerWidget(onSelected: (_){
                                    setState(() {
                                      passportOfVendor=_;
                                    });
                                  },title: "Passport of vendors and all directors",),

                                  addSpace(20),










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
                        title: "Save",
                        onPressed: () async {
                          Map studs = {};
                          bool proceed = validateInputModels(studs: studs);
                          if (proceed) {



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
                  }),
            );
          }),
    );
  }

  void runSearch(){

  }
}
