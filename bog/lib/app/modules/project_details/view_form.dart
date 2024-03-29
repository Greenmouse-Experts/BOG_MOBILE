import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/client_project_model.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/new_app_bar.dart';

class ViewFormPage extends StatefulWidget {
  final String id;
  const ViewFormPage({super.key, required this.id});

  @override
  State<ViewFormPage> createState() => _ViewFormPageState();
}

class _ViewFormPageState extends State<ViewFormPage> {
  late Future<ApiResponse> getFormDetails;

  @override
  void initState() {
    final controller = Get.find<HomeController>();

    getFormDetails =
        controller.userRepo.getData('/projects/v2/view-project/${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    return AppBaseView(
        child: Scaffold(
      appBar: newAppBarBack(context, 'Project Form'),
      body: SingleChildScrollView(
        child: FutureBuilder<ApiResponse>(
            future: getFormDetails,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data!.isSuccessful) {
                final response = snapshot.data!.data;
                final clientProject = ClientProjectModel.fromJson(response);
                final projectData = clientProject.projectData!;
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.3,
                            child: Text(
                              'Project Type',
                              style: AppTextStyle.subtitle1.copyWith(
                                  fontSize: multiplier * 0.06,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            clientProject.title ?? '',
                            maxLines: 2,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Divider(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: projectData.length,
                          itemBuilder: (ctx, i) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width * 0.3,
                                      child: Text(
                                        projectData[i].serviceForm!.label!,
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.06,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: Get.width * 0.5,
                                      child:
                                          projectData[i].serviceForm!.label ==
                                                      'PHOTO' ||
                                                  projectData[i]
                                                          .serviceForm!
                                                          .label ==
                                                      'PASSPORT' ||
                                                  projectData[i]
                                                      .value!
                                                      .endsWith('.jpg') ||
                                                  projectData[i]
                                                      .value!
                                                      .endsWith('.png') ||
                                                  projectData[i]
                                                      .value!
                                                      .endsWith('.jpeg')
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    height: Get.width * 0.25,
                                                    width: Get.width * 0.25,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Image.network(
                                                        projectData[i].value!,
                                                        height:
                                                            Get.width * 0.25,
                                                        width: Get.width * 0.25,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  projectData[i].value!,
                                                  maxLines: 2,
                                                ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Divider(
                                  color: Colors.grey.withOpacity(0.3),
                                )
                              ],
                            );
                          }),
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
            }),
      ),
    ));
  }
}
