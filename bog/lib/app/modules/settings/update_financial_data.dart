import 'dart:convert';
import 'package:flutter/material.dart';

import '../../data/model/BankListModel.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../global_widgets/page_dropdown.dart';
import '../../global_widgets/page_input.dart';

class UpdateFinancialDetails extends StatelessWidget {
  const UpdateFinancialDetails({super.key});

  @override
  Widget build(BuildContext context) {
     TextEditingController bankCode = TextEditingController(text: '120001');
  TextEditingController chosenBankName = TextEditingController(text: '9mobile 9Payment Service Bank');
   var bankList = BankListModel.fromJsonList(jsonDecode(MyPref.bankListDetail.val));
    return AppBaseView(child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      const    CustomAppBar(title: 'Financial Details'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Column(
              children: [
                PageDropButton(
                                label: "Bank",
                                hint: '',
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                onChanged: (val) {
                                  bankCode.text = (val! as BankListModel).code.toString();
                                  chosenBankName.text = (val as BankListModel).name.toString();
                                },
                                value:  bankList.first,
                                items: bankList.map<DropdownMenuItem<BankListModel>>((BankListModel value) {
                                  return DropdownMenuItem<BankListModel>(
                                    value: value,
                                    child: Text(value.name.toString()),
                                  );
                                }).toList(),
                              ),
                             const SizedBox(height: 5),
              const  PageInput(hint: '', label: 'Bank Account Number', keyboardType: TextInputType.number, ),
              const  PageInput(hint: '', label: 'Bank Account Name'),
              const  PageInput(hint: '', label: 'Name and Address of References', isTextArea: true,),
              const PageInput(hint: '', label: 'Level of current Overdraft Facility'),
              
              ],
            ),
          )
        ],
      ),
    ));
  }
}