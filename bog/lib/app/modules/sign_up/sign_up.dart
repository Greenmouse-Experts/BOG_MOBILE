import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/auth_controller.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/page_dropdown.dart';
import '../../global_widgets/page_input.dart';
import '../sign_in/sign_in.dart';

class SignUp extends GetView<AuthController> {
  const SignUp({Key? key}) : super(key: key);

  static const route = '/signUp';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

    // final GoogleSignInAccount? user = _currentUser;

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
                        fontSize: 14),
                  ),
                ),
                SizedBox(height: Get.height * 0.04),
                SizedBox(
                  height: Get.height * 0.045,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: AppThemes.appPaddingVal),
                    child: AnimatedToggleSwitch<int>.size(
                      current: controller.isCorporate ? 1 : 0,
                      values: const [0, 1],
                      iconOpacity: 1,
                      indicatorSize: Size.fromWidth(Get.width * 0.4),
                      iconBuilder: (value, size) {
                        return Center(
                          child: Text(
                            value == 0 ? 'Private Client ' : 'Corporate Client',
                            style: AppTextStyle.bodyText1.copyWith(
                              color: controller.index == value
                                  ? Colors.white
                                  : const Color(0xff2F2F2F),
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        );
                      },
                      borderColor: AppColors.backgroundVariant1,
                      colorBuilder: (i) => AppColors.primary,
                      onChanged: (i) => controller.toggleBusiness(i),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                        child: SizedBox(
                          height: Get.height + (Get.height * 0.4),
                          child: PageView(
                            controller: controller.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Please confirm your password';
                                        } else if (val.toString() !=
                                            controller.password.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                      isCompulsory: true,
                                      obscureText: true,
                                      showInfo: false,
                                      controller: controller.confirmPassword,
                                    ),
                                    SizedBox(height: Get.height * 0.025),
                                    PageInput(
                                      hint: '',
                                      label: 'Referral Code (Optional)',
                                      //obscureText: true,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      onChanged: (val) {},
                                      value: "Apple App Store",
                                      items: [
                                        "Apple App Store",
                                        "Google Play Store",
                                        "Google         ",
                                        "Email         ",
                                        "Facebook         ",
                                        "Twitter         ",
                                        "Instagram         ",
                                        "Whatsapp         "
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(height: Get.height * 0.025),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            value: controller
                                                .isTermsAndConditionsChecked,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: const VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            onChanged: (val) {
                                              controller
                                                  .toggleTermsAndConditions(
                                                      val == true);
                                            }),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'By creating an account, you agree to BOG’s ',
                                                  style: AppTextStyle.headline4
                                                      .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(.5),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                TextSpan(
                                                    text:
                                                        ' Privacy Policy, Terms and Conditions',
                                                    style: AppTextStyle
                                                        .headline4
                                                        .copyWith(
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                    ),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {}),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.025),
                                    AppButton(
                                      title: 'Sign Up As A Client',
                                      onPressed: () async => await controller
                                          .signupClient(formKey),
                                      borderRadius: 10,
                                      enabled: controller
                                          .isTermsAndConditionsChecked,
                                    ),
                                    // GoogleUserCircleAvatar(identity: user),
                                    AppButton(
                                      title: 'Sign up with Google',
                                      trailingColor: Colors.pink,
                                      borderRadius: 10,
                                      bckgrndColor:
                                          AppColors.backgroundVariant2,
                                      bold: false,
                                      hasIcon: true,
                                      fontColor: Colors.black,
                                      onPressed: () {
                                        controller.handleSignUpGoogle();
                                      },
                                    ),
                                    AppButton(
                                      title: 'Sign up with Apple',
                                      isGoogle: false,
                                      trailingColor: Colors.pink,
                                      borderRadius: 10,
                                      bckgrndColor: Colors.black,
                                      hasIcon: true,
                                      fontColor: AppColors.background,
                                      onPressed: () {},
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
                              Form(
                                key: formKey1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        } else if (val.toString() !=
                                            controller.password.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                      isCompulsory: true,
                                      obscureText: true,
                                      showInfo: false,
                                      controller: controller.confirmPassword,
                                    ),
                                    SizedBox(height: Get.height * 0.025),
                                    PageInput(
                                      hint: '',
                                      label: 'Referral Code (Optional)',
                                      //obscureText: true,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      onChanged: (val) {},
                                      value: "Apple App Store",
                                      items: [
                                        "Apple App Store",
                                        "Google Play Store",
                                        "Google         ",
                                        "Email         ",
                                        "Facebook         ",
                                        "Twitter         ",
                                        "Instagram         ",
                                        "Whatsapp         "
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(height: Get.height * 0.025),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            value: controller
                                                .isTermsAndConditionsChecked,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: const VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            onChanged: (val) {
                                              controller
                                                  .toggleTermsAndConditions(
                                                      val == true);
                                            }),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'By creating an account, you agree to BOG’s ',
                                                  style: AppTextStyle.headline4
                                                      .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(.5),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                TextSpan(
                                                    text:
                                                        ' Privacy Policy, Terms and Conditions',
                                                    style: AppTextStyle
                                                        .headline4
                                                        .copyWith(
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                    ),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {}),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.025),
                                    SizedBox(height: Get.height * 0.025),
                                    AppButton(
                                      title: 'Sign Up',
                                      onPressed: () async => await controller
                                          .signupCorporate(formKey1),
                                      borderRadius: 10,
                                      enabled: controller
                                          .isTermsAndConditionsChecked,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
