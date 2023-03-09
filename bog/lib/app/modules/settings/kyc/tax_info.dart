import 'dart:convert';

import 'package:bog/app/assets/color_assets.dart';
import 'package:bog/app/assets/setup_assets.dart';
import 'package:bog/app/base/base.dart';
import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/app_button.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';


class TaxInfo extends BaseWidget {
  const TaxInfo({Key? key}) : super(key: key);

  static const route = '/TaxInfo';

  @override
  State<TaxInfo> createState() => _TaxInfoState();
}

class _TaxInfoState extends BaseWidgetState<TaxInfo> with InputMixin {


  Map setupData = {};

  @override
  void initState() {
    setup=false;
    super.initState();
  }


  loadItems(){
    // kyc-tax-permits/fetch?userType=vendor
    performApiCall(context, "/kyc-tax-permits/fetch?userType=${currentUser.userType}", (response, error){
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

  setupModels(){
    // "VAT":"ksskksdccd","TIN":"dcdc","relevant_statutory":"dcscs",
    inputModels.add(InputTextFieldModel(
        "VAT Registration Number",
        hint: "Enter your VAT registration number",optional: true,
    prefill: setupData["VAT"]));

    inputModels.add(InputTextFieldModel(
        "Tax Identification Number (TIN)",
        hint: "Enter your tax number",prefill: setupData["TIN"]));

    inputModels.add(InputTextFieldModel(
      "List of relevant statutory bodies registered with",
      hint: "Enter your list",optional: true,prefill: setupData["relevant_statutory"]));
  }

  showAppBar()=>!setup;

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
          id: 'TaxInfo',
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
                                          "Tax Details & Permit",
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
                              padding: const EdgeInsets.fromLTRB(20,0,20,0),
                              child: Column(
                                children: [
                                  InputTextField(inputTextFieldModel: inputModels[0]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[1]),
                                  addSpace(20),
                                  InputTextField(inputTextFieldModel: inputModels[2],maxLine: 4,),
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

                          bool proceed = validateInputModels(studs: studs);
                          if(!proceed)return;

                          String vat_number = inputModels[0].text;
                          String tin_number = inputModels[1].text;
                          String bodies = inputModels[2].text;

                          performApiCall(context, "/kyc-tax-permits/create", (response, error){

                            showSuccessDialog(context, "Tax Details Updated",onOkClicked: (){
                              Navigator.pop(context);
                            });

                          },data: {
                            "VAT": vat_number,
                            "TIN": tin_number,
                            "relevant_statutory": bodies,
                            "userType": currentUser.userType
                          });
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

