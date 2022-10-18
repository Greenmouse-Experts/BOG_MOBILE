import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../multiplexor/multiplexor.dart';
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
                  'Reset Your Password', style: AppTextStyle.headline4.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Text(
                  'Enter the email address associated with your account and we’ll send you a link to reset your password.',
                  style: AppTextStyle.headline4.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
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
                  title: 'Get Reset Email',
                  onPressed: () async => await controller.forgotPassword(_formKey),
                  borderRadius: 10,
                ),
                const SizedBox(height: 30),
                AppButton(
                  title: 'Back To Sign In',
                  bckgrndColor: AppColors.background,
                  fontColor: AppColors.primary,
                  onPressed: () {
                    Get.back();
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
