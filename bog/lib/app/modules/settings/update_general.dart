import 'dart:async';
import 'dart:convert';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/general_info_model.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/api.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/app_radio_button.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/new_app_bar.dart';

class UpdateGeneralInfo extends StatefulWidget {
  final Map<String, dynamic> kycScore;
  final Map<String, dynamic> kycTotal;
  const UpdateGeneralInfo(
      {super.key, required this.kycScore, required this.kycTotal});

  @override
  State<UpdateGeneralInfo> createState() => _UpdateGeneralInfoState();
}

class _UpdateGeneralInfoState extends State<UpdateGeneralInfo> {
  late Future<ApiResponse> getGenrealInfo;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameOfOrgController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController typeOfRegController = TextEditingController();
  TextEditingController officeTelController = TextEditingController();
  TextEditingController regNumController = TextEditingController();
  TextEditingController busAddressController = TextEditingController();
  TextEditingController otherAddressController = TextEditingController();
  late String userType;
  String newRegType = '';

  //StreamController<ApiResponse> _formController = StreamController<ApiResponse>();
  @override
  void initState() {
    final controller = Get.find<HomeController>();
    userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    getGenrealInfo = controller.userRepo
        .getData('/kyc-general-info/fetch?userType=$userType');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final options = ['Incorporation', 'Registered Business Name'];

    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    return AppBaseView(
        child: Scaffold(
            appBar: newAppBarBack(context, 'General Info'),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<ApiResponse>(
                    future: getGenrealInfo,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data!.isSuccessful) {
                        if (snapshot.data!.data != null) {
                          final response = snapshot.data!.data;
                          final genData = GeneralInfoModel.fromJson(response);

                          nameOfOrgController.text =
                              genData.organisationName ?? '';
                          emailController.text = genData.emailAddress ?? '';
                          typeOfRegController.text = genData.regType ?? '';
                          officeTelController.text =
                              genData.contactNumber.toString();
                          regNumController.text =
                              genData.registrationNumber.toString();
                          busAddressController.text =
                              genData.businessAddress ?? '';
                          otherAddressController.text =
                              genData.operationalAddress ?? '';
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                PageInput(
                                  hint: '',
                                  label: 'Name of Organization',
                                  validator: MinLengthValidator(3,
                                      errorText:
                                          'Enter a Valid Organization Name'),
                                  controller: nameOfOrgController,
                                ),
                                const SizedBox(height: 10),
                                PageInput(
                                  hint: '',
                                  label: 'Email Address',
                                  controller: emailController,
                                  //    initialValue: orgData.emailAddress,
                                  validator: EmailValidator(
                                      errorText: 'Enter a valid email address'),
                                ),
                                const SizedBox(height: 10),
                                AppRadioButton(
                                  onchanged: (value) {
                                    newRegType = value;
                                  },
                                  option1: 'Incorporation',
                                  options: options,
                                  label: 'Type of Registration',
                                ),
                                const SizedBox(height: 10),
                                PageInput(
                                  hint: '',
                                  label: 'Office Telephone',
                                  controller: officeTelController,
                                  keyboardType: TextInputType.phone,
                                  isPhoneNumber: true,
                                  validator: Validator.phoneNumValidation,
                                ),
                                const SizedBox(height: 10),
                                PageInput(
                                  hint: '',
                                  label: 'Registration Number',
                                  controller: regNumController,
                                  //  initialValue:
                                  //     orgData.registrationNumber.toString(),
                                  keyboardType: TextInputType.number,
                                  validator: MinLengthValidator(1,
                                      errorText:
                                          'Enter a valid registration number'),
                                ),
                                const SizedBox(height: 10),
                                PageInput(
                                  hint: '',
                                  label: 'Business Address',
                                  controller: busAddressController,
                                  //      initialValue: orgData.businessAddress,
                                  validator: MinLengthValidator(6,
                                      errorText: 'Enter a valid address'),
                                ),
                                const SizedBox(height: 10),
                                PageInput(
                                  hint: '',
                                  label: 'Other Significant Address',
                                  controller: otherAddressController,
                                  isTextArea: true,
                                  //    initialValue: orgData.operationalAddress,
                                ),
                                AppButton(
                                  title: 'Submit',
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final newGeneralInfo = {
                                        "organisation_name":
                                            nameOfOrgController.text,
                                        "email_address": emailController.text,
                                        "contact_number":
                                            int.parse(officeTelController.text),
                                        "reg_type": newRegType,
                                        "registration_number":
                                            int.parse(regNumController.text),
                                        "business_address":
                                            busAddressController.text,
                                        "operational_address":
                                            otherAddressController.text,
                                        "id": logInDetails.profile!.id,
                                        "userType": userType
                                      };
                                      print(newGeneralInfo);
                                      final kycScore = widget.kycScore;

                                      kycScore['generalInfo'] = 7;
                                      final controller =
                                          Get.find<HomeController>();
                                      final updateAccount = await controller
                                          .userRepo
                                          .patchData('/user/update-account', {
                                        "kycScore": jsonEncode(kycScore),
                                        "kycTotal": jsonEncode(widget.kycTotal)
                                      });
                                      final res = await HttpClient.post(
                                          '/kyc-general-info/create',
                                          newGeneralInfo);
                                      // final res = await Api().postData(
                                      //     '/kyc-general-info/create/',
                                      //     body: newGeneralInfo);

                                      if (res.isSuccessful &&
                                          updateAccount.isSuccessful) {
                                        MyPref.setOverlay.val = false;
                                        AppOverlay.successOverlay(
                                            message:
                                                'General Info Updated Successfully');
                                      } else {
                                        Get.snackbar('Error',
                                            res.message ?? 'Error Occured',
                                            colorText:
                                                AppColors.backgroundVariant1,
                                            backgroundColor: Colors.red);
                                      }
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return const Center(
                            child: Text('Network Error Occurred'),
                          );
                        }
                        return const AppLoader();
                      }
                    })
              ],

              // SingleChildScrollView(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       FutureBuilder<ApiResponse>(
              //           future: getGenrealInfo,
              //           builder: (context, snapshot) {
              //             if (snapshot.connectionState == ConnectionState.done &&
              //                 snapshot.data!.isSuccessful) {
              //               if (snapshot.data!.data == null) {
              //                 return Padding(
              //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //                   child: Form(
              //                     key: _formKey,
              //                     child: Column(
              //                       children: [
              //                         PageInput(
              //                           hint: '',
              //                           label: 'Name of Organization',
              //                           validator: MinLengthValidator(3,
              //                               errorText:
              //                                   'Enter a Valid Organization Name'),
              //                           controller: nameOfOrgController,
              //                         ),
              //                         const SizedBox(height: 10),
              //                         PageInput(
              //                           hint: '',
              //                           label: 'Email Address',
              //                           controller: emailController,
              //                           //    initialValue: orgData.emailAddress,
              //                           validator: EmailValidator(
              //                               errorText: 'Enter a valid email address'),
              //                         ),
              //                         const SizedBox(height: 10),
              //                         AppRadioButton(
              //                           onchanged: (value) {
              //                             newRegType = value;
              //                           },
              //                           option1: 'Incorporation',
              //                           options: options,
              //                           label: 'Type of Registration',
              //                         ),
              //                         const SizedBox(height: 10),
              //                         PageInput(
              //                           hint: '',
              //                           label: 'Office Telephone',
              //                           controller: officeTelController,
              //                           keyboardType: TextInputType.phone,
              //                           isPhoneNumber: true,
              //                           validator: Validator.phoneNumValidation,
              //                         ),
              //                         const SizedBox(height: 10),
              //                         PageInput(
              //                           hint: '',
              //                           label: 'Registration Number',
              //                           controller: regNumController,
              //                           //  initialValue:
              //                           //     orgData.registrationNumber.toString(),
              //                           keyboardType: TextInputType.number,
              //                           validator: MinLengthValidator(1,
              //                               errorText:
              //                                   'Enter a valid registration number'),
              //                         ),
              //                         const SizedBox(height: 10),
              //                         PageInput(
              //                           hint: '',
              //                           label: 'Business Address',
              //                           controller: busAddressController,
              //                           //      initialValue: orgData.businessAddress,
              //                           validator: MinLengthValidator(6,
              //                               errorText: 'Enter a valid address'),
              //                         ),
              //                         const SizedBox(height: 10),
              //                         PageInput(
              //                           hint: '',
              //                           label: 'Other Significant Address',
              //                           controller: otherAddressController,
              //                           isTextArea: true,
              //                           //    initialValue: orgData.operationalAddress,
              //                         ),
              //                         const SizedBox(height: 15),
              //                         AppButton(
              //                           title: 'Submit',
              //                           onPressed: () async {
              //                             if (_formKey.currentState!.validate()) {
              //                               final newGeneralInfo = {
              //                                 "organisation_name":
              //                                     nameOfOrgController.text,
              //                                 "email_address": emailController.text,
              //                                 "contact_number":
              //                                     int.parse(officeTelController.text),
              //                                 "reg_type": newRegType,
              //                                 "registration_number":
              //                                     int.parse(regNumController.text),
              //                                 "business_address":
              //                                     busAddressController.text,
              //                                 "operational_address":
              //                                     otherAddressController.text,
              //                                 "id": logInDetails.profile!.id,
              //                                 "userType": userType
              //                               };

              //                               final kycScore = widget.kycScore;

              //                               kycScore['generalInfo'] = 7;

              //                               final controller =
              //                                   Get.find<HomeController>();
              //                               final updateAccount = await controller
              //                                   .userRepo
              //                                   .patchData('/user/update-account', {
              //                                 "kycScore": jsonEncode(kycScore),
              //                                 "kycTotal": jsonEncode(widget.kycTotal)
              //                               });
              //                               print('na here');
              //                               final res = await controller.userRepo
              //                                   .postData('/kyc-general-info/create',
              //                                       newGeneralInfo);
              //                               if (res.isSuccessful &&
              //                                   updateAccount.isSuccessful) {
              //                                 MyPref.setOverlay.val = false;
              //                                 AppOverlay.successOverlay(
              //                                     message:
              //                                         'General Info Updated Successfully');
              //                               } else {
              //                                 Get.snackbar('Error',
              //                                     res.message ?? 'Error Occured',
              //                                     colorText:
              //                                         AppColors.backgroundVariant1,
              //                                     backgroundColor: Colors.red);
              //                               }
              //                             }
              //                           },
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 );
              //               }
              //               final response = snapshot.data!.data;
              //               final orgData = GeneralInfoModel.fromJson(response);

