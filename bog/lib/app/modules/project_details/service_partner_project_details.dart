import 'package:bog/app/data/model/service_projects_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';

import '../../global_widgets/app_base_view.dart';

import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/new_app_bar.dart';
import 'new_project_details.dart';

class ServicePartnerProjectDetails extends StatefulWidget {
  final ServiceProjectsModel serviceProject;
  const ServicePartnerProjectDetails({super.key, required this.serviceProject});

  @override
  State<ServicePartnerProjectDetails> createState() =>
      _ServicePartnerProjectDetailsState();
}

class _ServicePartnerProjectDetailsState
    extends State<ServicePartnerProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return AppBaseView(
      child: GetBuilder<HomeController>(builder: (controller) {
        return Scaffold(
          appBar: newAppBarBack(context, 'Project Details'),
          backgroundColor: AppColors.backgroundVariant2,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  right: Get.width * 0.05, left: Get.width * 0.045, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Project ID:  ',
                                      style: AppTextStyle.subtitle1.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: widget.serviceProject.projectSlug,
                                      style: AppTextStyle.subtitle1.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600)),
                                ]),
                              ),
                              Text(
                                widget.serviceProject.status ?? '',
                                style: AppTextStyle.caption.copyWith(
                                    color: widget.serviceProject.status ==
                                            'pending'
                                        ? AppColors.serviceYellow
                                        : widget.serviceProject.status ==
                                                'approved'
                                            ? AppColors.successGreen
                                            : Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Request Date: ${DateFormat('dd/mm/yyyy').format(widget.serviceProject.createdAt!)}',
                                style: AppTextStyle.caption
                                    .copyWith(color: AppColors.ashColor),
                              ),
                              Text(
                                widget.serviceProject.endDate.toString(),
                                style: AppTextStyle.caption
                                    .copyWith(color: AppColors.ashColor),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Divider(
                              color: AppColors.newAsh.withOpacity(0.3),
                              thickness: 1),
                          Row(
                            children: [
                              Container(
                                width: Get.width * 0.25,
                                height: Get.width * 0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/dummy_image.png'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(width: Get.width * 0.02),
                              SizedBox(
                                height: Get.width * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ColoredRow(
                                        color: AppColors.primary,
                                        content:
                                            widget.serviceProject.title ?? '',
                                        title: 'Project Name'),
                                    ColoredRow(
                                        color: AppColors.serviceYellow
                                            .withOpacity(0.7),
                                        content: widget
                                                .serviceProject.projectTypes ??
                                            '',
                                        title: 'Service Required'),
                                    ColoredRow(
                                        color: AppColors.successGreen
                                            .withOpacity(0.3),
                                        content:
                                            'NGN ${widget.serviceProject.estimatedCost.toString()}',
                                        title: 'Project Cost'),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Project Completion Rate: ${widget.serviceProject.servicePartnerProgress ?? 0}%',
                            style: AppTextStyle.caption
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(height: Get.height * 0.01),
                          TweenAnimationBuilder(
                            tween: Tween<double>(
                                begin: 0,
                                end: (widget.serviceProject
                                            .servicePartnerProgress ??
                                        0)
                                    .toDouble()),
                            duration: const Duration(milliseconds: 1000),
                            builder: (context, double value, _) =>
                                LinearProgressIndicator(
                              backgroundColor: AppColors.newAsh,
                              minHeight: 5,
                              color: (value / 100) < 0.5
                                  ? Colors.red
                                  : Colors.green,
                              value: (value / 100),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IntrinsicWidth(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transactions',
                                  style: AppTextStyle.caption2
                                      .copyWith(color: Colors.black),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: AppColors.newAsh.withOpacity(0.3),
                                ),
                                SizedBox(
                                    width: Get.width * 0.375,
                                    height: Get.height * 0.3,
                                    child: Center(
                                      child: Text(
                                        'No transactions available currently',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.caption2
                                            .copyWith(color: Colors.black),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IntrinsicWidth(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cost Summary',
                                  style: AppTextStyle.caption2
                                      .copyWith(color: Colors.black),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: AppColors.newAsh.withOpacity(0.3),
                                ),
                                SizedBox(
                                    width: Get.width * 0.375,
                                    height: Get.height * 0.3,
                                    child: Center(
                                      child: Text(
                                        'No summary available currently',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.caption2
                                            .copyWith(color: Colors.black),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.01),
                ],
              ),
            ),
          ),
          bottomNavigationBar: HomeBottomWidget(
              isHome: false, controller: controller, doubleNavigate: false),
        );
      }),
    );
  }
}
