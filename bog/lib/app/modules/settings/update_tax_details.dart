import 'dart:convert';

import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/global_widgets/page_input.dart';
import 'package:flutter/material.dart';

import '../../data/model/BankListModel.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/page_dropdown.dart';

class UpdateTaxDetails extends StatelessWidget {
  const UpdateTaxDetails({super.key});

  @override
  Widget build(BuildContext context) {
  
 
    return AppBaseView(child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      const    CustomAppBar(title: 'Tax Details'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Column(
              children:  [
                 
              const  PageInput(hint: '', label: 'VAT Registration Number', keyboardType: TextInputType.number, ),
              const  PageInput(hint: '', label: 'TAX Identification Number', keyboardType: TextInputType.number),
              const  PageInput(hint: '', label: 'List of Professional Bodies registered with', isTextArea: true,),
              const  SizedBox(height: 10),
                AppButton(title: 'Submit', onPressed: () {
                  
                },)
              ],
            ),
          )
        ],
      ),
    ));
  }
}