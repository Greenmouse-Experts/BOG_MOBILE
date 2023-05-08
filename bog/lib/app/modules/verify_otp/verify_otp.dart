import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../sign_in/sign_in.dart';

import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import '../../controllers/auth_controller.dart';
import '../../global_widgets/app_button.dart';

class VerifyOTP extends GetView<AuthController> {
  const VerifyOTP({Key? key}) : super(key: key);

  static const route = '/verifyOTP';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppThemes.appPaddingVal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
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
                  height: Get.width * 0.4,
                ),
                SizedBox(height: Get.height * 0.07),
                Text(
                  'OTP Verification',
                  style: AppTextStyle.headline4.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * 0.035),
                Text(
                  'A verification code has been sent to your email',
                  style: AppTextStyle.headline4.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: Get.width * 0.1,
                  style:  TextStyle(fontSize:  Get.textScaleFactor * 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {},
                ),
                SizedBox(height: Get.height * 0.03),
                AppButton(
                  title: 'Did not get OTP?',
                  bckgrndColor: AppColors.background,
                  fontColor: AppColors.primary,
                  onPressed: () {
                    //Get.toNamed(SignIn.route);
                  },
                  borderRadius: 10,
                ),
                SizedBox(height: Get.height * 0.07),
                AppButton(
                  title: 'Submit',
                  onPressed: () {
                    // Get.toNamed(UpdateProfile.route);
                    //Get.toNamed(SignUp.route);
                    //Get.toNamed(CreatePIN.route);
                  },
                  borderRadius: 10,
                ),
                const SizedBox(height: 30),
                AppButton(
                  title: 'Already have a account?  Log In',
                  bckgrndColor: AppColors.background,
                  fontColor: AppColors.primary,
                  onPressed: () {
                    Get.toNamed(SignIn.route);
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
