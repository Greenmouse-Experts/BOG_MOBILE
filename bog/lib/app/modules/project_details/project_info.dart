import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/projetcs_model.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/bottom_widget.dart';

class ProjectInfo extends StatefulWidget {
  const ProjectInfo({Key? key}) : super(key: key);

  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var project = Get.arguments as MyProjects;
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'ProjectInfo',
          builder: (controller) {
            return Scaffold(
                backgroundColor: AppColors.backgroundVariant2,
                body: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.78,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: kToolbarHeight),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                  "assets/images/back.svg",
                                  height: width * 0.045,
                                  width: width * 0.045,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.04,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Project Info",
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.04,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: width * 0.04,
                        ),
                        Container(
                          height: 1,
                          width: width,
                          color: AppColors.grey.withOpacity(0.1),
                        ),
                        Image.asset(
                          'assets/images/Rectangle 18671.png',
                          fit: BoxFit.cover,
                          width: width,
                          height: Get.height * 0.2,
                        ),
                        SizedBox(
                          height: width * 0.04,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            "Project Name",
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.065,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: width * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            project.title.toString(),
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.068,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: width * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            "Project ID",
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.065,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: width * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            project.id.toString(),
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.068,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: width * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            "Service Type",
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.065,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: width * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            project.projectTypes
                                .toString()
                                .capitalizeFirst
                                .toString()
                                .replaceAll("_", " "),
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.068,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: width * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            "Project Description",
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.065,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: width * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            project.description == null
                                ? "No Description Available"
                                : project.description.toString(),
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.068,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: width * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            "Service Location",
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.065,
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: width * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.05,
                              left: width * 0.045,
                              top: 10),
                          child: Text(
                            "No 7, Street close, Ogba Ikeja, Lagos",
                            style: AppTextStyle.subtitle1.copyWith(
                                fontSize: multiplier * 0.068,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: HomeBottomWidget(
                  controller: controller,
                  isHome: false,
                  doubleNavigate: false,
                ));
          }),
    );
  }
}

// 