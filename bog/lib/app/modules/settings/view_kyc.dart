import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';
import 'package:bog/app/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/custom_app_bar.dart';
import 'update_financial_data.dart';
import 'update_general.dart';
import 'update_organisation_info.dart';
import 'update_tax_details.dart';
import 'upload_documents.dart';
import 'view_work_experience.dart';

class KYCPage extends StatelessWidget {
  const KYCPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    return AppBaseView(
        child: Scaffold(
      appBar: newAppBar(context, 'KYC', true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future:
                    controller.userRepo.getData('/user/me?userType=$userType'),
                builder: (ctx, snapshot) {
                  return Text(snapshot.connectionState.toString());
                }),
            _TextButton(
                iconData: Icons.info,
                text: 'General Information',
                onPressed: () {
                  Get.to(() => const UpdateGeneralInfo());
                }),
            _TextButton(
                iconData: Icons.info_outline_sharp,
                text: 'Organisational Info',
                onPressed: () {
                  Get.to(() => const UpdateOrganisationInfo());
                }),
            _TextButton(
                iconData: Icons.credit_score_outlined,
                text: 'Tax Details & Permit',
                onPressed: () {
                  Get.to(() => const UpdateTaxDetails());
                }),
            _TextButton(
                iconData: Icons.work,
                text: 'Work/Job Execution Experience',
                onPressed: () {
                  Get.to(() => const WorkExperience());
                }),
            _TextButton(
                iconData: Icons.money,
                text: 'Financial Data',
                onPressed: () {
                  Get.to(() => const UpdateFinancialDetails());
                }),
            _TextButton(
                iconData: Icons.upload_file,
                text: 'Upload Documents',
                onPressed: () {
                  Get.to(() => const UploadDocuments());
                })
          ],
        ),
      ),
    ));
  }
}

class Header extends StatelessWidget {
  final String header;
  final VoidCallback onPressed;
  const Header({super.key, required this.header, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: AppTextStyle.headline5.copyWith(color: Colors.black),
          ),
          IconButton(
              onPressed: () {
                onPressed();
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}

class KYCDetails extends StatelessWidget {
  const KYCDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        'data: Paol',
        style: AppTextStyle.bodyText2.copyWith(fontSize: 18),
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final String? subtitle;
  final bool showArrow;
  final Function() onPressed;
  const _TextButton(
      {required this.iconData,
      required this.text,
      required this.onPressed,
      this.subtitle,
      this.showArrow = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width * 0.1,
              height: Get.width * 0.1,
              decoration: BoxDecoration(
                color: const Color(0xffE8F4FE),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Icon(
                  iconData,
                  size: Get.width * 0.05,
                  color: AppColors.primary,
                  // height: Get.width * 0.05,
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.7,
              child: Padding(
                padding: EdgeInsets.only(left: Get.width * 0.01),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: AppTextStyle.subtitle1.copyWith(
                            color: text == "Log Out"
                                ? AppColors.bostonUniRed
                                : Colors.black,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: AppTextStyle.subtitle1
                              .copyWith(color: Colors.black),
                        ),
                      if (subtitle != null)
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                    ]),
              ),
            ),
            IconButton(
              onPressed: onPressed,
              padding: EdgeInsets.zero,
              icon: showArrow
                  ? Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: Get.width * 0.04,
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
