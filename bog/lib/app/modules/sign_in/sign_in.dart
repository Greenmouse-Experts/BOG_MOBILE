import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/providers/api.dart';
import '../../global_widgets/global_widgets.dart';
import '../../repository/user_repo.dart';
import '../multiplexor/multiplexor.dart';
import '../sign_up/forgot_password.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/auth_controller.dart';

class SignIn extends GetView<AuthController> {
  const SignIn({Key? key}) : super(key: key);

  static const route = '/signIn';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Get.put(AuthController(UserRepository(Api())));

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
        backgroundColor: AppColors.backgroundVariant1,
      ),
      body: Container(
        color: AppColors.backgroundVariant1,
        width: Get.width,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/boglogo.png',
                width: Get.width,
                height: Get.width * 0.15,
              ),
              SizedBox(height: Get.height * 0.06),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    height: Get.height * 0.76,
                    child: Padding(
                      padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                      child: AutofillGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: AppTextStyle.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: Get.height * 0.010,
                            ),
                            Text(
                              'Get back into your account',
                              style: AppTextStyle.headline4.copyWith(
                                  color: Colors.black.withOpacity(.5),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            ),
                            SizedBox(height: Get.height * 0.035),
                            PageInput(
                              hint: 'Enter your email',
                              label: 'Email Address',
                              autofillHints: const [AutofillHints.email],
                              validator: Validator.emailValidation,
                              isCompulsory: true,
                              controller: controller.email,
                            ),
                            SizedBox(height: Get.height * 0.025),
                            PageInput(
                              hint: '******',
                              label: 'Password',
                              validator: Validator.passwordValidation,
                              isCompulsory: true,
                              autofillHints: const [AutofillHints.password],
                              controller: controller.password,
                              obscureText: true,
                            ),
                            SizedBox(height: Get.height * 0.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(ForgotPassword.route);
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: AppTextStyle.bodyText1.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Get.height * 0.03),
                            AppButton(
                              title: 'Log In',
                              onPressed: () async =>
                                  await controller.signIn(formKey),
                              borderRadius: 10,
                            ),
                            Platform.isAndroid
                                ? AppButton(
                                    isElevated: true,
                                    title: 'Sign in with Google',
                                    trailingColor: Colors.pink,
                                    borderRadius: 10,
                                    bckgrndColor: AppColors.backgroundVariant2,
                                    bold: false,
                                    hasIcon: true,
                                    fontColor: Colors.black,
                                    onPressed: () {
                                      controller.handleSignUpGoogle();
                                    },
                                  )
                                : const SizedBox(),
                            AppButton(
                              title: 'Don\'t have an account? ',
                              trailingTitle: "Sign Up",
                              bckgrndColor: Colors.white,
                              onPressed: () {
                                Get.toNamed(Multiplexor.route);
                              },
                              borderRadius: 10,
                              fontColor: Colors.black,
                              bold: false,
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
        ),
      ),
    );
  }
}
