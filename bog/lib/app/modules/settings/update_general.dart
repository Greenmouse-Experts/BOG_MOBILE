import 'dart:async';
import 'dart:convert';

import 'package:bog/app/data/model/general_info_model.dart';
import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/app_radio_button.dart';
import 'package:bog/app/global_widgets/page_input.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';

class UpdateGeneralInfo extends StatefulWidget {
  const UpdateGeneralInfo({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: 'General Info'),
            FutureBuilder<ApiResponse>(
                future: getGenrealInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data!.isSuccessful) {
                    final response = snapshot.data!.data;
                    final orgData = GeneralInfoModel.fromJson(response);
                    nameOfOrgController.text = orgData.organisationName ?? '';
                    emailController.text = orgData.emailAddress ?? '';
                    officeTelController.text = orgData.contactNumber.toString();
                    regNumController.text =
                        orgData.registrationNumber.toString();
                    busAddressController.text = orgData.businessAddress ?? '';
                    otherAddressController.text =
                        orgData.operationalAddress ?? '';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            PageInput(
                              hint: '',
                              label: 'Name of Organization',
                              //    initialValue: orgData.organisationName,
                              validator: MinLengthValidator(3,
                                  errorText: 'Enter a Valid Organization Name'),
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
                                orgData.regType = value;
                              },
                              option1: orgData.regType,
                              options: options,
                              label: 'Type of Registration',
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Office Telephone',
                              controller: officeTelController,
                              keyboardType: TextInputType.phone,
                              //   initialValue: orgData.contactNumber.toString(),
                              validator: LengthRangeValidator(
                                  max: 11,
                                  min: 11,
                                  errorText: 'Enter a valid phone number'),
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
                            const SizedBox(height: 15),
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
                                    "reg_type": orgData.regType,
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
                                  final controller = Get.find<HomeController>();
                                  final res = await controller.userRepo
                                      .postData('/kyc-general-info/create',
                                          newGeneralInfo);
                                  if (res.isSuccessful) {
                                    Get.back();
                                  } else {
                                    Get.showSnackbar(const GetSnackBar(
                                      message: 'Error occured',
                                      backgroundColor: Colors.red,
                                    ));
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
