import 'package:flutter/material.dart';

import '../../data/model/work_experience_model.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_date_picker.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../global_widgets/page_input.dart';

class UpdateWorkExperience extends StatelessWidget {
  final bool isNewWork;
  final WorkExperienceModel? workExperience;
  const UpdateWorkExperience(
      {super.key, required this.isNewWork, this.workExperience});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController valueController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController expYearController = TextEditingController();
    TextEditingController subController = TextEditingController();

    if (!isNewWork) {
      nameController.text = workExperience!.name ?? '';
      valueController.text = workExperience!.value ?? '';
      dateController.text = workExperience!.date.toString();
      expYearController.text = workExperience!.yearsOfExperience ?? '';
      subController.text = workExperience!.companyInvolvement ?? '';
    }

    return AppBaseView(
        child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(
              title: isNewWork
                  ? 'Add New Work Experience'
                  : 'Edit Work Experience'),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                PageInput(
                  hint: '',
                  label: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 8),
                PageInput(
                  hint: '',
                  label: 'Value NGN',
                  controller: valueController,
                ),
                const SizedBox(height: 8),
                AppDatePicker(
                  label: 'Date',
                  onChanged: () {},
                ),
                const SizedBox(height: 8),
                const PageInput(
                  hint: '',
                  label: 'Provisional Document',
                  isFilePicker: true,
                ),
                const SizedBox(height: 8),
                PageInput(
                  hint: '',
                  label: 'Number of experience(years) as a contractor',
                  controller: expYearController,
                ),
                const SizedBox(height: 8),
                PageInput(
                    hint: '',
                    controller: subController,
                    label:
                        'If the company is a subsidiary, what involvement,\nif any, will the parent company have?'),
                const SizedBox(height: 8),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
