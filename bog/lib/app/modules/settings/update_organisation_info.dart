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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppDropDownButton(
                              options: options,
                              label: 'Type of organisation',
                            ),
                            const SizedBox(height: 10),
                            const AppDatePicker(
                                label: 'Date of Incorporation/Registration'),
                            const SizedBox(height: 10),
                            const PageInput(hint: '', label: 'Others(Specify)'),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: 'Full Name',
                              label: 'Directors Name',
                              initialValue: orgData.directorFullname,
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Directors Designation',
                              initialValue: orgData.directorDesignation,
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Directors Phone Number',
                              keyboardType: TextInputType.phone,
                              initialValue: orgData.directorPhone.toString(),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Directors Email',
                              keyboardType: TextInputType.emailAddress,
                              initialValue: orgData.directorEmail,
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Contact Person Phone Number',
                              keyboardType: TextInputType.phone,
                              initialValue: orgData.contactPhone.toString(),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Contact Person Email',
                              keyboardType: TextInputType.emailAddress,
                              initialValue: orgData.contactPhone.toString(),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Mention Other Companies Operated',
                              isTextArea: true,
                              initialValue: orgData.othersOperations,
                            ),
                            const SizedBox(height: 15),
                            AppButton(title: 'Submit', onPressed: () {}),
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