              //               nameOfOrgController.text = orgData.organisationName ?? '';
              //               emailController.text = orgData.emailAddress ?? '';
              //               officeTelController.text = orgData.contactNumber.toString();
              //               regNumController.text =
              //                   orgData.registrationNumber.toString();
              //               busAddressController.text = orgData.businessAddress ?? '';
              //               otherAddressController.text =
              //                   orgData.operationalAddress ?? '';

              //               return Padding(
              //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //                 child: Form(
              //                   key: _formKey,
              //                   child: Column(
              //                     children: [
              //                       PageInput(
              //                         hint: '',
              //                         label: 'Name of Organization',
              //                         //    initialValue: orgData.organisationName,
              //                         validator: MinLengthValidator(3,
              //                             errorText: 'Enter a Valid Organization Name'),
              //                         controller: nameOfOrgController,
              //                       ),
              //                       const SizedBox(height: 10),
              //                       PageInput(
              //                         hint: '',
              //                         label: 'Email Address',
              //                         controller: emailController,
              //                         //    initialValue: orgData.emailAddress,
              //                         validator: EmailValidator(
              //                             errorText: 'Enter a valid email address'),
              //                       ),
              //                       const SizedBox(height: 10),
              //                       AppRadioButton(
              //                         onchanged: (value) {
              //                           orgData.regType = value;
              //                         },
              //                         option1: orgData.regType ?? '',
              //                         options: options,
              //                         label: 'Type of Registration',
              //                       ),
              //                       const SizedBox(height: 10),
              //                       PageInput(
              //                           hint: '',
              //                           label: 'Office Telephone',
              //                           controller: officeTelController,
              //                           keyboardType: TextInputType.phone,
              //                           isPhoneNumber: true,
              //                           validator: Validator.phoneNumValidation),
              //                       const SizedBox(height: 10),
              //                       PageInput(
              //                         hint: '',
              //                         label: 'Registration Number',
              //                         controller: regNumController,
              //                         //  initialValue:
              //                         //     orgData.registrationNumber.toString(),
              //                         keyboardType: TextInputType.number,
              //                         validator: MinLengthValidator(1,
              //                             errorText:
              //                                 'Enter a valid registration number'),
              //                       ),
              //                       const SizedBox(height: 10),
              //                       PageInput(
              //                         hint: '',
              //                         label: 'Business Address',
              //                         controller: busAddressController,
              //                         //      initialValue: orgData.businessAddress,
              //                         validator: MinLengthValidator(6,
              //                             errorText: 'Enter a valid address'),
              //                       ),
              //                       const SizedBox(height: 10),
              //                       PageInput(
              //                         hint: '',
              //                         label: 'Other Significant Address',
              //                         controller: otherAddressController,
              //                         isTextArea: true,
              //                         //    initialValue: orgData.operationalAddress,
              //                       ),
              //                       const SizedBox(height: 15),
              //                       AppButton(
              //                         title: 'Submit',
              //                         onPressed: () async {
              //                           if (_formKey.currentState!.validate()) {
              //                             final newGeneralInfo = {
              //                               "organisation_name":
              //                                   nameOfOrgController.text,
              //                               "email_address": emailController.text,
              //                               "contact_number": officeTelController.text,
              //                               "reg_type": orgData.regType,
              //                               "registration_number":
              //                                   int.parse(regNumController.text),
              //                               "business_address":
              //                                   busAddressController.text,
              //                               "operational_address":
              //                                   otherAddressController.text,
              //                               "id": logInDetails.profile!.id,
              //                               "userType": userType
              //                             };
              //                             final kycScore = widget.kycScore;

