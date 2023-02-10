import 'dart:convert';

import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/assets/setup_assets.dart';
import 'package:bog/app/base/base.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/modules/settings/kyc/add_job.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/utils/extensions.dart';
import 'package:bog/core/utils/http_utils.dart';
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


class FinancialData extends BaseWidget {
  const FinancialData({Key? key}) : super(key: key);

  static const route = '/FinancialData';

  @override
  State<FinancialData> createState() => _FinancialDataState();
}

class _FinancialDataState extends BaseWidgetState<FinancialData> with InputMixin {

  String bankName = "";
  String bankId = "";
  List bankList = ["Zenith Bank","Access Bank","UBA","Eco Bank"];

  String accountType = "";
  List accountTypes = ["Current Account","Savings Account"];

  Map setupData = {};


  @override
  void initState() {
    setup = false;
    super.initState();

  }

  loadItems(){
    // kyc-tax-permits/fetch?userType=vendor
    performApiCall(context, "/kyc-financial-data/fetch?userType=${currentUser.userType}", (response, error){
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
    // {"id":"0a2e0a20-366d-4ba6-81ea-c4d7570ebb22",
    // "userType":"corporate_client",
    // "userId":"c2f648b5-cd36-4b67-ba25-7fc21dbcce0a","account_name":"Jaka",
    // "account_number":"00983039","bank_name":"","banker_address":"ksks",
    // "account_type":"","overdraft_facility":"jss",
    // "createdAt":"2023-02-09T17:20:48.000Z",
    // "updatedAt":"2023-02-09T17:20:48.000Z","deletedAt":null}

    accountType = setupData["account_type"]??"";
    inputModels.add(InputTextFieldModel(
      "Account Holder Name",
      hint: "Enter account name",
    prefill: setupData["account_name"]
    ));

    inputModels.add(InputTextFieldModel(
      "Account Number",
      hint: "Enter account number",
    prefill: setupData["account_number"]
    ));

    inputModels.add(InputTextFieldModel(
      "Level of Current Overdraft Facility",
      hint: "Enter the level of overdraft facility",
    prefill: setupData["overdraft_facility"]
    ));


    inputModels.add(InputTextFieldModel(
      "Bankers Name",
      hint: "Enter name of banker",
    prefill: setupData["bank_name"]
    ));

    inputModels.add(InputTextFieldModel(
      "Bankers Address",
      hint: "Enter bankers address",
    prefill: setupData["banker_address"]
    ));
  }

  getPageTitle()=>"Financial Data";

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

                          Map studs = {};
                          studs[2] = (){
                            if(accountType.isEmpty){
                              return "Select account type";
                            }
                            return null;
                          };


                          bool proceed = validateInputModels(studs: studs);
                          if(!proceed)return;

                          String accountName = inputModels[0].text;
                          String accountNumber = inputModels[1].text;
                          String overdraft = inputModels[2].text;
                          String bankerName = inputModels[3].text;
                          String bankerAddress = inputModels[4].text;

                          performApiCall(context, "/kyc-financial-data/create", (response, error){

                            showSuccessDialog(context, "Financial Data Updated",onOkClicked: (){
                              Navigator.pop(context);
                            });

                          },data:
                          {
                            "bank_name": bankName,
                            "account_name": accountName,
                            "account_number": accountNumber,
                            "account_type": accountType,
                            "overdraft_facility": overdraft,
                            "banker_name": bankerName,
                            "banker_address": bankerAddress,
                            // "id": "1a310e9c-7580-485d-aab2-ea8686bb869a",
                            "userType": currentUser.userType,
                            "userId": currentUser.id,
                          }
                         );
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

