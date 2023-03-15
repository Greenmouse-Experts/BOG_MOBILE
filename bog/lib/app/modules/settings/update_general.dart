import 'package:bog/app/data/model/general_info_model.dart';
import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/app_radio_button.dart';
import 'package:bog/app/global_widgets/page_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../data/providers/api_response.dart';

class UpdateGeneralInfo extends StatefulWidget {
  const UpdateGeneralInfo({super.key});

  @override
  State<UpdateGeneralInfo> createState() => _UpdateGeneralInfoState();
}

class _UpdateGeneralInfoState extends State<UpdateGeneralInfo> {
  late Future<ApiResponse> getGenrealInfo;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    getGenrealInfo =
        controller.userRepo.getData('/kyc-general-info/fetch?userType=vendor');
    super.initState();
  }

  TextEditingController nameOfOrgController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController typeOfRegController = TextEditingController();
  TextEditingController officeTelController = TextEditingController();
  TextEditingController regNumController = TextEditingController();
  TextEditingController busAddressController = TextEditingController();
  TextEditingController otherAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final options = ['Incorporation', 'Registered Business Name'];
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

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            PageInput(
                              hint: '',
                              label: 'Name of Organization',
                              initialValue: orgData.organisationName,
                            ),
                            PageInput(
                              hint: '',
                              label: 'Email Address',
                              initialValue: orgData.emailAddress,
                            ),
                            AppRadioButton(
                              option1: orgData.regType,
                              options: options,
                              label: 'Type of Registration',
                            ),
                            PageInput(
                              hint: '',
                              label: 'Office Telephone',
                              keyboardType: TextInputType.phone,
                              initialValue: orgData.contactNumber.toString(),
                            ),
                            PageInput(
                              hint: '',
                              label: 'Registration Number',
                              initialValue:
                                  orgData.registrationNumber.toString(),
                            ),
                            PageInput(
                              hint: '',
                              label: 'Business Address',
                              initialValue: orgData.businessAddress,
                            ),
                            PageInput(
                              hint: '',
                              label: 'Other Significant Address',
                              isTextArea: true,
                              initialValue: orgData.operationalAddress,
                            ),
                            const SizedBox(height: 5),
                            AppButton(
                              title: 'Submit',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(' Data')),
                                  );
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
