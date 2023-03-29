import 'package:bog/app/global_widgets/overlays.dart';
import 'package:bog/app/modules/settings/update_work_experience.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/work_experience_model.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_button.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
 // late Future<ApiResponse> getWorkExperiences;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    final userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    //print(userType);
    // getWorkExperiences = controller.userRepo
    //     .getData('/kyc-work-experience/fetch?userType=$userType');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    final controller = Get.find<HomeController>();
    final userType =
        controller.currentType == 'Product Partner' ? 'vendor' : 'professional';
    //print(userType);
   final getWorkExperiences = controller.userRepo
        .getData('/kyc-work-experience/fetch?userType=$userType');
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
            "Add Work Experience",
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
                                      AppOverlay.showInfoDialog(title: 'Delete Experience', 
                                      content: 'Are you sure you want to delete this work experience?',
                                      doubleFunction: true,
                                      onPressed: () async{
                                        final controller = Get.find<HomeController>();
                                        final response = await controller.userRepo.deleteData('/kyc-work-experience/delete/${experience[i].id}');
                                        if (response.isSuccessful){
                                          Get.back();
                                          Get.back();
                                          Get.snackbar('Success', 'Work experience deleted successfullys', backgroundColor: Colors.green);
                                          setState(() {
                                            
                                          });
                                        } else{
                                          Get.back();
                                          Get.snackbar('Error', 'An error occurred');
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
                       
                    final response =  await Get.to(() =>
                              const UpdateWorkExperience(isNewWork: true));
                        
                          
                        
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
