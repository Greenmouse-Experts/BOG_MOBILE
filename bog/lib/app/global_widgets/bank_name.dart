

import 'package:bog/app/data/model/bank_details_model.dart';
import 'package:bog/app/data/providers/api_response.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';

class BankNameWidget extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController accountController;
   final HomeController controller;
   final String bankCode;
   
  const BankNameWidget({super.key, required this.nameController,required this.controller, required this.bankCode, required this.accountController});

  @override
  State<BankNameWidget> createState() => _BankNameWidgetState();
}

class _BankNameWidgetState extends State<BankNameWidget> {
  @override
  Widget build(BuildContext context) {
      print(widget.bankCode);
      print(widget.accountController.text);
    return FutureBuilder<ApiResponse>(
      future: widget.controller.userRepo.postData('/bank/verify-account', {
        "account_number" : widget.accountController.text,
        "bank_code" : widget.bankCode,
      }),
      builder: (ctx, snapshot){
         if (snapshot.hasData){
          if (snapshot.data!.isSuccessful){
              final bankDetail = BankDetailsModel.fromJson(snapshot.data!.data);
          widget.nameController.text = bankDetail.accountName!;

         return DisabledPageInput(hint: '', label: 'Bank Account Name', controller: widget.nameController,);
          } else {
            return Text('Enter a valid account');
          }
        
         } else if (snapshot.hasError){
          return const Text('Enter a valid account number'); 
         } else{
           return const Center(
            child: CircularProgressIndicator(color: AppColors.primary,),
           );
         }

         
    });
  }
}