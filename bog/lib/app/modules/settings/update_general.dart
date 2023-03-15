import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/app_radio_button.dart';
import 'package:bog/app/global_widgets/page_input.dart';
import 'package:flutter/material.dart';

class UpdateGeneralInfo extends StatelessWidget {
  const UpdateGeneralInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final options = ['Incorporation', 'Registered Business Name'];
    return AppBaseView(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        const    CustomAppBar(title: 'General Info'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Column(
                children:  [
             const     PageInput(hint: '', label: 'Name of Organization' ),
             const     PageInput(hint: '', label: 'Email Address'),
            const      PageInput(hint: 'hint', label: 'Type of Registration'),
                  AppRadioButton(options: options),
            const      PageInput(hint: '', label: 'Office Telephone', keyboardType: TextInputType.phone),
             const     PageInput(hint: '', label: 'Registration Number'),
               const   PageInput(hint: '', label: 'Business Address'),
             const     PageInput(hint: '', label: 'Other Significant Address', isTextArea: true,),
       const      SizedBox(height: 5),
             AppButton(title: 'Submit', onPressed: (){},),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}