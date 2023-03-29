import 'dart:io';

import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/global_widgets/pdf_page_viewer.dart';
import 'package:bog/app/global_widgets/photo_view_page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../data/model/work_experience_model.dart';
import '../../data/providers/api.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_date_picker.dart';
import '../../global_widgets/custom_app_bar.dart';
// import '../../global_widgets/page_input.dart';
import 'package:dio/dio.dart' as dio;

class UpdateWorkExperience extends StatefulWidget {
  final bool isNewWork;
  final WorkExperienceModel? workExperience;
  const UpdateWorkExperience(
      {super.key, required this.isNewWork, this.workExperience});

  @override
  State<UpdateWorkExperience> createState() => _UpdateWorkExperienceState();
}

class _UpdateWorkExperienceState extends State<UpdateWorkExperience> {
  File? pickedFile;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController valueController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController expYearController = TextEditingController();
    TextEditingController subController = TextEditingController();
    TextEditingController fileController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    if (!widget.isNewWork) {
      nameController.text = widget.workExperience!.name ?? '';
      valueController.text = widget.workExperience!.value ?? '';
      dateController.text = widget.workExperience!.date.toString();
      expYearController.text = widget.workExperience!.yearsOfExperience ?? '';
      subController.text = widget.workExperience!.companyInvolvement ?? '';
    }

    final controller = Get.find<HomeController>();
    final userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';

    return AppBaseView(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
                title: widget.isNewWork
                    ? 'Add New Work Experience'
                    : 'Edit Work Experience'),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    PageInput(
                      hint: '',
                      label: 'Name',
                      controller: nameController,
                      validator: MinLengthValidator(5,
                          errorText: 'Enter a valid work name'),
                    ),
                    const SizedBox(height: 8),
                    PageInput(
                      hint: '',
                      label: 'Value NGN',
                      keyboardType: TextInputType.number,
                      controller: valueController,
                      validator: MinLengthValidator(1,
                          errorText: 'Enter a valid amount'),
                    ),
                    const SizedBox(height: 8),
                    AppDatePicker(
                      initialDate: dateController.text,
                      label: 'Date',
                      onChanged: (date) {
                        dateController.text = date;
                      },
                    ),
                    const SizedBox(height: 12),
                    if (widget.isNewWork)
                      PageInput(
                        hint: '',
                        label: 'Provisional Document',
                        controller: fileController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please pick a picture to upload";
                          }
                          return null;
                        },
                        onFilePicked: (file) {
                          pickedFile = file;
                        },
                        isFilePicker: true,
                      ),
                    const SizedBox(height: 12),
                    PageInput(
                      hint: '',
                      label: 'Number of experience(years) as a contractor',
                      controller: expYearController,
                      keyboardType: TextInputType.number,
                      validator: MinLengthValidator(1,
                          errorText: 'Enter a valid number of years'),
                    ),
                    const SizedBox(height: 8),
                    PageInput(
                        hint: '',
                        controller: subController,
                        isTextArea: true,
                        label:
                            'If the company is a subsidiary, what involvement,\nif any, will the parent company have?'),
                    const SizedBox(height: 15),
                    if (!widget.isNewWork)
                      AppButton(
                        title: 'View Document',
                        onPressed: () {
                          if (widget.workExperience!.fileUrl!
                                  .endsWith('.jpg') ||
                              widget.workExperience!.fileUrl!
                                  .endsWith('.png') ||
                              widget.workExperience!.fileUrl!
                                  .endsWith('.jpeg')) {
                            Get.to(() => PhotoViewPage(
                                url: widget.workExperience!.fileUrl!));
                          } else if (widget.workExperience!.fileUrl!
                              .endsWith('.pdf')) {
                            Get.to(() => PdfViewerPage(
                                path: widget.workExperience!.fileUrl!));
                          } else {
                            Get.snackbar(
                                'Error', 'File type not supported currently',
                                backgroundColor: Colors.red);
                          }
                        },
                      ),
                    if (widget.isNewWork)
                      AppButton(
                        title: 'Submit',
                        onPressed: () async {
                          if (widget.isNewWork) {
                            if (pickedFile == null) {
                              Get.snackbar('No File Picked', 'Pick a File',
                                  backgroundColor: Colors.red);
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              final newWorkExperience = {
                                "name": nameController.text,
                                "value": valueController.text,
                                "date": dateController.text,
                                "years_of_experience": expYearController.text,
                                "company_involvement": subController.text,
                                "userType": userType,
                                "document": [
                                  await dio.MultipartFile.fromFile(
                                      pickedFile!.path,
                                      filename:
                                          pickedFile!.path.split('/').last)
                                ]
                              };

                              var formData =
                                  dio.FormData.fromMap(newWorkExperience);
                              var response = await Api().postData(
                                  "/kyc-work-experience/create",
                                  body: formData,
                                  hasHeader: true);
                              if (response.isSuccessful) {
                                Get.back();
                                Get.snackbar('Success',
                                    'Work Experience Updated Successfully',
                                    backgroundColor: Colors.green);
                              } else {
                                Get.showSnackbar(const GetSnackBar(
                                  message: 'Error occured',
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          } else {
                            if (_formKey.currentState!.validate()) {
                              final newWorkExperience = {
                                "name": nameController.text,
                                "value": valueController.text,
                                "date": dateController.text,
                                "years_of_experience": expYearController.text,
                                "company_involvement": subController.text,
                                "userType": userType,
                              };

                              var formData =
                                  dio.FormData.fromMap(newWorkExperience);
                              var response = await Api().postData(
                                  "/kyc-work-experience/create",
                                  body: formData,
                                  hasHeader: true);
                              if (response.isSuccessful) {
                                Get.back();
                                Get.back();
                                Get.snackbar('Success',
                                    'Work Experience Updated Successfully',
                                    backgroundColor: Colors.green);
                              } else {
                                Get.showSnackbar(const GetSnackBar(
                                  message: 'Error occured',
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          }
                        },
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
