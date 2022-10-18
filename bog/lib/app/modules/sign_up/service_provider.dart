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
            width: Get.width * 0.25,
          ),
        ),
        body: GetBuilder<AuthController>(builder: (controller) {
          return SizedBox(
            width: Get.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Sign Up As A Service Provider',
                        style: AppTextStyle.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Get.height * 0.02),
                      Column(
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
                            label: 'Password',
                            validator: Validator.passwordValidation,
                            isCompulsory: true,
                            obscureText: true,
                            controller: controller.password,
                          ),
                          SizedBox(height: Get.height * 0.025),
                          PageInput(
                            hint: '',
                            label: 'Office Address',
                            validator: Validator.fullnameValidation,
                            isCompulsory: true,
                            controller: controller.officeAddress,
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
                          SizedBox(height: Get.height * 0.050),
                          AppButton(
                            title: 'Sign Up',
                            onPressed: () async => await controller.signupServiceProvider(_formKey),
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
                    ],
                  ),
                ),
              ),
            ),
          );
        })
    );
  }
}
