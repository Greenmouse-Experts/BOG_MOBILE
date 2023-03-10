import 'dart:convert';

import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/modules/project_details/project_info.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/project_list_model.dart';
import '../../data/providers/api.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/page_dropdown.dart';
import '../home/pages/CartTab.dart';
import 'add_activity.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({Key? key}) : super(key: key);

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails>
    with TickerProviderStateMixin {
  int currentPos = 0;
  late TabController tabController;
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var lgaController = TextEditingController(text: 'Eti Osa');
  var sizeController = TextEditingController(text: '0 - 1000 sq.m');
  var typeController = TextEditingController(text: 'Residential');
  var surveyController = TextEditingController(text: 'Perimeter Survey');

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var project = Get.arguments as ProjectListModel;
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: GetBuilder<HomeController>(
          id: 'ProjectDetails',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
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
                                  project.title.toString(),
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
                    TabBar(
                      controller: tabController,
                      padding: EdgeInsets.zero,
                      labelColor: Colors.black,
                      unselectedLabelColor: const Color(0xff9A9A9A),
                      indicatorColor: AppColors.primary,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.only(
                          left: width * 0.045, right: width * 0.045),
                      labelStyle: TextStyle(
                        fontSize: Get.width * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: Get.width * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                      tabs: const [
                        Tab(
                          text: 'Details',
                          iconMargin: EdgeInsets.zero,
                        ),
                        Tab(
                          text: 'Activity',
                          iconMargin: EdgeInsets.zero,
                        ),
                      ],
                      onTap: (index) {},
                    ),
                    Container(
                      height: 1,
                      width: width,
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: Get.height * 0.78,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/Rectangle 18671.png',
                                  fit: BoxFit.fitWidth,
                                  width: width,
                                  height: Get.height * 0.2,
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                _TextButton(
                                  text: "Project Info",
                                  onPressed: () {
                                    Get.to(() => const ProjectInfo(),
                                        arguments: project);
                                  },
                                  imageAsset: "assets/images/oneC.png",
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                _TextButton(
                                  text: "Photos & Notes ",
                                  onPressed: () {},
                                  imageAsset: "assets/images/twoC.png",
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                _TextButton(
                                  text: "Messages & Meetings",
                                  onPressed: () {},
                                  imageAsset: "assets/images/threeC.png",
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                _TextButton(
                                  text: "Uploaded Documents",
                                  onPressed: () {},
                                  imageAsset: "assets/images/fourC.png",
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                _TextButton(
                                  text: "Project Costing",
                                  onPressed: () {},
                                  imageAsset: "assets/images/fourC.png",
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.78,
                                  child: ListView.builder(
                                    itemCount: 4,
                                    shrinkWrap: false,
                                    padding: EdgeInsets.only(
                                        left: width * 0.02,
                                        right: width * 0.02),
                                    itemBuilder: (context, index) {
                                      return SizedBox(
                                        height: Get.height * 0.08,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.13,
                                              height: Get.width * 0.13,
                                              child: IconButton(
                                                icon: Image.asset(
                                                  "assets/images/Ellipse 956.png",
                                                  fit: BoxFit.cover,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                    "BOG added a file to your Building \nproject",
                                                style: AppTextStyle.subtitle1
                                                    .copyWith(
                                                        fontSize:
                                                            multiplier * 0.07,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: "  2 hours ago",
                                                    style: AppTextStyle
                                                        .subtitle1
                                                        .copyWith(
                                                            fontSize:
                                                                multiplier *
                                                                    0.05,
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: AppColors.backgroundVariant2,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.homeIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.homeTitle,
                      backgroundColor: AppColors.background,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.currentBottomNavPage.value == 1
                              ? 'assets/images/chat_filled.png'
                              : 'assets/images/chatIcon.png',
                          width: 22,
                          //color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.projectIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.projectTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.cartIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.cartTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.profileIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: controller.currentBottomNavPage.value,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    controller.currentBottomNavPage.value = index;
                    controller.updateNewUser(controller.currentType);
                    Get.back();
                  }),
              floatingActionButton: (tabController.index == 1 &&
                      controller.currentType == "Service Partner")
                  ? FloatingActionButton(
                      onPressed: () {
                        Get.to(() => const AddActivity());
                      },
                      backgroundColor: AppColors.primary,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: Get.width * 0.05,
                            height: Get.width * 0.05,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: Get.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
            );
          }),
    );
  }
}

class _TextButton extends StatelessWidget {
  final String imageAsset;
  final String text;
  final String? subtitle;
  final bool showArrow;
  final Function() onPressed;
  const _TextButton(
      {required this.imageAsset,
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
                child: Image.asset(
                  imageAsset,
                  width: Get.width * 0.05,
                  height: Get.width * 0.05,
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
                      Icons.arrow_forward_ios_rounded,
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
