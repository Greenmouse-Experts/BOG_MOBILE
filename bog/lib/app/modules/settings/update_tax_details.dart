import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    getTaxInfo =
        controller.userRepo.getData('/kyc-tax-permits/fetch?userType=vendor');
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
                  final response = snapshot.data!.data;
                  final taxData = TaxDataModel.fromJson(response);
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
                            initialValue: taxData.vat,
                          ),
                          PageInput(
                            hint: '',
                            label: 'TAX Identification Number',
                            keyboardType: TextInputType.number,
                            initialValue: taxData.tin,
                          ),
                          PageInput(
                            hint: '',
                            label:
                                'List of Professional Bodies registered with',
                            isTextArea: true,
                            initialValue: taxData.relevantStatutory,
                          ),
                          const SizedBox(height: 10),
                          AppButton(
                            title: 'Submit',
                            onPressed: () {},
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
