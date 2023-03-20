import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_date_picker.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:flutter/material.dart';


class UpdateWorkExperience extends StatelessWidget {
  final bool isNewWork;
  const UpdateWorkExperience({super.key, required this.isNewWork});

  @override
  Widget build(BuildContext context) {
    return  AppBaseView(child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: 'Add New Work Experience'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
            PageInput(hint: '', label: 'Name'),
            const SizedBox(height: 8),
            PageInput(hint: '', label: 'Value NGN'),
            const SizedBox(height: 8),
                   AppDatePicker(label: 'Date'),
                   const SizedBox(height: 8),
                   PageInput(hint: '', label: 'Provisional Document', isFilePicker: true),
                   const SizedBox(height: 8),
                   PageInput(hint: '', label: 'Number of experience(years) as a contractor',),
                   const SizedBox(height: 8),
                   PageInput(hint: '', label: 'If the company is a subsidiary, what involvement,\nif any, will the parent company have?'),
                   const SizedBox(height: 8),
              ],
            ),
          )
        
        ],
      ),
    ));
  }
}