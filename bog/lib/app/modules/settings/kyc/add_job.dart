
import 'package:bog/app/assets/setup_assets.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/modules/settings/kyc/job_experience.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/http_utils.dart';
import 'package:bog/core/utils/input_mixin.dart';
import 'package:bog/core/utils/time_utils.dart';
import 'package:bog/core/utils/widget_util.dart';
import 'package:bog/core/widgets/bottom_nav.dart';
import 'package:bog/core/widgets/click_text.dart';
import 'package:bog/core/widgets/date_picker_widget.dart';
import 'package:bog/core/widgets/file_picker_widget.dart';
import 'package:bog/core/widgets/input_text_field.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
    yearOfExperience = jobModel!=null?jobModel!.years:null;
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
                                  },title: "Upload Provisional Documents (If any)",fileInfo:fileInfo),
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

                            dio.MultipartFile? mtf;
                            if(fileInfo!=null) {
                              try {
                                mtf = await dio.MultipartFile.fromFile(
                                    fileInfo!.path!, filename: fileInfo!.name);
                              }catch(e){}
                            }

                            String name = inputModels[0].text;
                            String value = inputModels[1].text.replaceAll(",", "");
                            String subsidiary = inputModels[2].text;


                            performApiCallWithDIO(context, "/kyc-work-experience/create", (response, error){

                              Navigator.pop(context,JobModel(name: name,
                                  value: double.parse(value),
                                  date: date!, fileInfo: fileInfo!, years: yearOfExperience!,
                                  subsidiary: subsidiary));

                            },data: {
                              "value": value,
                              "name": name,
                              "document":mtf ?? null,
                              "years_of_experience": yearOfExperience,
                              "company_involvement": subsidiary,
                              "date": formatTime3(date!.millisecondsSinceEpoch),
                              "userType": currentUser.userType
                            },withFile:true);



                          }

                        },
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: bottomNav(),
            );
          }),
    );
  }
}
