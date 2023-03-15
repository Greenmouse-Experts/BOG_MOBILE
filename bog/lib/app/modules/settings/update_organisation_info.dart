import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_date_picker.dart';
import 'package:bog/app/global_widgets/app_drop_down_button.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/global_widgets/page_dropdown.dart';

import 'package:flutter/material.dart';

class UpdateOrganisationInfo extends StatelessWidget {
  const UpdateOrganisationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final options = ['Sole Proprietorship','Partnership', 'Joint Venture', 'Limited Liability', 'Others(Specify)'];
    return AppBaseView(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        const    CustomAppBar(title: 'Organisation Info'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Column(
                children:  [
                  // PageDropButton(label: '', hint: 'Type of Organization'),
                  AppDropDownButton(options: options,label: 'Type of organisation',),
              const    AppDatePicker(label: 'Date of Incorporation/Registration'),
             const     PageInput(hint: '', label: 'Others(Specify)' ),
                  
               const   PageInput(hint: 'Full Name', label: 'Directors Name'),
            const      PageInput(hint: '', label: 'Directors Designation'),
           const       PageInput(hint: '', label: 'Directors Phone Number', keyboardType: TextInputType.phone,), 
            const      PageInput(hint: '', label: 'Directors Email', keyboardType: TextInputType.emailAddress),
             const     PageInput(hint: '', label: 'Contact Person Phone Number', keyboardType: TextInputType.phone,),
            const      PageInput(hint: '', label: 'Contact Person Email', keyboardType: TextInputType.emailAddress,),
             const     PageInput(hint: '', label: 'Mention Other Companies Operated', isTextArea: true,),
        const     SizedBox(height: 5),
             AppButton(title: 'Submit', onPressed: (){}),

                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}