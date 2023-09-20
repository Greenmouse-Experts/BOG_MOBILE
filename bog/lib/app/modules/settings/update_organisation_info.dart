import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validator.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/general_info_model.dart';
import '../../data/model/log_in_model.dart';
import '../../data/model/org_info_model.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_date_picker.dart';
import '../../global_widgets/app_drop_down_button.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/new_app_bar.dart';

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
  late Future<ApiResponse> getGenrealInfo;
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
  TextEditingController complexity = TextEditingController();
  TextEditingController costOfProject = TextEditingController();
  TextEditingController noOfStaff = TextEditingController();
  late TextEditingController roleCoontroller;

  late String userType;
  String orgType = '';

  final List<String> numberOfStaff = [
    "1-10",
    "11-50",
    "51-100",
    "101-200",
    "Over 200"
  ];

  final List<String> costOfProjects = [
    "Less than 50 million",
    "50-100 million",
    "200-500 million",
    "Over 500 million"
  ];

  final List<String> complexityOfProjects = [
    "<2 Storey",
    "2 - 5 Storey",
    "5 - 10 Storey",
    "Over 10 Storey",
    "Roads, Bridges etc"
  ];

  @override
  void initState() {
    final controller = Get.find<HomeController>();

    roleCoontroller = controller.roleCoontroller;
    userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    getOrganizationInfo = controller.userRepo
        .getData('/kyc-organisation-info/fetch?userType=$userType');
    getGenrealInfo = controller.userRepo
        .getData('/kyc-general-info/fetch?userType=$userType');
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
      appBar: newAppBarBack(context, 'Organisation Info'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<ApiResponse>>(
                  future: Future.wait([getOrganizationInfo, getGenrealInfo]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data![0].isSuccessful &&
                        snapshot.data![1].isSuccessful) {
                      if (snapshot.data![0].data == null) {
                        final response1 = snapshot.data![1].data;
                        final genData = GeneralInfoModel.fromJson(response1);

                        if (genData.role != null) {
                          roleCoontroller.text = genData.role ?? "";
                        }

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
                                if (userType == "professional")
                                  Column(
                                    children: [
                                      AppDropDownButton(
                                          onChanged: (String value) {
                                            noOfStaff.text = value;
                                          },
                                          options: numberOfStaff,
                                          label: "No of Staff(s)"),
                                      const SizedBox(height: 10),
                                      AppDropDownButton(
                                          onChanged: (String value) {
                                            costOfProject.text = value;
                                          },
                                          options: costOfProjects,
                                          label: "Cost of Projects Completed"),
                                      const SizedBox(height: 10),
                                      AppDropDownButton(
                                          onChanged: (String value) {
                                            complexity.text = value;
                                          },
                                          options: complexityOfProjects,
                                          label:
                                              "Complexity of Projects Completed"),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
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
                                    isPhoneNumber: true,
                                    validator: Validator.phoneNumValidation),
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
                                      final controller =
                                          Get.find<HomeController>();
                                      final newOrgInfo = {
                                        "organisation_type": orgType,
                                        "others": otherSpecify.text,
                                        "Incorporation_date":
                                            dateOfIncorporation.text,
                                        "director_fullname": directorsName.text,
                                        "director_designation":
                                            directorDesignation.text,
                                        "complexity_of_projects_completed":
                                            complexity.text,
                                        "cost_of_projects_completed":
                                            costOfProject.text,
                                        "no_of_staff": noOfStaff.text,
                                        "director_phone": directorPhone.text,
                                        "role": roleCoontroller.text,
                                        "director_email": directorEmail.text,
                                        "contact_phone": contactPhone.text,
                                        "contact_email": contactEmail.text,
                                        "others_operations":
                                            otherOperations.text,
                                        "userType": userType,
                                        "id": logInDetails.profile!.id
                                      };
                                      final kycScore = widget.kycScore;

                                      kycScore['orgInfo'] = 9;

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
                      final response = snapshot.data![0].data;
                      final orgData = OrgInfoModel.fromJson(response);

                      final response1 = snapshot.data![1].data;
                      final genData = GeneralInfoModel.fromJson(response1);

                      if (genData.role != null) {
                        roleCoontroller.text = genData.role ?? "";
                      }

                      directorsName.text = orgData.directorFullname ?? '';
                      directorDesignation.text =
                          orgData.directorDesignation ?? '';
                      directorPhone.text = orgData.directorPhone.toString();
                      directorEmail.text = orgData.directorEmail ?? '';
                      contactPhone.text = orgData.contactPhone.toString();
                      contactEmail.text = orgData.contactEmail ?? '';
                      otherOperations.text = orgData.othersOperations ?? '';
                      complexity.text = orgData.complexityOfProjects ??
                          complexityOfProjects[0];
                      costOfProject.text =
                          orgData.costOfProjects ?? costOfProjects[0];
                      noOfStaff.text = orgData.noOfStaff ?? numberOfStaff[0];

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
                              if (userType == "professional")
                                Column(
                                  children: [
                                    AppDropDownButton(
                                        onChanged: (String value) {
                                          noOfStaff.text = value;
                                        },
                                        options: numberOfStaff,
                                        value: noOfStaff.text,
                                        label: "No of Staff(s)"),
                                    const SizedBox(height: 10),
                                    AppDropDownButton(
                                        onChanged: (String value) {
                                          costOfProject.text = value;
                                        },
                                        value: costOfProject.text,
                                        options: costOfProjects,
                                        label: "Cost of Projects Completed"),
                                    const SizedBox(height: 10),
                                    AppDropDownButton(
                                        onChanged: (String value) {
                                          complexity.text = value;
                                        },
                                        value: complexity.text,
                                        options: complexityOfProjects,
                                        label:
                                            "Complexity of Projects Completed"),
                                    const SizedBox(height: 10),
                                  ],
                                ),
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
                                  isPhoneNumber: true,
                                  validator: Validator.phoneNumValidation),
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
                                    Get.snackbar('Error',
                                        'Select a type of organization',
                                        backgroundColor: Colors.red,
                                        colorText: AppColors.background);
                                    return;
                                  }
                                  final controller = Get.find<HomeController>();

                                  if (_formKey.currentState!.validate()) {
                                    final newOrgInfo = {
                                      "organisation_type": orgType,
                                      "others": otherSpecify.text,
                                      "Incorporation_date":
                                          dateOfIncorporation.text,
                                      "director_fullname": directorsName.text,
                                      "complexity_of_projects_completed":
                                          complexity.text,
                                      "cost_of_projects_completed":
                                          costOfProject.text,
                                      "no_of_staff": noOfStaff.text,
                                      "director_phone": directorPhone.text,
                                      "role": roleCoontroller.text,
                                      "director_designation":
                                          directorDesignation.text,
                                      "director_email": directorEmail.text,
                                      "contact_phone": contactPhone.text,
                                      "contact_email": contactEmail.text,
                                      "others_operations": otherOperations.text,
                                      "userType": userType,
                                      "userId": logInDetails.profile!.id,
                                      "id": logInDetails.profile!.id
                                    };
                                    final kycScore = widget.kycScore;

                                    kycScore['orgInfo'] = 9;

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
      ),
    ));
  }
}
