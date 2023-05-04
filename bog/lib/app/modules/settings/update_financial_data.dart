import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/bank_details_model.dart';
import '../../data/model/bank_list_model.dart';
import '../../data/model/fin_data_model.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/app_radio_button.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/page_dropdown.dart';

class UpdateFinancialDetails extends StatefulWidget {
  final Map<String, dynamic> kycScore;
  final Map<String, dynamic> kycTotal;
  const UpdateFinancialDetails(
      {super.key, required this.kycScore, required this.kycTotal});

  @override
  State<UpdateFinancialDetails> createState() => _UpdateFinancialDetailsState();
}

class _UpdateFinancialDetailsState extends State<UpdateFinancialDetails> {
  late Future<ApiResponse> getFinData;
  late String userType;
  final _formKey = GlobalKey<FormState>();
  //  final _realFormKey = GlobalKey<FormState>();
  TextEditingController accountController = TextEditingController();
  TextEditingController newAccountController = TextEditingController();
  //TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankCode = TextEditingController(text: '120001');
  TextEditingController chosenBankName =
      TextEditingController(text: '9mobile 9Payment Service Bank');

  TextEditingController accountNameController = TextEditingController();
  TextEditingController referenceNameController = TextEditingController();
  TextEditingController overdraftController = TextEditingController();
  TextEditingController typeOfAccountController = TextEditingController();
  bool isVerifying = false;

  final List<String> accountOptions = ['savings', 'current'];

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    getFinData = controller.userRepo
        .getData('/kyc-financial-data/fetch?userType=$userType');

    accountController.removeListener(() {});
    super.initState();
  }

  var bankList =
      BankListModel.fromJsonList(jsonDecode(MyPref.bankListDetail.val));
  var previousBank;
  @override
  Widget build(BuildContext context) {
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
                      accountNameController.text = finData.accountName ?? '';
                      referenceNameController.text =
                          finData.bankerAddress ?? '';
                      overdraftController.text =
                          finData.overdraftFacility ?? '';
                      chosenBankName.text = finData.bankName ?? '';
                      typeOfAccountController.text = finData.accountType ?? '';
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
                              onchanged: (val) {
                                newAccountController.text = val;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: LengthRangeValidator(
                                  min: 10,
                                  max: 10,
                                  errorText: 'Enter a valid account number'),
                            ),
                            const SizedBox(height: 10),
                            PageInput(
                              readOnly: true,
                              hint: '',
                              label: 'Bank Account Name',
                              controller: accountNameController,
                              validator: MinLengthValidator(3,
                                  errorText: 'Enter a valid account number'),
                            ),
                            RightAlignText(
                                controller: newAccountController,
                                bankCode: bankCode,
                                onSuccess: (val) {
                                  accountNameController.text = val;
                                }),
                            const SizedBox(height: 10),
                            AppRadioButton(
                                options: accountOptions,
                                label: 'Type of Account',
                                option1: typeOfAccountController.text,
                                onchanged: (val) {
                                  typeOfAccountController.text =
                                      val.toString().toLowerCase();
                                }),
                            const SizedBox(height: 10),
                            PageInput(
                                hint: '',
                                label: 'Name and Address of References',
                                isTextArea: true,
                                controller: referenceNameController,
                                validator: MinLengthValidator(1,
                                    errorText: 'Enter current overdraft')),
                            const SizedBox(height: 10),
                            PageInput(
                              hint: '',
                              label: 'Level of current Overdraft Facility',
                              controller: overdraftController,
                              validator: MinLengthValidator(1,
                                  errorText: 'Enter current overdraft'),
                            ),
                            const SizedBox(height: 12),
                            AppButton(
                              title: 'Submit',
                              onPressed: () async {
                                if (typeOfAccountController.text.isEmpty) {
                                  Get.snackbar(
                                      'Error', 'Select a type of account',
                                      backgroundColor: Colors.red,
                                      colorText: AppColors.background);
                                  return;
                                }
                                if (_formKey.currentState!.validate()) {
                                  final financialData = {
                                    'userType': userType,
                                    'account_name': accountNameController.text,
                                    'account_number': accountController.text,
                                    'account_type':
                                        typeOfAccountController.text,
                                    'bank_name': chosenBankName.text,
                                    'overdraft_facility':
                                        overdraftController.text,
                                    'banker_address':
                                        referenceNameController.text
                                  };

                                  final kycScore = widget.kycScore;
                                  kycScore['financialData'] = 6;

                                  final controller = Get.find<HomeController>();
                                  final updateAccount = await controller
                                      .userRepo
                                      .patchData('/user/update-account', {
                                    "kycScore": jsonEncode(kycScore),
                                    "kycTotal": jsonEncode(widget.kycTotal)
                                  });
                                  final res = await controller.userRepo
                                      .postData('/kyc-financial-data/create',
                                          financialData);
                                  if (res.isSuccessful &&
                                      updateAccount.isSuccessful) {
                                    MyPref.setOverlay.val = false;
                                    AppOverlay.successOverlay(
                                        message:
                                            'Financial Details Updated Successfully');
                                  } else {
                                    Get.snackbar('Error',
                                        res.message ?? 'An Error occured',
                                        backgroundColor: Colors.red,
                                        colorText: AppColors.background);
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
      ),
    ));
  }
}

class RightAlignText extends StatefulWidget {
  const RightAlignText({
    super.key,
    required this.controller,
    required this.onSuccess,
    required this.bankCode,
  });

  final TextEditingController controller;
  final TextEditingController bankCode;
  final Function onSuccess;

  @override
  State<RightAlignText> createState() => _RightAlignTextState();
}

class _RightAlignTextState extends State<RightAlignText> {
  String verificationStatus = 'Enter account number';
  Color verificationColor = Colors.black;
//  late TextEditingController controller;
  late TextEditingController bankCode;

  @override
  void initState() {
    // controller = widget.controller;
    bankCode = widget.bankCode;
    super.initState();
    widget.controller.addListener(
      _verifyAccount,
    );
  }

  void _verifyAccount() async {
    final accountNumber = widget.controller.text;
    final bank = bankCode.text;
    if (accountNumber.length == 10) {
      setState(() {
        verificationStatus = 'Verification in progress';
        verificationColor = Colors.green;
      });

      final controller = Get.find<HomeController>();
      final response =
          await controller.userRepo.postData('/bank/verify-account', {
        "account_number": accountNumber,
        "bank_code": bank,
      });

      if (response.status != null) {
        if (response.status) {
          setState(() {
            verificationStatus = 'Verification Successful';
            verificationColor = Colors.green;
          });

          final bankDetail = BankDetailsModel.fromJson(response.data);
          widget.onSuccess(bankDetail.accountName ?? '');
        }
      } else {
        setState(() {
          verificationStatus = 'Verification Failed';
          verificationColor = Colors.red;
        });
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return widget.controller.text.isEmpty
        ? const SizedBox.shrink()
        : Align(
            alignment: Alignment.centerRight,
            child: Text(
              verificationStatus,
              style: TextStyle(color: verificationColor),
            ),
          );
  }
}
