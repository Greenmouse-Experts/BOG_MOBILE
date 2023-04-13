import 'package:bog/app/data/model/admin_progress_model.dart';
import 'package:bog/app/global_widgets/app_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

import '../../../core/theme/theme.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/client_project_model.dart';

import '../../data/providers/api_response.dart';

import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/new_app_bar.dart';
import '../../global_widgets/page_input.dart';

class NewProjectDetailPage extends StatefulWidget {
  final String id;
  final bool isClient;
  const NewProjectDetailPage(
      {super.key, required this.id, required this.isClient});

  @override
  State<NewProjectDetailPage> createState() => _NewProjectDetailPageState();
}

class _NewProjectDetailPageState extends State<NewProjectDetailPage> {
  late Future<ApiResponse> getProjectDetails;
  late Future<ApiResponse> getAdminUpdate;

  @override
  void initState() {
    final controller = Get.find<HomeController>();

    getProjectDetails =
        controller.userRepo.getData('/projects/v2/view-project/${widget.id}');
    getAdminUpdate = controller.userRepo
        .getData('/projects/notification/${widget.id}/view?type=cost');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
      child: GetBuilder<HomeController>(builder: (controller) {
        return Scaffold(
          appBar: newAppBarBack(context, 'Project Details'),
          backgroundColor: AppColors.backgroundVariant2,
          body: SingleChildScrollView(
            child: FutureBuilder<List<ApiResponse>>(
              future: Future.wait([getProjectDetails, getAdminUpdate]),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const AppLoader();
                } else {
                  if (snapshot.hasData) {
                    final response1 = snapshot.data![0].data;
                    final clientProject =
                        ClientProjectModel.fromJson(response1);
                    final response2 = snapshot.data![1].data as List<dynamic>;
                    final adminUpdates = <AdminProgressModel>[];
                    for (var element in response2) {
                      adminUpdates.add(AdminProgressModel.fromJson(element));
                    }
                    return Padding(
                      padding: EdgeInsets.only(
                          right: Get.width * 0.05,
                          left: Get.width * 0.045,
                          top: 10),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: 'Project ID:  ',
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          TextSpan(
                                              text: clientProject.projectSlug,
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ]),
                                      ),
                                      Text(
                                        clientProject.status ?? '',
                                        style: AppTextStyle.caption.copyWith(
                                            color: clientProject.status ==
                                                    'pending'
                                                ? AppColors.serviceYellow
                                                : clientProject.status ==
                                                        'approved'
                                                    ? AppColors.successGreen
                                                    : Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Request Date: ${DateFormat('dd/MMM/yyyy').format(clientProject.createdAt ?? DateTime.now())}',
                                        style: AppTextStyle.caption.copyWith(
                                            color: AppColors.ashColor),
                                      ),
                                      Text(
                                        clientProject.totalEndDate == null
                                            ? ''
                                            : 'Due Date: ${DateFormat('dd/MMM/yyyy').format(clientProject.totalEndDate!)}',
                                        style: AppTextStyle.caption.copyWith(
                                            color: AppColors.ashColor),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/dummy_image.png'),
                                                fit: BoxFit.cover)),
                                      ),
                                      SizedBox(width: Get.width * 0.02),
                                      SizedBox(
                                        height: Get.width * 0.2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ColoredRow(
                                                color: AppColors.primary,
                                                content:
                                                    clientProject.title ?? '',
                                                title: 'Project Name'),
                                            ColoredRow(
                                                color: AppColors.serviceYellow
                                                    .withOpacity(0.7),
                                                content: clientProject
                                                        .projectTypes ??
                                                    '',
                                                title: 'Service Required'),
                                            ColoredRow(
                                                color: AppColors.successGreen
                                                    .withOpacity(0.3),
                                                content:
                                                    'NGN ${clientProject.totalCost ?? 0}',
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
                                    'Project Completion Rate: ${clientProject.progress ?? 0}%',
                                    style: AppTextStyle.caption
                                        .copyWith(color: Colors.black),
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  TweenAnimationBuilder(
                                    tween: Tween<double>(
                                        begin: 0,
                                        end: (clientProject.progress ?? 0)
                                            .toDouble()),
                                    duration:
                                        const Duration(milliseconds: 1000),
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
                                      'Admin Progress Updates',
                                      style: AppTextStyle.caption2
                                          .copyWith(color: Colors.black),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: AppColors.newAsh.withOpacity(0.3),
                                    ),
                                    SizedBox(
                                        width: Get.width,
                                        height: Get.height * 0.3,
                                        child: Center(
                                          child: adminUpdates.isEmpty
                                              ? Text(
                                                  'No updates available currently',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle.caption2
                                                      .copyWith(
                                                          color: Colors.black),
                                                )
                                              : ListView.builder(
                                                  itemCount:
                                                      adminUpdates.length,
                                                  itemBuilder: (context, i) {
                                                    final update =
                                                        adminUpdates[i];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: ListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        leading: SizedBox(
                                                          width:
                                                              Get.width * 0.16,
                                                          height:
                                                              Get.width * 0.16,
                                                          child: AppAvatar(
                                                            name: 'Admin',
                                                            radius: Get.width *
                                                                0.16,
                                                            imgUrl: '',
                                                          ),
                                                        ),
                                                        title: Text(
                                                          (update.by ?? '')
                                                              .toUpperCase(),
                                                          style: AppTextStyle
                                                              .subtitle1
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      Get.width *
                                                                          0.04),
                                                        ),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              update.body ?? '',
                                                              style: AppTextStyle
                                                                  .subtitle1
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          Get.width *
                                                                              0.035),
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.005),
                                                            Text(
                                                              timeago
                                                                      .format(update
                                                                              .createdAt ??
                                                                          DateTime
                                                                              .now())
                                                                      .capitalizeFirst ??
                                                                  '',
                                                              style: AppTextStyle
                                                                  .subtitle1
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          Get.width *
                                                                              0.035),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: update
                                                                    .image ==
                                                                null
                                                            ? const SizedBox
                                                                .shrink()
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: update
                                                                      .image!,
                                                                  height:
                                                                      Get.width *
                                                                          0.2,
                                                                  width:
                                                                      Get.width *
                                                                          0.2,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                      ),
                                                    );
                                                  }),
                                        )),
                                  ],
                                ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Transactions',
                                          style: AppTextStyle.caption2
                                              .copyWith(color: Colors.black),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color:
                                              AppColors.newAsh.withOpacity(0.3),
                                        ),
                                        SizedBox(
                                            width: Get.width * 0.375,
                                            height: Get.height * 0.3,
                                            child: Center(
                                              child: Text(
                                                'No transactions available currently',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.caption2
                                                    .copyWith(
                                                        color: Colors.black),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cost Summary',
                                          style: AppTextStyle.caption2
                                              .copyWith(color: Colors.black),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color:
                                              AppColors.newAsh.withOpacity(0.3),
                                        ),
                                        SizedBox(
                                            width: Get.width * 0.375,
                                            height: Get.height * 0.3,
                                            child: Center(
                                              child: Text(
                                                'No summary available currently',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.caption2
                                                    .copyWith(
                                                        color: Colors.black),
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
                          const PageInput(
                            hint: 'Leave review',
                            label: 'Review Order',
                            isTextArea: true,
                          ),
                          SizedBox(height: Get.height * 0.01),
                          AppButton(
                            title: 'Submit Review',
                            onPressed: () {},
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('An error occurred, Please Try again'),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('An error occurred'),
                    );
                  }
                }
              },
            ),
          ),
          bottomNavigationBar: HomeBottomWidget(
              isHome: false, controller: controller, doubleNavigate: false),
        );
      }),
    );
  }
}

class RowTitle extends StatelessWidget {
  const RowTitle({
    super.key,
    required this.detail,
    required this.title,
  });

  final String detail;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey.withOpacity(0.9), fontSize: 16),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          detail,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class ColoredRow extends StatelessWidget {
  final Color color;
  final String title;
  final String content;
  const ColoredRow(
      {super.key,
      required this.color,
      required this.content,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          VerticalDivider(
            thickness: 3,
            width: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '$title:  ',
                style: AppTextStyle.subtitle2.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal)),
            TextSpan(
                text: content,
                style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w500)),
          ]))
        ],
      ),
    );
  }
}
