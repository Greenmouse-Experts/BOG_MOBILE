
import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/base/base.dart';
import 'package:bog/app/blocs/homeswitch_controller.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/data/model/log_in_model.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/http_utils.dart';
import 'package:bog/core/utils/input_mixin.dart';
import 'package:bog/core/utils/widget_util.dart';
import 'package:bog/core/widgets/bottom_nav.dart';
import 'package:bog/core/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class GeneralInfo extends BaseWidget {
  const GeneralInfo({Key? key}) : super(key: key);

  static const route = '/GeneralInfo';

  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}

class _GeneralInfoState extends BaseWidgetState<GeneralInfo> with InputMixin {

  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController regNoController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController moreAddressController = TextEditingController();
  //
  // FocusNode focusName = FocusNode();
  // FocusNode focusEmail = FocusNode();
  // FocusNode focusPhone = FocusNode();
  // FocusNode focusRegNo = FocusNode();
  // FocusNode focusAddress = FocusNode();
  // FocusNode focusMoreAddress = FocusNode();
  String businessType = "";

  List businessTypes = ["Incorporation", "Registered Business name"];


  @override
  void initState() {
    setup=false;
    super.initState();
  }

  Map setupData = {};
  @override
  loadItems() {
     performApiCall(context, "/kyc-general-info/fetch?userType=${currentUser.userType}", (response, error){
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
    inputModels.add(InputTextFieldModel(
        "Name of Organization", hint: "Enter name of organization",
        prefill: setupData["organisation_name"]??""));
    inputModels.add(
        InputTextFieldModel("Email Address", hint: "Enter your email address",
        prefill: setupData["email_address"]??""));
    inputModels.add(InputTextFieldModel(
        "Office Telephone/ Contact Number", hint: "Enter contact number",
    prefill: setupData["contact_number"]??""));
    inputModels.add(InputTextFieldModel("Incorporation/Registration Number",
        hint: "Enter incorporation/registration number",prefill: setupData["registration_number"]??""));
    inputModels.add(InputTextFieldModel(
        "Business Address", hint: "Enter your business address",prefill: setupData["business_address"]??""));
    inputModels.add(InputTextFieldModel("Address of any other operational base",
        hint: "Enter address of other base",prefill: setupData["operational_address"]??""));

    businessType = setupData["reg_type"]??"";
    setState(() {

    });
  }

  // showAppBar()=>!setup;

  getPageTitle()=>"General Information";

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
          id: 'GeneralInfo',
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
                                          "General Information",
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

                                  // inputModelWidgets(0,end: 3),

                                  InputTextField(inputTextFieldModel: inputModels[0]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[1]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[2]),
                                  addSpace(20),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text("Type of Organization",style: textStyle(false, 14, blackColor),)),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                          businessTypes.length, (index) {
                                        String name = businessTypes[index];
                                        bool selected = businessType.trim().toLowerCase() == name.trim().toLowerCase();
                                        return GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              businessType=name;
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
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[3]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[4],maxLine: 4,),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[5],maxLine: 4,),
                                  addSpace(20),

                                  // inputModelWidgets(3),
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
                          // print(businessType);
                          // print(businessTypes[1].toString().trim().toLowerCase()==businessType.trim().toLowerCase());
                          // return;
                          Map studs = {};
                          studs[3] = (){
                            if(businessType.isEmpty){
                              return "Select business type";
                            }
                            return null;
                          };
                          bool proceed = validateInputModels(studs: studs);
                          if(!proceed)return;

                          // HomeSwitchController.instance.refreshUser(context);
                          // return;
                          String currentType = currentUser.userType??"";

                          String org_name = inputModels[0].text;
                          String email_address = inputModels[1].text;
                          String phone = inputModels[2].text;
                          String reg_number = inputModels[3].text;
                          String business_address = inputModels[4].text;
                          String other_address = inputModels[5].text;

                          performApiCall(context, "/kyc-general-info/create", (response, error){
                            
                            showSuccessDialog(context, "General Info Updated",onOkClicked: (){
                              Navigator.pop(context);
                            });
                            
                          },data: {
                            "organisation_name": org_name,
                            "email_address": email_address,
                            "contact_number": phone,
                            "reg_type": businessType,
                            "registration_number": reg_number,
                            "business_address": business_address,
                            "operational_address": other_address,
                            "id": setupData["id"]??"",
                            "userType": currentType
                          });
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