              //                             kycScore['generalInfo'] = 7;

              //                             final controller = Get.find<HomeController>();
              //                             print(controller.cartLength);

              //                             final updateAccount = await controller
              //                                 .userRepo
              //                                 .patchData('/user/update-account', {
              //                               "kycScore": jsonEncode(kycScore),
              //                               "kycTotal": jsonEncode(widget.kycTotal)
              //                             });
              //                             print('no be here');
              //                             // final res = await HttpClient.post(
              //                             //     '/kyc-general-info/create',
              //                             //     newGeneralInfo);
              //                             final res = await controller.userRepo
              //                                 .postData('/kyc-general-info/create',
              //                                     newGeneralInfo);
              //                             if ((res.isSuccessful) &&
              //                                 updateAccount.isSuccessful) {
              //                               MyPref.setOverlay.val = false;
              //                               AppOverlay.successOverlay(
              //                                   message:
              //                                       'General Info Updated Successfully');
              //                             } else {
              //                               Get.snackbar('Error',
              //                                   res.message ?? 'An error occurred',
              //                                   colorText: AppColors.backgroundVariant1,
              //                                   backgroundColor: Colors.red);
              //                             }
              //                           }
              //                         },
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             } else {
              //               if (snapshot.connectionState == ConnectionState.done) {
              //                 return const Center(
              //                   child: Text('Network Error Occurred'),
              //                 );
              //               }
              //               return const AppLoader();
              //             }
              //           })
              //     ],
              //   ),
              // ),
            )));
  }
}
