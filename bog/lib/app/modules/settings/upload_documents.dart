import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/page_input.dart';
import 'package:flutter/material.dart';

class UploadDocuments extends StatelessWidget {
  const UploadDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: 'Financial Details'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: const [
                  PageInput(
                      hint: 'Company Profile',
                      label: "Company's Corporate Profile",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Organizational Chart",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Certificate of Incorporation",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Form CO7 and Form CO2",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Memorandum and Articles of Association",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Health, Safety and Environmental (HSE) Policies",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Quality Management Procedure",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Three years TAX Clearance Certificate",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "VAT Registration Certificate",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "A reference letter from the company's bank",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Company's six(6) months bank statement",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Workmen's Compensation Insurance (NSITF)",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "One(1) passport sized photograph of MD/Rep",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label:
                          "Last three(3) years audited financials of the company",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Three(3) sided photograph of Operational Area",
                      isFilePicker: true),
                  SizedBox(height: 10),
                  PageInput(
                      hint: '',
                      label: "Passport of vendors and all directors",
                      isFilePicker: true),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
