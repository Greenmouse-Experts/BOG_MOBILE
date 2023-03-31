import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/client_project_model.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/page_input.dart';

class NewProjectDetailPage extends StatefulWidget {
  final String id;
  const NewProjectDetailPage({super.key, required this.id});

  @override
  State<NewProjectDetailPage> createState() => _NewProjectDetailPageState();
}

class _NewProjectDetailPageState extends State<NewProjectDetailPage> {
  late Future<ApiResponse> getProjectDetails;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    getProjectDetails =
        controller.userRepo.getData('/projects/v2/view-project/${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    return AppBaseView(
        child: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(
                  color: AppColors.grey.withOpacity(0.3),
                ),
              ),
              title: Text(
                "Product Details",
                style: AppTextStyle.subtitle1.copyWith(
                    fontSize: multiplier * 0.07,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            ),
            backgroundColor: AppColors.backgroundVariant2,
            body: FutureBuilder<ApiResponse>(
                future: getProjectDetails,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data!.isSuccessful) {
                    final response = snapshot.data!.data;
                    final clientProject = ClientProjectModel.fromJson(response);
                    return Padding(
                      padding: EdgeInsets.only(
                          right: Get.width * 0.05,
                          left: Get.width * 0.045,
                          top: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ID:   ${clientProject.projectSlug}',
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.07,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.primary.withOpacity(0.25)),
                            child: Text(
                              'Status: ${clientProject.status}',
                              style: AppTextStyle.subtitle1.copyWith(
                                  fontSize: multiplier * 0.07,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RowTitle(
                              title: 'Project Name',
                              detail: clientProject.title ?? ''),
                          const SizedBox(height: 10),
                          RowTitle(
                              title: 'Service Required',
                              detail: clientProject.projectTypes ?? ''),
                          const SizedBox(height: 10),
                          RowTitle(
                              title: 'Start Date',
                              detail: clientProject.endDate ?? ''),
                          const SizedBox(height: 10),
                          RowTitle(
                              title: 'Due Date',
                              detail: clientProject.endDate ?? ''),
                          const SizedBox(height: 10),
                          RowTitle(
                              title: 'Project Cost',
                              detail: clientProject.endDate ?? ''),
                          const SizedBox(height: 10),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey.withOpacity(0.1),
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey.withOpacity(0.1),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Transaction Reference',
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.07,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: Get.width * 0.3,
                                    child: const Text(
                                      'Payment Ref: ',
                                      maxLines: 2,
                                    )),
                               const Text('data'),
                                // Text(
                                //    DateFormat.yMd()
                                //     .format(orderDetail.createdAt!)),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 8),
                                //   child: Text(
                                //       '${orderDetail.orderItems![0].paymentInfo!.amount}'),
                                // )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Review Order',
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.07,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const PageInput(
                            hint: 'Leave review',
                            label: '',
                            isTextArea: true,
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
                    return const AppLoader();
                  }

                  //return CircularProgressIndicator();
                })));
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
