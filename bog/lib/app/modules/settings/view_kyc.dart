import 'dart:convert';

import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/data/model/user_details_model.dart';
import 'package:bog/app/data/providers/api_response.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';
import 'package:bog/app/modules/settings/update_supply_category.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../global_widgets/app_base_view.dart';

import 'update_financial_data.dart';
import 'update_general.dart';
import 'update_organisation_info.dart';
import 'update_tax_details.dart';
import 'upload_documents.dart';
import 'view_work_experience.dart';

class KYCPage extends StatefulWidget {
  const KYCPage({super.key});

  @override
  State<KYCPage> createState() => _KYCPageState();
}

class _KYCPageState extends State<KYCPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    return AppBaseView(
        child: Scaffold(
      appBar: newAppBarBack(context, 'KYC'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<ApiResponse>(
              future:
                  controller.userRepo.getData('/user/me?userType=$userType'),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data!.isSuccessful) {
                  final userDetails =
                      UserDetailsModel.fromJson(snapshot.data!.user);
        
                  final kycScore = userDetails.kycScore ?? '';
                  final kycTotal = userDetails.kycTotal ?? '';


                  
                  dynamic totalScore = 0;
                  Map<String, dynamic> kycScoreMap = {};
                  if (kycScore != '0'){
                  kycScoreMap = jsonDecode(kycScore);
                
                  kycScoreMap.forEach((key, value) {
                    totalScore += value;
                  });
                  } 
                
                  Map<String, dynamic> kycTotalMap = {
                    "generalInfo" : 7,
                    "orgInfo" : 9,
                    "taxDetails": 3,
                    "workExperience": 0,
                    "SupplyCat": 1,
                    "financialData" : 6,
                    "uploadDocument": 16,
                  };
                  dynamic totalTotal = 0;
                  if (kycTotal != '0' ){
                  kycTotalMap = jsonDecode(kycTotal);
                  kycTotalMap.forEach((key, value) {
                    totalTotal += value;
                  });
                  }
                   

                var newPoint = (totalScore / totalTotal) * 100;
                  if (totalTotal == 0 && totalScore == 0){
                   newPoint = 0;
                  }
        
                  
                  final kycNewPoint = newPoint == double.nan.isNaN ? 0.0 : newPoint;


                  return kycScore == '0' 
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Kyc Score : $kycNewPoint'),
                            const SizedBox(height: 15),
                            const LinearProgressIndicator(
                              value: 0,
                            ),
                            const SizedBox(height: 15),
                            _TextButton(
                                iconData: Icons.info,
                                text: 'General Information',
                                onPressed: () async {
                                  await Get.to(() => UpdateGeneralInfo(
                                        kycScore: kycScoreMap,
                                        kycTotal: kycTotalMap,
                                      ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.info_outline_sharp,
                                text: 'Organisational Info',
                                onPressed: () async {
                                  await Get.to(
                                      () =>  UpdateOrganisationInfo(
                                         kycScore: kycScoreMap,
                                        kycTotal: kycTotalMap,
                                      ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.credit_score_outlined,
                                text: 'Tax Details & Permit',
                                onPressed: () async {
                                  await Get.to(() =>  UpdateTaxDetails(
                                     kycScore: kycScoreMap,
                                        kycTotal: kycTotalMap,
                                  ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.work,
                                text: 'Work/Job Execution Experience',
                                onPressed: () async {
                                  await Get.to(() => WorkExperience(
                                     kycScore: kycScoreMap,
                                     kycTotal: kycTotalMap,
                                  ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.money,
                                text: 'Financial Data',
                                onPressed: () async {
                                  await Get.to(
                                      () =>  UpdateFinancialDetails(
                                            kycScore: kycScoreMap,
                                     kycTotal: kycTotalMap,
                                      ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.upload_file,
                                text: 'Upload Documents',
                                onPressed: () async {
                                  await Get.to(() => UploadDocuments(
                                     kycScore: kycScoreMap,
                                     kycTotal: kycTotalMap,
                                  ));
                                  setState(() {});
                                })
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Your Kyc Score : ${kycNewPoint.toStringAsFixed(2)}'),
                            const SizedBox(height: 15),
                            TweenAnimationBuilder(
                              tween: Tween<double>(
                                  begin: 0, end: kycNewPoint),
                              duration: const Duration(milliseconds: 1000),
                              builder: (context, double value, _) =>
                                  LinearProgressIndicator(
                                minHeight: 15,
                                color: (value / 100) < 0.5
                                    ? Colors.red
                                    : Colors.green,
                                value: (value / 100),
                              ),
                            ),
                            const SizedBox(height: 15),
                            _TextButton(
                                iconData: Icons.info,
                                text: 'General Information',
                                onPressed: () async {
                                  await Get.to(() => UpdateGeneralInfo(
                                        kycScore: kycScoreMap,
                                        kycTotal: kycTotalMap,
                                      ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.info_outline_sharp,
                                text: 'Organisational Info',
                                onPressed: () async {
                                  await Get.to(
                                      () =>  UpdateOrganisationInfo(
                                         kycScore: kycScoreMap,
                                        kycTotal: kycTotalMap,
                                      ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.credit_score_outlined,
                                text: 'Tax Details & Permit',
                                onPressed: () async {
                                  await Get.to(() =>  UpdateTaxDetails(
                                     kycScore: kycScoreMap,
                                        kycTotal: kycTotalMap,
                                  ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.work,
                                text: 'Work/Job Execution Experience',
                                onPressed: () async {
                                  await Get.to(() => WorkExperience(
                                     kycScore: kycScoreMap,
                                     kycTotal: kycTotalMap,
                                  ));
                                  setState(() {});
                                }),
                                if (userType == 'vendor')
                                  _TextButton(
                                iconData: Icons.category,
                                text: 'Categories of Supply',
                                onPressed: () async {
                                  await Get.to(() => UpdateSupplyCategory(
                                     kycScore: kycScoreMap,
                                     kycTotal: kycTotalMap,
                                  ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.money,
                                text: 'Financial Data',
                                onPressed: () async {
                                  await Get.to(
                                      () =>  UpdateFinancialDetails(
                                            kycScore: kycScoreMap,
                                     kycTotal: kycTotalMap,
                                      ));
                                  setState(() {});
                                }),
                            _TextButton(
                                iconData: Icons.upload_file,
                                text: 'Upload Documents',
                                onPressed: () async {
                                  await Get.to(() =>  UploadDocuments(
                                     kycScore: kycScoreMap,
                                     kycTotal: kycTotalMap,
                                  ));
                                  setState(() {});
                                })
                          ],
                        );
                } else {
                  return const AppLoader();
                }
              }),
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
            EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.0, top: 10),
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
