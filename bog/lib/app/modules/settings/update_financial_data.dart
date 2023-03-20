import 'dart:convert';

import 'package:bog/app/global_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../data/model/bank_list_model.dart';
import '../../data/model/fin_data_model.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../global_widgets/page_dropdown.dart';
import '../../global_widgets/page_input.dart';

class UpdateFinancialDetails extends StatefulWidget {
  const UpdateFinancialDetails({super.key});

  @override
  State<UpdateFinancialDetails> createState() => _UpdateFinancialDetailsState();
}

class _UpdateFinancialDetailsState extends State<UpdateFinancialDetails> {
  late Future<ApiResponse> getFinData;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    getFinData = controller.userRepo
        .getData('/kyc-financial-data/fetch?userType=vendor');
    super.initState();
  }

  TextEditingController bankCode = TextEditingController(text: '120001');
  TextEditingController chosenBankName =
      TextEditingController(text: '9mobile 9Payment Service Bank');
  var bankList =
      BankListModel.fromJsonList(jsonDecode(MyPref.bankListDetail.val));
  @override
  Widget build(BuildContext context) {
    return AppBaseView(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(title: 'Financial Details'),
          FutureBuilder<ApiResponse>(
              future: getFinData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data!.isSuccessful) {
                  final response = snapshot.data!.data;
                  final finData = FinDataModel.fromJson(response);
                  //   print(finData.bankName);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        PageDropButton(
                          label: "Bank",
                          hint: '',
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          onChanged: (val) {
                            bankCode.text =
                                (val! as BankListModel).code.toString();
                            chosenBankName.text =
                                (val as BankListModel).name.toString();
                          },
                          value: bankList.first,
                          items: bankList.map<DropdownMenuItem<BankListModel>>(
                              (BankListModel value) {
                            return DropdownMenuItem<BankListModel>(
                              value: value,
                              child: Text(value.name.toString()),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        PageInput(
                          hint: '',
                          label: 'Bank Account Number',
                          keyboardType: TextInputType.number,
                          initialValue: finData.accountNumber,
                        ),
                        const SizedBox(height: 10),
                        PageInput(
                          hint: '',
                          label: 'Bank Account Name',
                          initialValue: finData.accountName,
                        ),
                        const SizedBox(height: 10),
                        PageInput(
                          hint: '',
                          label: 'Name and Address of References',
                          isTextArea: true,
                          initialValue: finData.bankName,
                        ),
                        const SizedBox(height: 10),
                        PageInput(
                          hint: '',
                          label: 'Level of current Overdraft Facility',
                          initialValue: finData.overdraftFacility,
                        ),
                        const SizedBox(height: 12),
                        AppButton(
                          title: 'Submit',
                          onPressed: () {},
                        )
                      ],
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
