import 'dart:convert';

import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/base/base.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/extensions.dart';
import 'package:bog/core/utils/http_utils.dart';
import 'package:bog/core/utils/input_mixin.dart';
import 'package:bog/core/utils/time_utils.dart';
import 'package:bog/core/utils/widget_util.dart';
import 'package:bog/core/widgets/bottom_nav.dart';
import 'package:bog/core/widgets/click_text.dart';
import 'package:bog/core/widgets/custom_expandable.dart';
import 'package:bog/core/widgets/date_picker_widget.dart';
import 'package:bog/core/widgets/input_text_field.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';


class OrgInfo extends BaseWidget {
  const OrgInfo({Key? key}) : super(key: key);

  static const route = '/OrgInfo';

  @override
  State<OrgInfo> createState() => _OrgInfoState();
}

class _OrgInfoState extends BaseWidgetState<OrgInfo> with InputMixin {

  String businessType = "";

  List businessTypes = ["Incorporation", "Registered Business name"];

  DateTime? dateOfInc;

  // showAppBar()=>!setup;

  getPageTitle()=>"Organization Details";

  @override
  void initState() {
    setup=false;
    super.initState();
  }

  Map setupData = {};
  @override
  loadItems() {
    performApiCall(context, "/kyc-organisation-info/fetch?userType=${currentUser.userType}", (response, error){
      if(error!=null){
        setupError=error;
        if(mounted)setState(() {});
        return;
      }

      setupData = response["data"]??{};
      setupModels();
      setup=true;
      if(mounted)setState(() {});

    },getMethod: true,handleError: false,silently: true);
  }

  void setupModels(){

    // businessType = ;

    inputModels.add(InputTextFieldModel(
        "Others (Specify)",
        hint: "Enter the type of organization",optional: true,
    prefill: setupData["others"]));

    String date = setupData["Incorporation_date"]??"";
    if(date.isNotEmpty){
      dateOfInc = DateTime.parse(date);
      // print("The $date ${dateOfInc!.millisecondsSinceEpoch}");
    }

    inputModels.add(InputTextFieldModel(
        "Full Name",
        hint: "Enter directors full name",
    prefill: setupData["director_fullname"]));

    inputModels.add(InputTextFieldModel(
        "Designation",
        hint: "Enter designation",prefill: setupData["director_designation"]));

    inputModels.add(InputTextFieldModel(
        "Phone Number",
        hint: "Enter directors phone number",prefill: setupData["director_phone"]));

    inputModels.add(InputTextFieldModel(
        "Email",
        hint: "Enter directors email",prefill: setupData["director_email"]));

    inputModels.add(InputTextFieldModel(
        "Phone Number",
        hint: "Enter your phone number",prefill: setupData["contact_phone"]));

    inputModels.add(InputTextFieldModel(
        "Email",
        hint: "Enter email",prefill: setupData["contact_email"]));

    inputModels.add(InputTextFieldModel(
        "Please mention other companies operated",
        hint: "Enter other companies operated",prefill: setupData["others_operations"]));
    setState(() {

    });
  }

  @override
  Widget page(BuildContext context) {
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
          id: 'OrgInfo',
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
                            if(false)Padding(
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
                                          "Organization Details",
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

                                  CustomExpandable("Select the type of organization",const {
                                    "Individual":"0",
                                    "Corporate":"0",
                                  },(_){
                                    setState(() {
                                      businessType=_;
                                    });
                                  }),

                                  addSpace(20),

                                  InputTextField(inputTextFieldModel: inputModels[0]),

                                  addSpace(20),

                                  Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text("Date of Incorporation",style: textStyle(false, 14, blackColor),)),

                                  DatePickerWidget((date){
                                    dateOfInc = date;
                                    // print(formatTime3(dateOfInc!.millisecondsSinceEpoch));
                                    setState(() {});
                                  },hint: "yyyy-mm-dd",date: dateOfInc),



                                ],
                              ),
                            ),


                            addSpace(20),
                            Container(
                              width: double.infinity,
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                color: blue0.withOpacity(.2),
                                child: Text("Director Details",style: textStyle(true, 14, blackColor),)),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,20,0),
                              child: Column(
                                children: [
                                  InputTextField(inputTextFieldModel: inputModels[1]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[2]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[3]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[4]),
                                ],
                              ),
                            ),

                           addSpace(20),
                            Container(
                              width: double.infinity,
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                color: blue0.withOpacity(.2),
                                child: Text("Contact Person",style: textStyle(true, 14, blackColor),)),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,20,0),
                              child: Column(
                                children: [
                                  InputTextField(inputTextFieldModel: inputModels[5]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[6]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[7],maxLine: 4,),
                                  addSpace(20),

                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                      child: AppButton(
                        title: "Save",
                        onPressed: () async {
                          Map studs = {};
                          studs[0] = (){
                            if(businessType.isEmpty){
                              return "Select organization type";
                            }
                            return null;
                          };
                          studs[2] = (){
                            if(dateOfInc==null){
                              return "Select date of incorporation";
                            }
                            return null;
                          };

                          bool proceed = validateInputModels(studs: studs);
                          if(!proceed)return;

                          String others = inputModels[0].text;
                          String date = formatTime3(dateOfInc!.millisecondsSinceEpoch);
                          String directors = inputModels[1].text;
                          String designation = inputModels[2].text;
                          String director_phone = inputModels[3].text;
                          String director_email = inputModels[4].text;
                          String contact_phone = inputModels[5].text;
                          String contact_email = inputModels[6].text;
                          String mention = inputModels[7].text;
                          String currentType = currentUser.userType??"";

                          performApiCall(context, "/kyc-organisation-info/create", (response, error){

                            showSuccessDialog(context, "Organization Info Updated",onOkClicked: (){
                              Navigator.pop(context);
                            });

                          },data:
                          {
                            "organisation_type": businessType,
                            "others": others,
                            "Incorporation_date": date,
                            "director_fullname": directors,
                            "director_designation": designation,
                            "director_phone": director_phone,
                            "director_email": director_email,
                            "contact_phone": contact_phone,
                            "contact_email": contact_email,
                            "others_operations": "",
                            "userType": currentType,
                            "id": setupData["id"]??"" // incase of update
                          }
                        );
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

