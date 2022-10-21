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

class ServiceProviderSignUp extends GetView<AuthController> {
  const ServiceProviderSignUp({Key? key}) : super(key: key);

  static const route = '/serviceProviderSignUp';

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
            width: Get.width * 0.23,
          ),
          backgroundColor: AppColors.backgroundVariant1,
        ),
        body: GetBuilder<AuthController>(builder: (controller) {
          return Container(
            color: AppColors.backgroundVariant1,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.025),
                    Padding(
                      padding: const EdgeInsets.only(left: AppThemes.appPaddingVal),
                      child: Text(
                        'Sign Up as Service Provider',
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
                        'Render services to users in need',
                        style: AppTextStyle.headline4.copyWith(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.normal,
                          fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.04),
                    Container(
                      color: Colors.white,
                      height: Get.height*0.84,
                      child: Padding(
                        padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PageInput(
                              hint: '',
                              label: 'Full Name',
                              validator: Validator.fullnameValidation,
                              isCompulsory: true,
                              controller: controller.fullName,
                            ),
                            SizedBox(height: Get.height * 0.025),
                            PageInput(
                              hint: '',
                              label: 'Company Name',
                              validator: Validator.fullnameValidation,
                              isCompulsory: true,
                              controller: controller.companyName,
                            ),
                            SizedBox(height: Get.height * 0.025),
                            /*PageInput(
                              hint: '',
                              label: 'Phone Number',
                              validator: Validator.phoneNumValidation,
                              isCompulsory: true,
                              isPhoneNumber: true,
                              controller: controller.phone,
                            ),
                            SizedBox(height: Get.height * 0.025),*/
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
                              isCompulsory: true,
                              controller: controller.confirmPassword,
                              obscureText: true,
                              validator: (value) {
                                if (value != controller.password.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            /*SizedBox(height: Get.height * 0.025),
                            PageInput(
                              hint: '',
                              label: 'Certificate Of Operation',
                              validator: Validator.fullnameValidation,
                              isCompulsory: true,
                              controller: controller.certOfOperation,
                            ),
                            SizedBox(height: Get.height * 0.025),
                            PageInput(
                              hint: '',
                              label: 'Professional Membership Certificate',
                              validator: Validator.fullnameValidation,
                              isCompulsory: true,
                              controller: controller.proMemCert,
                            ),*/
                            SizedBox(height: Get.height * 0.025),
                            RichText(
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
                            SizedBox(height: Get.height * 0.025),
                            AppButton(
                              title: 'Sign Up As A Service Provider',
                              onPressed: () async => await controller.signupServiceProvider(_formKey),
                              borderRadius: 10,
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
                  ],
                ),
              ),
            ),
          );
        })
    );
  }
}
