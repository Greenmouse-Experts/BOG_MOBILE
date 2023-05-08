import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';

import '../../controllers/auth_controller.dart';
import '../../global_widgets/app_button.dart';

class VerifySignUpOTP extends GetView<AuthController> {
  const VerifySignUpOTP({Key? key}) : super(key: key);

  static const route = '/verifySignUpOTP';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
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
                        SizedBox(height: Get.height * 0.04),
                        Text(
                          'OTP Verification',
                          style: AppTextStyle.headline4.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize:  Get.textScaleFactor * 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: Get.height * 0.010,
                        ),
                        Text(
                          'An OTP has been sent to your email for account verification, please enter it below',
                          style: AppTextStyle.headline4.copyWith(
                              color: Colors.black.withOpacity(.5),
                              fontWeight: FontWeight.normal,
                              fontSize:  Get.textScaleFactor * 16),
                        ),
                        SizedBox(height: Get.height * 0.04),
                        OTPTextField(
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: Get.width * 0.1,
                          style: TextStyle(
                            fontSize:  Get.textScaleFactor * 17,
                            color: Colors.black,
                          ),
                          textFieldAlignment: MainAxisAlignment.spaceBetween,
                          fieldStyle: FieldStyle.box,
                          onCompleted: (pin) {},
                          controller: controller.otpController,
                          obscureText: false,
                          onChanged: (value) {
                            controller.otp.text = value;
                          },
                          otpFieldStyle: OtpFieldStyle(
                            backgroundColor: const Color(0xffE9F3FD),
                            borderColor: const Color(0xff3F79AD),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.04),
                        SizedBox(height: Get.height * 0.03),
                        AppButton(
                          title: 'Verify OTP',
                          onPressed: () async =>
                              controller.verifyOTPForSignUp(),
                          borderRadius: 10,
                        ),
                        AppButton(
                          title: 'Resend Link',
                          trailingTitle: "${controller.time} min",
                          bckgrndColor: Colors.white,
                          fontColor: Colors.black,
                          trailingColor: AppColors.blue,
                          onPressed: () {},
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
      );
    });
  }
}
