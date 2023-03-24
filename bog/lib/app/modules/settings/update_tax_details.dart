import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../data/model/tax_data_model.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_loader.dart';

class UpdateTaxDetails extends StatefulWidget {
  const UpdateTaxDetails({super.key});

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(title: 'Tax Details'),
          FutureBuilder<ApiResponse>(
              future: getTaxInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data!.isSuccessful) {
                      if (snapshot.data!.data != null){

                      
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
                            validator: MinLengthValidator(1, errorText: 'Enter a valid registration numbers'),
                          ),
                          const SizedBox(height: 8),
                          PageInput(
                            hint: '',
                            label: 'TAX Identification Number',
                            keyboardType: TextInputType.number,
                            controller: taxIdNum,
                            validator: MinLengthValidator(1, errorText: 'Enter a valid TIN Number'),
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
                            onPressed: ()async {
                               if (_formKey.currentState!.validate()) {
                                final newTaxDetails = {
                                  "VAT": vatRegNum.text,
                                  "TIN" : taxIdNum.text,
                                  "relevant_statutory" : professionalBodies.text,
                                  "userType": userType
                                };
                                print(newTaxDetails.toString());
                                 final controller = Get.find<HomeController>();
                                final res = await controller.userRepo
                                      .postData('/kyc-tax-permits/create',
                                          newTaxDetails);
                                  if (res.isSuccessful) {
                                    Get.back();
                                    Get.snackbar('Success', 'Tax Details Updated Successfully', backgroundColor: Colors.green);
                                  } else {
                                    Get.showSnackbar(const GetSnackBar(
                                      message: 'Error occured',
                                      backgroundColor: Colors.red,
                                    ));
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
