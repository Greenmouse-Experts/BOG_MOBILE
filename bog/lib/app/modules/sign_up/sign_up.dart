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
            width: Get.width * 0.25,
          ),
        ),
        body: GetBuilder<AuthController>(builder: (controller) {
          return SizedBox(
            width: Get.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      'Sign Up As A Client',
                      style: AppTextStyle.headline4.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    ToggleSwitch(
                      minWidth: Get.width * 0.4,
                      initialLabelIndex: controller.isCorporate ? 1 : 0,
                      totalSwitches: 2,
                      inactiveBgColor: const Color(0xffbdbdbd).withOpacity(.3),
                      activeBgColor: const [Colors.white, Colors.white],
                      activeBorders: [
                        Border.all(
                          color: const Color(0xffbdbdbd).withOpacity(.3),
                          width: 3.0,
                        ),
                        Border.all(
                          color: const Color(0xffbdbdbd).withOpacity(.3),
                          width: 3.0,
                        ),
                      ],
                      radiusStyle: true,
                      cornerRadius: 10.0,
                      labels: const ['Private Client', 'Corporate Client'],
                      customTextStyles: [
                        AppTextStyle.bodyText1.copyWith(
                          color: const Color(0xff064A72),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        AppTextStyle.bodyText1.copyWith(
                          color: const Color(0xff064A72),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                      onToggle: (index) {
                        controller.toggleBusiness(index!);
                        if (index == 0) {
                          //businessPageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        } else {
                          //personalPageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                        }
                      },
                    ),
                    SizedBox(height: Get.height * 0.03),
                    SizedBox(
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
                                  label: 'Phone Number',
                                  validator: Validator.phoneNumValidation,
                                  isCompulsory: true,
                                  isPhoneNumber: true,
                                  controller: controller.phone,
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
                                  label: 'Password',
                                  validator: Validator.passwordValidation,
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
                                  'Already have a professional account?  Log In',
                                  onPressed: () {
                                    Get.toNamed(SignIn.route);
                                  },
                                  borderRadius: 10,
                                  bckgrndColor: AppColors.background,
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
                                  label: 'Email Address',
                                  validator: Validator.emailValidation,
                                  isCompulsory: true,
                                  controller: controller.email,
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
                                SizedBox(height: Get.height * 0.050),
                                AppButton(
                                  title: 'Sign Up',
                                  onPressed: () async => await controller.signupCorporate(_formKey1),
                                  borderRadius: 10,
                                ),
                                AppButton(
                                  title: 'Already have a professional account?  Log In',
                                  onPressed: () {
                                    Get.toNamed(SignIn.route);
                                  },
                                  borderRadius: 10,
                                  bckgrndColor: AppColors.background,
                                  fontColor: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
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
