import 'dart:convert';

import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_date_picker.dart';
import 'package:bog/app/global_widgets/app_drop_down_button.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/core/utils/validator.dart';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/log_in_model.dart';
import '../../data/model/org_info_model.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_loader.dart';

class UpdateOrganisationInfo extends StatefulWidget {
  final Map<String, dynamic> kycScore;
  final Map<String, dynamic> kycTotal;
  const UpdateOrganisationInfo(
      {super.key, required this.kycScore, required this.kycTotal});

  @override
  State<UpdateOrganisationInfo> createState() => _UpdateOrganisationInfoState();
}

class _UpdateOrganisationInfoState extends State<UpdateOrganisationInfo> {
  late Future<ApiResponse> getOrganizationInfo;
  final _formKey = GlobalKey<FormState>();

  TextEditingController directorsName = TextEditingController();
  TextEditingController directorDesignation = TextEditingController();
  TextEditingController directorPhone = TextEditingController();
  TextEditingController directorEmail = TextEditingController();
  TextEditingController contactPhone = TextEditingController();
  TextEditingController contactEmail = TextEditingController();
  TextEditingController dateOfIncorporation = TextEditingController();
  TextEditingController otherOperations = TextEditingController();
  TextEditingController otherSpecify = TextEditingController();

  late String userType;
  String orgType = '';

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    getOrganizationInfo = controller.userRepo
        .getData('/kyc-organisation-info/fetch?userType=$userType');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final options = [
      'Sole Proprietorship',
      'Partnership',
      'Joint Venture',
      'Limited Liability',
      'Others(Specify)'
    ];

    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    return AppBaseView(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: 'Organisation Info'),
            FutureBuilder<ApiResponse>(
                future: getOrganizationInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data!.isSuccessful) {
                    if (snapshot.data!.data == null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              AppDropDownButton(
                                onChanged: (value) {
                                  orgType = value;
                                },
                                options: options,
                                label: 'Type of organisation',
                              ),
                              const SizedBox(height: 10),
                              AppDatePicker(
                                label: 'Date of Incorporation/Registration',
                                onChanged: (value) {
                                  dateOfIncorporation.text = value;
                                },
                              ),
                              const SizedBox(height: 10),
                              PageInput(
                                hint: '',
                                label: 'Others(Specify)',
                                controller: otherSpecify,
                                validator: (p0) {
                                  if (orgType == 'Others(Specify)') {
                                    return 'Please specify other';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              PageInput(
                                hint: 'Full Name',
                                label: 'Directors Full Name',
                                controller: directorsName,
                                validator: MinLengthValidator(6,
                                    errorText: 'Enter a valid name'),
                              ),
                              const SizedBox(height: 10),
                              PageInput(
                                hint: '',
                                label: 'Directors Designation',
                                controller: directorDesignation,
                                validator: MinLengthValidator(2,
                                    errorText: 'Enter a valid designation'),
                              ),
                              const SizedBox(height: 10),
                              PageInput(
                                  hint: '',
                                  label: 'Directors Phone Number',
                                  keyboardType: TextInputType.phone,
                                  controller: directorPhone,
                                  isPhoneNumber: true,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: Validator.phoneNumValidation),
                              const SizedBox(height: 10),
                              PageInput(
                                hint: '',
                                label: 'Directors Email',
                                keyboardType: TextInputType.emailAddress,
                                controller: directorEmail,
                                validator: EmailValidator(
                                    errorText: 'Enter a valid email'),
                              ),
                              const SizedBox(height: 10),
                              PageInput(
                                hint: '',
                                label: 'Contact Person Phone Number',
                                keyboardType: TextInputType.phone,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: contactPhone,
                                validator: LengthRangeValidator(
                                    min: 10,
                                    max: 10,
                                    errorText: 'Enter a valid phone number'),
                              ),
                              const SizedBox(height: 10),
                              PageInput(
                                hint: '',
                                label: 'Contact Person Email',
                                keyboardType: TextInputType.emailAddress,
                                controller: contactEmail,
                                validator: EmailValidator(
                                    errorText: 'Enter a valid email address'),
                              ),
                              const SizedBox(height: 10),
                              PageInput(
                                hint: '',
                                label: 'Mention Other Companies Operated',
                                isTextArea: true,
                                controller: otherOperations,
                              ),
                              const SizedBox(height: 15),
                              AppButton(
                                title: 'Submit',
                                onPressed: () async {
                                  if (orgType.isEmpty) {
                                    Get.snackbar('Error',
                                        'Select a type of organization',
                                        backgroundColor: Colors.red,
                                        colorText: AppColors.background);
                                    return;
                                  }

                                  if (_formKey.currentState!.validate()) {
                                    final newOrgInfo = {
                                      "organisation_type": orgType,
                                      "others": otherSpecify.text,
                                      "Incorporation_date":
                                          dateOfIncorporation.text,
                                      "director_fullname": directorsName.text,
                                      "director_designation":
                                          directorDesignation.text,
                                      "director_phone": directorPhone.text,
                                      "director_email": directorEmail.text,
                                      "contact_phone": contactPhone.text,
                                      "contact_email": contactEmail.text,
                                      "others_operations": otherOperations.text,
                                      "userType": userType,
                                      "id": logInDetails.profile!.id
                                    };
                                    final kycScore = widget.kycScore;

                                    kycScore['orgInfo'] = 9;

                                    final controller =
                                        Get.find<HomeController>();
                                    final updateAccount = await controller
                                        .userRepo
                                        .patchData('/user/update-account', {
                                      "kycScore": jsonEncode(kycScore),
                                      "kycTotal": jsonEncode(widget.kycTotal)
                                    });
                                    final res = await controller.userRepo
                                        .postData(
                                            '/kyc-organisation-info/create',
                                            newOrgInfo);
                                    if (res.isSuccessful &&
                                        updateAccount.isSuccessful) {
                                      MyPref.setOverlay.val = false;
                                      AppOverlay.successOverlay(
                                          message:
                                              'Organizational Info Updated Successfully');
                                    } else {
                                      Get.snackbar('Error',
                                          res.message ?? 'Error Occured',
                                          colorText:
                                              AppColors.backgroundVariant1,
                                          backgroundColor: Colors.red);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    final response = snapshot.data!.data;
                    final orgData = OrgInfoModel.fromJson(response);

                    directorsName.text = orgData.directorFullname ?? '';
                    directorDesignation.text =
                        orgData.directorDesignation ?? '';
                    directorPhone.text = orgData.directorPhone.toString();
                    directorEmail.text = orgData.directorEmail ?? '';
                    contactPhone.text = orgData.contactPhone.toString();
                    contactEmail.text = orgData.contactEmail ?? '';
                    otherOperations.text = orgData.othersOperations ?? '';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppDropDownButton(
                              onChanged: (value) {
                                orgType = value;
                              },
                              options: options,
                              label: 'Type of organisation',
                            ),
                            const SizedBox(height: 10),
                            AppDatePicker(
                              initialDate: orgData.incorporationDate == null
                                  ? ''
                                  : DateFormat('yyyy-MM-dd')
                                      .format(orgData.incorporationDate!),
                              label: 'Date of Incorporation/Registration',
                              onChanged: (value) {
                                dateOfIncorporation.text = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Others(Specify)',
                              controller: otherSpecify,
                              validator: (p0) {
                                if (orgType == 'Others(Specify)' &&
                                    p0!.isEmpty) {
                                  return 'Please specify other';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: 'Full Name',
                              label: 'Directors Full Name',
                              controller: directorsName,
                              validator: MinLengthValidator(6,
                                  errorText: 'Enter a valid name'),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Directors Designation',
                              controller: directorDesignation,
                              validator: MinLengthValidator(2,
                                  errorText: 'Enter a valid designation'),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                                hint: '',
                                label: 'Directors Phone Number',
                                keyboardType: TextInputType.phone,
                                controller: directorPhone,
                                validator: Validator.phoneNumValidation),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Directors Email',
                              keyboardType: TextInputType.emailAddress,
                              controller: directorEmail,
                              validator: EmailValidator(
                                  errorText: 'Enter a valid email'),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Contact Person Phone Number',
                              keyboardType: TextInputType.phone,
                              controller: contactPhone,
                              validator: LengthRangeValidator(
                                  min: 11,
                                  max: 11,
                                  errorText: 'Enter a valid phone number'),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Contact Person Email',
                              keyboardType: TextInputType.emailAddress,
                              controller: contactEmail,
                              validator: EmailValidator(
                                  errorText: 'Enter a valid email'),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Mention Other Companies Operated',
                              isTextArea: true,
                              controller: otherOperations,
                            ),
                            const SizedBox(height: 15),
                            AppButton(
                              title: 'Submit',
                              onPressed: () async {
                                if (orgType.isEmpty) {
                                  Get.snackbar(
                                      'Error', 'Select a type of organization',
                                      backgroundColor: Colors.red,
                                      colorText: AppColors.background);
                                  return;
                                }

                                if (_formKey.currentState!.validate()) {
                                  final newOrgInfo = {
                                    "organisation_type": orgType,
                                    "others": otherSpecify.text,
                                    "Incorporation_date":
                                        dateOfIncorporation.text,
                                    "director_fullname": directorsName.text,
                                    "director_designation":
                                        directorDesignation.text,
                                    "director_phone": directorPhone.text,
                                    "director_email": directorEmail.text,
                                    "contact_phone": contactPhone.text,
                                    "contact_email": contactEmail.text,
                                    "others_operations": otherOperations.text,
                                    "userType": userType,
                                    "id": logInDetails.profile!.id
                                  };
                                  final kycScore = widget.kycScore;

                                  kycScore['orgInfo'] = 9;
                                  final controller = Get.find<HomeController>();
                                  final updateAccount = await controller
                                      .userRepo
                                      .patchData('/user/update-account', {
                                    "kycScore": jsonEncode(kycScore),
                                    "kycTotal": jsonEncode(widget.kycTotal)
                                  });
                                  final res = await controller.userRepo
                                      .postData('/kyc-organisation-info/create',
                                          newOrgInfo);
                                  if (res.isSuccessful &&
                                      updateAccount.isSuccessful) {
                                    MyPref.setOverlay.val = false;
                                    AppOverlay.successOverlay(
                                        message:
                                            'Organizational Info Updated Successfully');
                                  } else {
                                    Get.snackbar(
                                        'Error', res.message ?? 'Error Occured',
                                        colorText: AppColors.backgroundVariant1,
                                        backgroundColor: Colors.red);
                                  }
                                }
                              },
                            ),
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
        ),
      ),
    ));
  }
}
