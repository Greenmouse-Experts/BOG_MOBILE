import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/tax_data_model.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/new_app_bar.dart';

class UpdateTaxDetails extends StatefulWidget {
  final Map<String, dynamic> kycScore;
  final Map<String, dynamic> kycTotal;
  const UpdateTaxDetails(
      {super.key, required this.kycScore, required this.kycTotal});

  @override
  State<UpdateTaxDetails> createState() => _UpdateTaxDetailsState();
}

class _UpdateTaxDetailsState extends State<UpdateTaxDetails> {
  late Future<ApiResponse> getTaxInfo;
  final _formKey = GlobalKey<FormState>();

  TextEditingController vatRegNum = TextEditingController();
  TextEditingController taxIdNum = TextEditingController();
  TextEditingController professionalBodies = TextEditingController();
  late String userType;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    getTaxInfo = controller.userRepo
        .getData('/kyc-tax-permits/fetch?userType=$userType');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
        child: Scaffold(
      appBar: newAppBarBack(context, 'Tax Details'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const CustomAppBar(title: 'Tax Details'),
          FutureBuilder<ApiResponse>(
              future: getTaxInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data!.isSuccessful) {
                  if (snapshot.data!.data != null) {
                    final response = snapshot.data!.data;
                    final taxData = TaxDataModel.fromJson(response);

                    vatRegNum.text = taxData.vat ?? '';
                    taxIdNum.text = taxData.tin ?? '';
                    professionalBodies.text = taxData.relevantStatutory ?? '';
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          PageInput(
                            hint: '',
                            label: 'VAT Registration Number',
                            keyboardType: TextInputType.number,
                            controller: vatRegNum,
                            validator: MinLengthValidator(1,
                                errorText:
                                    'Enter a valid registration numbers'),
                          ),
                          const SizedBox(height: 8),
                          PageInput(
                            hint: '',
                            label: 'TAX Identification Number',
                            keyboardType: TextInputType.number,
                            controller: taxIdNum,
                            validator: MinLengthValidator(1,
                                errorText: 'Enter a valid TIN Number'),
                          ),
                          const SizedBox(height: 8),
                          PageInput(
                            hint: '',
                            label:
                                'List of Professional Bodies registered with',
                            isTextArea: true,
                            controller: professionalBodies,
                          ),
                          const SizedBox(height: 15),
                          AppButton(
                            title: 'Submit',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final newTaxDetails = {
                                  "VAT": vatRegNum.text,
                                  "TIN": taxIdNum.text,
                                  "relevant_statutory": professionalBodies.text,
                                  "userType": userType
                                };
                                final kycScore = widget.kycScore;

                                kycScore['taxDetails'] = 3;
                                final controller = Get.find<HomeController>();
                                final updateAccount = await controller.userRepo
                                    .patchData('/user/update-account', {
                                  "kycScore": jsonEncode(kycScore),
                                  "kycTotal": jsonEncode(widget.kycTotal)
                                });
                                final res = await controller.userRepo.postData(
                                    '/kyc-tax-permits/create', newTaxDetails);
                                if (res.isSuccessful &&
                                    updateAccount.isSuccessful) {
                                  MyPref.setOverlay.val = false;
                                  AppOverlay.successOverlay(
                                      message:
                                          'Tax Details Updated Successfully');
                                } else {
                                  Get.snackbar(
                                      'Error', res.message ?? 'Error Occured',
                                      colorText: AppColors.backgroundVariant1,
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
      ),
    ));
  }
}
