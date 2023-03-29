import 'dart:convert';

import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/global_widgets/bank_name.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../data/model/bank_details_model.dart';
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
  late String userType;
  final _formKey = GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  //TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankCode = TextEditingController(text: '120001');
  TextEditingController chosenBankName =
      TextEditingController(text: '9mobile 9Payment Service Bank');

  TextEditingController accountNameController = TextEditingController();
  TextEditingController referenceNameController = TextEditingController();
  TextEditingController overdraftController = TextEditingController();

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    getFinData = controller.userRepo
        .getData('/kyc-financial-data/fetch?userType=$userType');
    accountController.addListener(_verifyAccount);
    super.initState();
  }

  void _verifyAccount() async {
    final accountNumber = accountController.text;
    final bank = bankCode.text;
    print(bank + accountNumber);
    if (accountNumber.length == 10) {
      final controller = Get.find<HomeController>();
      final response =
          await controller.userRepo.postData('/bank/verify-account', {
        "account_number": accountNumber,
        "bank_code": bank,
      });

      if (response.isSuccessful) {
        final bankDetail = BankDetailsModel.fromJson(response.data);

        accountNameController.text = bankDetail.accountName ?? '';
      } else {
        // Verification failed, clear the output text field and show an error message
        accountNameController.clear();
        Get.snackbar('Error', 'Failed to verify account number',
            backgroundColor: Colors.red);
      }
    } else {
      accountNameController.clear();
    }
  }

  var bankList =
      BankListModel.fromJsonList(jsonDecode(MyPref.bankListDetail.val));
  var previousBank;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return AppBaseView(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: 'Financial Details'),
            FutureBuilder<ApiResponse>(
                future: getFinData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data!.isSuccessful) {
                    if (snapshot.data!.data != null) {
                      final response = snapshot.data!.data;
                      final finData = FinDataModel.fromJson(response);

                      final newBank = bankList.firstWhere((element) => element
                          .name!
                          .toLowerCase()
                          .contains(finData.bankName!.toLowerCase()));

                      previousBank = newBank;

                      bankCode.text = newBank.code!;
                      accountController.text = finData.accountNumber ?? '';
                      // accountNumberController.text =
                      //     finData.accountNumber ?? '';
                      accountNameController.text = finData.accountName ?? '';
                      referenceNameController.text =
                          finData.bankerAddress ?? '';
                      overdraftController.text =
                          finData.overdraftFacility ?? '';
                      chosenBankName.text = finData.bankName ?? '';
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            PageDropButton(
                              label: "Bank",
                              hint: '',
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              onChanged: (val) {
                                bankCode.text =
                                    (val! as BankListModel).code.toString();
                                chosenBankName.text =
                                    (val as BankListModel).name.toString();
                              },
                              value: previousBank ?? bankList.first,
                              items: bankList
                                  .map<DropdownMenuItem<BankListModel>>(
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
                              controller: accountController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: LengthRangeValidator(
                                  min: 10,
                                  max: 10,
                                  errorText: 'Enter a valid account number'),
                            ),
                            // PageInput(
                            //   hint: '',
                            //   label: 'Bank Account Number',
                            //   keyboardType: TextInputType.number,
                            //   controller: accountNumberController,
                            //   // autovalidateMode: AutovalidateMode.onUserInteraction,
                            //   // validator: LengthRangeValidator(min: 10, max: 10, errorText: 'Enter a valid account number'),
                            // ),
                            const SizedBox(height: 10),

                            DisabledPageInput(
                              hint: '',
                              label: 'Bank Account Name',
                              controller: accountNameController,
                              validator: MinLengthValidator(3,
                                  errorText: 'Enter a valid account number'),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Name and Address of References',
                              isTextArea: true,
                              controller: referenceNameController,
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Level of current Overdraft Facility',
                              controller: overdraftController,
                            ),
                            const SizedBox(height: 12),
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
      ),
    ));
  }
}
