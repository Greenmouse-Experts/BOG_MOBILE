import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/service_type_model.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/page_dropdown.dart';
import '../../global_widgets/page_input.dart';
import '../sign_in/sign_in.dart';

class ServiceProviderSignUp extends StatefulWidget {
  const ServiceProviderSignUp({Key? key}) : super(key: key);

  static const route = '/serviceProviderSignUp';

  @override
  State<ServiceProviderSignUp> createState() => _ServiceProviderSignUpState();
}

class _ServiceProviderSignUpState extends State<ServiceProviderSignUp> {
  late Future<ApiResponse> getServiceTypes;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    getServiceTypes = controller.userRepo.getData('/service/type');
    super.initState();
  }

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
          title: Image.asset(
            'assets/images/boglogo.png',
            width: Get.width * 0.23,
          ),
          backgroundColor: AppColors.backgroundVariant1,
        ),
        body: GetBuilder<AuthController>(builder: (controller) {
          return FutureBuilder<ApiResponse>(
              future: getServiceTypes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.data!.isSuccessful) {
                    final response = snapshot.data!.data as List<dynamic>;
                    final serviceTypes = <ServiceTypeModel>[];
                    for (var element in response) {
                      serviceTypes.add(ServiceTypeModel.fromJson(element));
                    }

                    return Container(
                      color: AppColors.backgroundVariant1,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Get.height * 0.025),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppThemes.appPaddingVal),
                              child: Text(
                                'Sign Up as Service Partner',
                                style: AppTextStyle.headline4.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.010,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppThemes.appPaddingVal),
                              child: Text(
                                'Render services to users in need',
                                style: AppTextStyle.headline4.copyWith(
                                    color: Colors.black.withOpacity(.5),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.04),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  color: Colors.white,
                                  //height: Get.height+(Get.height * 0.15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        AppThemes.appPaddingVal),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PageInput(
                                          hint: 'Enter your first name',
                                          label: 'First Name',
                                          validator:
                                              Validator.fullnameValidation,
                                          isCompulsory: true,
                                          controller: controller.fName,
                                        ),
                                        SizedBox(height: Get.height * 0.025),
                                        PageInput(
                                          hint: 'Enter your last name',
                                          label: 'Last Name',
                                          validator:
                                              Validator.fullnameValidation,
                                          isCompulsory: true,
                                          controller: controller.lName,
                                        ),
                                        SizedBox(height: Get.height * 0.025),
                                        PageInput(
                                          hint: 'Enter your companys name',
                                          label: 'Company Name',
                                          validator:
                                              Validator.fullnameValidation,
                                          isCompulsory: true,
                                          controller: controller.companyName,
                                        ),
                                        SizedBox(height: Get.height * 0.025),
                                        PageInput(
                                          hint: 'Enter your phone number',
                                          label: 'Phone Number',
                                          validator:
                                              Validator.phoneNumValidation,
                                          onPhoneChanged: (val) {
                                            controller.secondPhone.text =
                                                val.completeNumber;
                                          },
                                          isCompulsory: true,
                                          isPhoneNumber: true,
                                          keyboardType: TextInputType.phone,
                                          controller: controller.phone,
                                        ),
                                        SizedBox(height: Get.height * 0.025),
                                        PageInput(
                                          hint: 'Enter your email address',
                                          label: 'Email Address',
                                          validator: Validator.emailValidation,
                                          isCompulsory: true,
                                          controller: controller.email,
                                        ),
                                        if (serviceTypes.isNotEmpty)
                                          SizedBox(height: Get.height * 0.025),
                                        if (serviceTypes.isNotEmpty)
                                          PageDropButton(
                                            label: 'Select Service Rendered',
                                            hint: 'Service Rendered',
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            onChanged: (val) {
                                              final newService =
                                                  val as ServiceTypeModel;

                                              controller.serviceSelected.text =
                                                  newService.id!;
                                            },
                                            validator: (p0) {
                                              if (controller.serviceSelected
                                                  .text.isEmpty) {
                                                return 'Select a service';
                                              }
                                              return null;
                                            },
                                            value: serviceTypes.first,
                                            items: serviceTypes.map<
                                                    DropdownMenuItem<
                                                        ServiceTypeModel>>(
                                                (ServiceTypeModel value) {
                                              return DropdownMenuItem<
                                                  ServiceTypeModel>(
                                                value: value,
                                                child: Text(
                                                    value.title.toString()),
                                              );
                                            }).toList(),
                                          ),
                                        SizedBox(height: Get.height * 0.025),
                                        PageInput(
                                          hint: 'Enter a strong password',
                                          label: 'Password',
                                          validator:
                                              Validator.passwordValidation,
                                          isCompulsory: true,
                                          obscureText: true,
                                          controller: controller.password,
                                        ),
                                        SizedBox(height: Get.height * 0.025),
                                        PageInput(
                                          hint: 'Confirm your password',
                                          label: 'Confirm Password',
                                          isCompulsory: true,
                                          controller:
                                              controller.confirmPassword,
                                          obscureText: true,
                                          showInfo: false,
                                          validator: (value) {
                                            if (value !=
                                                controller.password.text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
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
                                        SizedBox(height: Get.height * 0.025),
                                        PageInput(
                                          hint: 'Enter your referrers code',
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
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Where did you hear about us ?',
                                            style:
                                                AppTextStyle.bodyText2.copyWith(
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
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: -4,
                                                        vertical: -4),
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
                                                      style: AppTextStyle
                                                          .headline4
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
                                                          color:
                                                              AppColors.primary,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                        ),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap =
                                                                  () async {
                                                                if (await canLaunchUrl(
                                                                    Uri.parse(
                                                                        'https://buildonthego.com/terms'))) {
                                                                  await launchUrl(
                                                                      Uri.parse(
                                                                          'https://buildonthego.com/terms'));
                                                                } else {
                                                                  throw 'Could not launch url';
                                                                }
                                                              }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Get.height * 0.025),
                                        AppButton(
                                          title: 'Sign Up As A Service Partner',
                                          onPressed: () async =>
                                              await controller
                                                  .signupServiceProvider(
                                                      formKey),
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child:
                          Text('An error occurred, ${snapshot.data!.message}'),
                    );
                  }
                }
              });
        }));
  }
}
