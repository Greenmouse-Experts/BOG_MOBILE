import 'package:dart_countries/dart_countries.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/auth_controller.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/page_dropdown.dart';
import '../../global_widgets/page_input.dart';
import '../sign_in/sign_in.dart';
import '../verify_otp/verify_otp.dart';

class SupplierSignUp extends GetView<AuthController> {
  const SupplierSignUp({Key? key}) : super(key: key);

  static const route = '/supplierSignUp';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Image.asset(
            'assets/images/boglogo.png',
            width: Get.width * 0.25,
          ),
          backgroundColor: AppColors.backgroundVariant1,
        ),
        body: GetBuilder<AuthController>(builder: (controller) {
          return Container(
            color: AppColors.backgroundVariant1,
            width: Get.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.04),
                  Padding(
                    padding: const EdgeInsets.only(left: AppThemes.appPaddingVal),
                    child: Text(
                      'Sign Up As A Product Partner',
                      style: AppTextStyle.headline4.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.010,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: AppThemes.appPaddingVal),
                    child: Text(
                      'Sell products to clients online',
                      style: AppTextStyle.headline4.copyWith(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.normal,
                          fontSize: 16
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PageInput(
                                hint: '',
                                label: 'First Name',
                                validator: Validator.fullnameValidation,
                                isCompulsory: true,
                                controller: controller.fName,
                              ),
                              SizedBox(height: Get.height * 0.025),
                              PageInput(
                                hint: '',
                                label: 'Last Name',
                                validator: Validator.fullnameValidation,
                                isCompulsory: true,
                                controller: controller.lName,
                              ),
                              SizedBox(height: Get.height * 0.025),
                              PageInput(
                                hint: '',
                                label: 'Email Address',
                                validator: Validator.emailValidation,
                                isCompulsory: true,
                                controller: controller.email,
                              ),
                              SizedBox(height: Get.height * 0.025),
                              PageInput(
                                hint: '',
                                label: 'Phone Number',
                                validator: Validator.phoneNumValidation,
                                isCompulsory: true,
                                isPhoneNumber: true,
                                controller: controller.phone,
                              ),
                              SizedBox(height: Get.height * 0.025),
                              PageInput(
                                hint: '',
                                label: 'Password',
                                validator: Validator.passwordValidation,
                                isCompulsory: true,
                                obscureText: true,
                                controller: controller.password,
                              ),
                              SizedBox(height: Get.height * 0.025),
                              PageInput(
                                hint: '',
                                label: 'Confirm Password',
                                obscureText: true,
                                validator: (value) {
                                  if (value != controller.password.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                isCompulsory: true,
                                controller: controller.confirmPassword,
                                showInfo: false,
                              ),
                              SizedBox(height: Get.height * 0.025),
                              PageInput(
                                hint: '',
                                label: 'Referral Code (Optional)',
                               // obscureText: true,
                                validator: (value) {
                                  return null;
                                },
                                isCompulsory: false,
                                controller: controller.referral,
                                isReferral: true,
                              ),
                              SizedBox(height: Get.height * 0.025),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Where did you hear about us ?',
                                  style: AppTextStyle.bodyText2.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              PageDropButton(
                                label: "",
                                hint: '',
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                onChanged: (val) {

                                },
                                value:  "Apple App Store",
                                items: ["Apple App Store","Google Play Store","Google         ","Email         ","Facebook         ","Twitter         ","Instagram         ","Whatsapp         "].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: Get.height * 0.025),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      value: controller.isTermsAndConditionsChecked,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                      onChanged: (val){
                                        controller.toggleTermsAndConditions(val == true);
                                      }
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'By creating an account, you agree to BOG’s ',
                                            style: AppTextStyle.headline4.copyWith(
                                              color: Colors.black.withOpacity(.5),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          ),
                                          TextSpan(
                                              text: ' Privacy Policy, Terms and Conditions',
                                              style: AppTextStyle.headline4.copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                              recognizer:  TapGestureRecognizer()..onTap = () {

                                              }
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.025),
                              AppButton(
                                title: 'Sign Up As A Product Partner',
                                onPressed: () async => await controller.signupSupplier(_formKey),
                                borderRadius: 10,
                                enabled: controller.isTermsAndConditionsChecked,
                              ),
                              AppButton(
                                title: 'Already have an account ? ',
                                trailingTitle: "Log In",
                                onPressed: () {
                                  Get.toNamed(SignIn.route);
                                },
                                borderRadius: 10,
                                bckgrndColor: Colors.white,
                                fontColor: Colors.black,
                                bold: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        })
    );
  }
}
