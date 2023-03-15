import 'dart:io';

import 'package:bog/app/global_widgets/global_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/providers/api.dart';

import '../../../global_widgets/page_dropdown.dart';

import 'package:dio/dio.dart' as dio;

class BuildingApproval extends StatefulWidget {
  const BuildingApproval({Key? key}) : super(key: key);

  @override
  State<BuildingApproval> createState() => _BuildingApprovalState();
}

class _BuildingApprovalState extends State<BuildingApproval> {
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var drawingController = TextEditingController(text: 'Architectural');
  var typeController = TextEditingController(text: 'Residential');
  var surveyController = TextEditingController();
  var architecturalController = TextEditingController();
  var structuralController = TextEditingController();
  var mechanicalController = TextEditingController();
  var electricalController = TextEditingController();
  var soilTestController = TextEditingController();
  var sitePlanController = TextEditingController();
  var deedController = TextEditingController();
  var siteAnalysisController = TextEditingController();
  var environmentalController = TextEditingController();
  var taxController = TextEditingController();
  var corenController = TextEditingController();
  var stampedController = TextEditingController();

  File? surveyPlan;
  File? structuralPlan;
  File? architecturalPlan;
  File? mechanicalPlan;
  File? electricalPlan;
  File? soilTestPlan;
  File? sitePlan;
  File? deedPlan;
  File? siteAnalysisPlan;
  File? environmentalPlan;
  File? taxPlan;
  File? corenPlan;
  File? stampedPlan;

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
          id: 'BuildingApproval',
          builder: (controller) {
            //
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
                        height: Get.height,
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
                                      "Request for Building Approval",
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
                                    child: PageDropButton(
                                      label: "Purpose of building",
                                      hint: '',
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      onChanged: (val) {
                                        typeController.text = val;
                                      },
                                      value: "Residential",
                                      items: [
                                        "Residential",
                                        "Commercial",
                                        "Industrial",
                                        "Religious",
                                        "Educational",
                                        "Recreational",
                                        "Other"
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
                                      title: "Proceed to upload plans",
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          pageController.animateToPage(1,
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
                                      "Request for Building Approval",
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
                                              label: "Upload survey plan",
                                              isFilePicker: true,
                                              controller: surveyController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload survey plan";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                surveyPlan = file;
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
                                              hint: "Enter your name  ",
                                              label:
                                                  "Upload architectural plan",
                                              isFilePicker: true,
                                              controller:
                                                  architecturalController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload architectural plan";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                architecturalPlan = file;
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
                                              hint: "Enter your name  ",
                                              label: "Upload mechanical plan",
                                              isFilePicker: true,
                                              controller: mechanicalController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload mechanical plan";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                mechanicalPlan = file;
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
                                              hint: "Enter your name  ",
                                              label: "Upload electric plan",
                                              isFilePicker: true,
                                              controller: electricalController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload electric plan";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                electricalPlan = file;
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
                                              hint: "Enter your name  ",
                                              label: "Upload soil test report",
                                              isFilePicker: true,
                                              controller: soilTestController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload soil test report";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                soilTestPlan = file;
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
                                              hint: "Enter your name  ",
                                              label: "Upload site plan",
                                              isFilePicker: true,
                                              controller: sitePlanController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload site plan";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                sitePlan = file;
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
                                              hint: "Enter your name  ",
                                              label: "Upload structural plan",
                                              isFilePicker: true,
                                              controller: structuralController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload structural plan";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                structuralPlan = file;
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
                                            child: AppButton(
                                              title:
                                                  "Proceed to upload other documents",
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  pageController.animateToPage(
                                                      2,
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
                                      "Request for Building Approval",
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
                                                  "Upload C of O Deed of Agreement/ R of O",
                                              isFilePicker: true,
                                              controller: deedController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload C of O Deed of Agreement/ R of O";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                deedPlan = file;
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
                                              hint: "Enter your name  ",
                                              label:
                                                  "Upload site analysis report",
                                              isFilePicker: true,
                                              controller:
                                                  siteAnalysisController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload site analysis report";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                siteAnalysisPlan = file;
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
                                              hint: "Enter your name  ",
                                              label:
                                                  "Upload environmental impact \nassessment report",
                                              isFilePicker: true,
                                              controller:
                                                  environmentalController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload environmental impact assessment report";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                environmentalPlan = file;
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
                                              hint: "Enter your name  ",
                                              label:
                                                  "Upload tax clearance certificate",
                                              isFilePicker: true,
                                              controller: taxController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload tax clearance certificate";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                taxPlan = file;
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
                                              hint: "Enter your name  ",
                                              label:
                                                  "Upload letter of supervision from \nCOREN registered engineers",
                                              isFilePicker: true,
                                              controller: corenController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload letter of supervision from COREN registered engineers";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                corenPlan = file;
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
                                              hint: "Enter your name  ",
                                              label:
                                                  "Upload stamped and sealed copy of \nstructural calculation sheet",
                                              isFilePicker: true,
                                              controller: stampedController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please upload stamped and sealed copy of structural calculation sheet";
                                                }
                                                return null;
                                              },
                                              onFilePicked: (file) {
                                                stampedPlan = file;
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
                                            child: AppButton(
                                              title: "Submit",
                                              onPressed: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  Map<String, dynamic> body = {
                                                    'title': title,
                                                    'clientName':
                                                        nameController.text,
                                                    'projectLocation':
                                                        locationController.text,
                                                    "purpose":
                                                        typeController.text,
                                                  };
                                                  body['surveyPlan'] = await dio
                                                      .MultipartFile.fromFile(
                                                    surveyPlan!.path,
                                                    filename: surveyPlan!.path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['structuralPlan'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    structuralPlan!.path,
                                                    filename: structuralPlan!
                                                        .path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['architecturalPlan'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    architecturalPlan!.path,
                                                    filename: architecturalPlan!
                                                        .path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['mechanicalPlan'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    mechanicalPlan!.path,
                                                    filename: mechanicalPlan!
                                                        .path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['electricalPlan'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    electricalPlan!.path,
                                                    filename: electricalPlan!
                                                        .path
                                                        .split('/')
                                                        .last,
                                                  );

                                                  body['soilTestReport'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    soilTestPlan!.path,
                                                    filename: soilTestPlan!.path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['sitePlan'] = await dio
                                                      .MultipartFile.fromFile(
                                                    sitePlan!.path,
                                                    filename: sitePlan!.path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['siteAnalysisReport'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    siteAnalysisPlan!.path,
                                                    filename: siteAnalysisPlan!
                                                        .path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['environmentImpactReport'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    environmentalPlan!.path,
                                                    filename: environmentalPlan!
                                                        .path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['clearanceCertificate'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    taxPlan!.path,
                                                    filename: taxPlan!.path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['structuralCalculationSheet'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    structuralPlan!.path,
                                                    filename: structuralPlan!
                                                        .path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['deedOfAgreement'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    deedPlan!.path,
                                                    filename: deedPlan!.path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  body['supervisorLetter'] =
                                                      await dio.MultipartFile
                                                          .fromFile(
                                                    corenPlan!.path,
                                                    filename: corenPlan!.path
                                                        .split('/')
                                                        .last,
                                                  );
                                                  var formData =
                                                      dio.FormData.fromMap(
                                                          body);
                                                  var response = await Api()
                                                      .postData(
                                                          "/projects/building-approval/request",
                                                          body: formData,
                                                          hasHeader: true);
                                                  if (response.isSuccessful) {
                                                    pageController.animateToPage(
                                                        3,
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
                                        "Your project has been created. You would be notified when you get a Service Partner.  ",
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
                                      controller.update(['home']);
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
                    controller.updateNewUser(controller.currentType);
                    Get.back();
                    Get.back();
                  }),
            );
          }),
    );
  }
}
