import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_date_picker.dart';
import 'package:bog/app/global_widgets/app_drop_down_button.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../data/model/org_info_model.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_loader.dart';

class UpdateOrganisationInfo extends StatefulWidget {
  const UpdateOrganisationInfo({super.key});

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

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    getOrganizationInfo = controller.userRepo
        .getData('/kyc-organisation-info/fetch?userType=vendor');
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
                              onChanged: (value) {},
                              options: options,
                              label: 'Type of organisation',
                            ),
                            const SizedBox(height: 10),
                            AppDatePicker(
                              label: 'Date of Incorporation/Registration',
                              onChanged: () {},
                            ),
                            const SizedBox(height: 10),
                            const PageInput(hint: '', label: 'Others(Specify)'),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: 'Full Name',
                              label: 'Directors Full Name',
                              controller: directorsName,
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Directors Designation',
                              controller: directorDesignation,
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Directors Phone Number',
                              keyboardType: TextInputType.phone,
                              controller: directorPhone,
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Directors Email',
                              keyboardType: TextInputType.emailAddress,
                              controller: directorEmail,
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Contact Person Phone Number',
                              keyboardType: TextInputType.phone,
                              controller: contactPhone,
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Contact Person Email',
                              keyboardType: TextInputType.emailAddress,
                              controller: contactEmail,
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
                                if (_formKey.currentState!.validate()) {
                                  final newOrgInfo = {
                                    "organisation_type": "Partnership",
                                    "others": "Others",
                                    "Incorporation_date": "2023-01-29",
                                    "director_fullname": "Test director",
                                    "director_designation": "Director",
                                    "director_phone": "0810173664",
                                    "director_email": "testdir@yopmail.com",
                                    "contact_phone": "091838743",
                                    "contact_email": "test3567@test.com",
                                    "others_operations": "Google\nFacebook",
                                    "userType": "professional",
                                    "id": "f303e149-623a-428b-879d-583a99d38b47"
                                  };

                                  final controller = Get.find<HomeController>();
                                  final res = await controller.userRepo
                                      .postData('/kyc-general-info/create',
                                          newOrgInfo);
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