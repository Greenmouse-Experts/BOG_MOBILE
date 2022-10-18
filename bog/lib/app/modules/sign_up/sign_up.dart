import 'package:dart_countries/dart_countries.dart';
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

class SignUp extends GetView<AuthController> {
  const SignUp({Key? key}) : super(key: key);

  static const route = '/signUp';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

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
            width: Get.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.025),
                  Padding(
                    padding: const EdgeInsets.only(left: AppThemes.appPaddingVal),
                    child: Text(
                      'Sign Up As A Client',
                      style: AppTextStyle.headline4.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
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
                      'Get access to goods and services online',
                      style: AppTextStyle.headline4.copyWith(
                        color: Colors.black.withOpacity(.5),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04),
                  Padding(
                    padding: const EdgeInsets.only(left: AppThemes.appPaddingVal),
                    child: ToggleSwitch(
                      minWidth: Get.width * 0.4,
                      initialLabelIndex: controller.isCorporate ? 1 : 0,
                      totalSwitches: 2,
                      inactiveBgColor: AppColors.backgroundVariant1,
                      activeBgColor: const [AppColors.primary, AppColors.primary],
                      labels: const ['Private Client', 'Corporate Client'],
                      customTextStyles: [
                        AppTextStyle.bodyText1.copyWith(
                          color: controller.isCorporate ? Color(0xff064A72) : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        AppTextStyle.bodyText1.copyWith(
                          color: controller.isCorporate ? Colors.white : Color(0xff064A72),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                      cornerRadius: 0,
                      onToggle: (index) {
                        controller.toggleBusiness(index!);
                        if (index == 0) {
                          //businessPageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        } else {
                          //personalPageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                      child: SizedBox(
                        height: Get.height ,
                        child: PageView(
                          controller: controller.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            //Business
                            Form(
                              key: _formKey,
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
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please confirm your password';
                                      } else if (val.toString() != controller.password.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                    isCompulsory: true,
                                    obscureText: true,
                                    controller: controller.password,
                                  ),
                                  SizedBox(height: Get.height * 0.050),
                                  AppButton(
                                    title: 'Sign Up',
                                    onPressed: () async => await controller.signupClient(_formKey),
                                    borderRadius: 10,
                                  ),
                                  AppButton(
                                    title:
                                    'Already have a account?  Log In',
                                    onPressed: () {
                                      Get.toNamed(SignIn.route);
                                    },
                                    borderRadius: 10,
                                    bckgrndColor: Colors.white,
                                    fontColor: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                            //Personal
                            Form(
                              key: _formKey1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  PageInput(
                                    hint: '',
                                    label: 'Company Name',
                                    validator: Validator.fullnameValidation,
                                    isCompulsory: true,
                                    controller: controller.companyName,
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
                                    label: 'Create Password',
                                    validator: Validator.passwordValidation,
                                    isCompulsory: true,
                                    obscureText: true,
                                    controller: controller.password,
                                  ),
                                  SizedBox(height: Get.height * 0.025),
                                  PageInput(
                                    hint: '',
                                    label: 'Confirm Password',
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please confirm your password';
                                      } else if (val.toString() != controller.password.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                    isCompulsory: true,
                                    obscureText: true,
                                    controller: controller.password,
                                  ),
                                  SizedBox(height: Get.height * 0.050),
                                  AppButton(
                                    title: 'Sign Up',
                                    onPressed: () async => await controller.signupCorporate(_formKey1),
                                    borderRadius: 10,
                                  ),
                                  AppButton(
                                    title: 'Already have a account?  Log In',
                                    onPressed: () {
                                      Get.toNamed(SignIn.route);
                                    },
                                    borderRadius: 10,
                                    bckgrndColor: Colors.white,
                                    fontColor: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ],
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
