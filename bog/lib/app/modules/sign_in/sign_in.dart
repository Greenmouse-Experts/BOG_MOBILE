import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../multiplexor/multiplexor.dart';
import '../sign_up/forgot_password.dart';
import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/auth_controller.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/page_input.dart';

class SignIn extends GetView<AuthController> {
  const SignIn({Key? key}) : super(key: key);

  static const route = '/signIn';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return  Scaffold(
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
          'assets/images/boglogo.png', width: Get.width * 0.25,
          color: AppColors.background,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppThemes.appPaddingVal),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/wayagram2.svg',
                  color: AppColors.background,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Image.asset(
                  'assets/images/boglogo.png',
                  width: Get.width * 0.4,
                  height: Get.width * 0.3,
                ),
                Text(
                  'Log In To Your Account',
                  style: AppTextStyle.headline4.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * 0.035),
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
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Get.height * 0.03),
                AppButton(
                  title: 'Log In',
                  onPressed: () async => await controller.signIn(_formKey),
                  borderRadius: 10,
                ),
                const SizedBox(height: 30),
                AppButton(
                  title: 'Don\'t have an account? Sign Up',
                  bckgrndColor: AppColors.background,
                  fontColor: AppColors.primary,
                  onPressed: () {
                    Get.toNamed(Multiplexor.route);
                  },
                  borderRadius: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
