import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/auth_controller.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/page_input.dart';

class ForgotPassword extends GetView<AuthController> {
  const ForgotPassword({Key? key}) : super(key: key);

  static const route = '/forgotPassword';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        child: SingleChildScrollView(
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
                Container(
                  color: Colors.white,
                  height: Get.height * 0.76,
                  child: Padding(
                    padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reset Your Password',
                          style: AppTextStyle.headline4.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          'Enter your email address and we’ll send a link to reset your password ',
                          style: AppTextStyle.headline4.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.05),
                        PageInput(
                          hint: '',
                          label: 'Email Address',
                          validator: Validator.emailValidation,
                          isCompulsory: true,
                          controller: controller.email,
                        ),
                        SizedBox(height: Get.height * 0.025),
                        SizedBox(height: Get.height * 0.03),
                        AppButton(
                          title: 'Send Reset Link',
                          onPressed: () async =>
                              await controller.forgotPassword(formKey),
                          borderRadius: 10,
                        ),
                        AppButton(
                          title: '',
                          trailingTitle: 'Back To Log In',
                          bckgrndColor: Colors.white,
                          fontColor: AppColors.primary,
                          onPressed: () {
                            Get.back();
                          },
                          borderRadius: 10,
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
      ),
    );
  }
}
