import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

import '../../controllers/home_controller.dart';
import '../../data/model/work_experience_model.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/new_app_bar.dart';
import '../../global_widgets/overlays.dart';
import 'update_work_experience.dart';

class WorkExperience extends StatefulWidget {
  final Map<String, dynamic> kycScore;
  final Map<String, dynamic> kycTotal;
  const WorkExperience(
      {super.key, required this.kycScore, required this.kycTotal});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';

    final getWorkExperiences = controller.userRepo
        .getData('/kyc-work-experience/fetch?userType=$userType');
    return AppBaseView(
      child: Scaffold(
        appBar: newAppBarBack(context, 'Add Work Exerience'),
        body: FutureBuilder<ApiResponse>(
            future: getWorkExperiences,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data!.isSuccessful) {
                final response = snapshot.data!.data as List<dynamic>;
                final List<WorkExperienceModel> experience = [];
                for (var element in response) {
                  experience.add(WorkExperienceModel.fromJson(element));
                }
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: experience.length,
                          itemBuilder: (ctx, i) {
                            return ListTile(
                              title: Text(
                                'Job entry ${i + 1}',
                                style: const TextStyle(color: Colors.black),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      AppOverlay.showInfoDialog(
                                          title: 'Delete Experience',
                                          content:
                                              'Are you sure you want to delete this work experience?',
                                          doubleFunction: true,
                                          onPressed: () async {
                                            final controller =
                                                Get.find<HomeController>();
                                            final response = await controller
                                                .userRepo
                                                .deleteData(
                                                    '/kyc-work-experience/delete/${experience[i].id}');
                                            if (response.isSuccessful) {
                                              Get.back();
                                              Get.back();
                                              Get.snackbar('Success',
                                                  'Work experience deleted successfullys',
                                                  backgroundColor: Colors.green,
                                                  colorText:
                                                      AppColors.background);
                                              setState(() {});
                                            } else {
                                              Get.back();
                                              Get.snackbar(
                                                  'Error', 'An error occurred',
                                                  colorText:
                                                      AppColors.background,
                                                  backgroundColor: Colors.red);
                                            }
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Get.to(() => UpdateWorkExperience(
                                            kycScore: widget.kycScore,
                                            kycTotal: widget.kycTotal,
                                            isNewWork: false,
                                            workExperience: experience[i],
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.visibility_outlined,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      const SizedBox(height: 10),
                      AppButton(
                        title: 'Add new work experience',
                        onPressed: () async {
                          if (experience.length < 6) {
                            await Get.to(() => UpdateWorkExperience(
                                kycScore: widget.kycScore,
                                kycTotal: widget.kycTotal,
                                isNewWork: true));
                          } else {
                            Get.snackbar("Error",
                                "You can't add more than 5 working experiences",
                                colorText: Colors.white,
                                backgroundColor: Colors.red);
                          }
                        },
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('An error occurred'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }),
      ),
    );
  }
}
