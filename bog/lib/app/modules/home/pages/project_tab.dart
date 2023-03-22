import 'package:bog/app/data/model/projetcs_model.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';

import '../../../data/providers/api_response.dart';

import '../../../global_widgets/app_input.dart';
import '../../../global_widgets/my_project_widget.dart';
import '../../../global_widgets/page_dropdown.dart';
import '../../create/create.dart';
import '../../project_details/project_details.dart';
import 'cart_tab.dart';

class ProjectTab extends StatefulWidget {
  const ProjectTab({Key? key}) : super(key: key);

  @override
  State<ProjectTab> createState() => _ProjectTabState();
}

class _ProjectTabState extends State<ProjectTab> with TickerProviderStateMixin {
  String search = "";
  String currentOrder = "New Order Requests";
  List<MyProjects> savedPosts = [];

  late Future<ApiResponse> getMyProjects;

  double multiplier = 25 * Get.height * 0.01;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<HomeController>();
    final userType = controller.currentType == 'Client'
        ? 'private_client'
        : 'corporate_client';
    getMyProjects =
        controller.userRepo.getData("/projects/my-request/?userType=$userType");
  }

  List<MyProjects> getProjectsByStatus(
      String status, List<MyProjects> projects) {
    final newList =
        projects.where((element) => element.approvalStatus == status).toList();
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Expanded(
        child: Scaffold(
          body: SizedBox(
            height: Get.height * 0.91,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.035,
                      right: Get.width * 0.03,
                      top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "My ${controller.projectTitle}",
                        style: AppTextStyle.subtitle1.copyWith(
                          color: Colors.black,
                          fontSize: Get.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                if (controller.currentType == "Product Partner")
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.03, right: Get.width * 0.03),
                    child: PageDropButtonWithoutBackground(
                      label: "",
                      hint: '',
                      padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                      onChanged: (val) {
                        currentOrder = val;
                        controller.update();
                      },
                      value: "New Order Requests",
                      items: ["New Order Requests", "Ongoing Orders"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: AppTextStyle.subtitle1.copyWith(
                              color: AppColors.primary,
                              fontSize: Get.width * 0.035,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                if (controller.currentType == 'Product' ||
                    controller.currentType == 'Service Partner')
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.03, right: Get.width * 0.03),
                    child: AppInput(
                      hintText: 'Search with name or keyword ...',
                      filledColor: Colors.grey.withOpacity(.1),
                      prefexIcon: Icon(
                        FeatherIcons.search,
                        color: Colors.black.withOpacity(.5),
                        size: Get.width * 0.05,
                      ),
                      onChanged: (value) {
                        search = value;
                        controller.update();
                      },
                    ),
                  ),
                if (controller.currentType == 'Product' ||
                    controller.currentType == 'Service Partner')
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                if (controller.currentType == "Client" ||
                    controller.currentType == "Corporate Client")
                  FutureBuilder<ApiResponse>(
                      future: getMyProjects,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data!.isSuccessful) {
                          final List<MyProjects> posts =
                              MyProjects.fromJsonList(snapshot.data!.data);
                          savedPosts.clear();
                          savedPosts.addAll(posts);
                          print(savedPosts);
                          if (posts.isEmpty) {
                            return SizedBox(
                              height: Get.height * 0.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Projects Available",
                                    style: AppTextStyle.subtitle1.copyWith(
                                        fontSize: multiplier * 0.07,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }

                          final postsToUse = posts
                              .where((post) => post.title
                                  .toString()
                                  .toLowerCase()
                                  .contains(search.toLowerCase()))
                              .toList();

                          List<Tab> tabs = [
                            const Tab(
                              child: Text('All'),
                            ),
                            const Tab(child: Text('Pending')),
                            const Tab(child: Text('Ongoing')),
                            const Tab(child: Text('Completed'))
                          ];

                          final approvedProjects =
                              getProjectsByStatus('approved', postsToUse);
                          final pendingProjects =
                              getProjectsByStatus('pending', postsToUse);
                          final cancelledProjects =
                              getProjectsByStatus('disapproved', postsToUse);

                          List<Widget> contents = [
                            getGroupedProjects(postsToUse, controller),
                            getGroupedProjects(pendingProjects, controller),
                            getGroupedProjects(approvedProjects, controller),
                            getGroupedProjects(cancelledProjects, controller)
                          ];

                          return SizedBox(
                              height: Get.height * 0.78,
                              child: VerticalTabs(
                                  backgroundColor: AppColors.backgroundVariant2,
                                  tabBackgroundColor:
                                      AppColors.backgroundVariant2,
                                  indicatorColor: AppColors.primary,
                                  tabsShadowColor: AppColors.backgroundVariant2,
                                  tabsWidth: Get.width * 0.25,
                                  initialIndex: 0,
                                  tabs: tabs,
                                  contents: contents));

                          //getGroupedProjects(postsToUse);
                        } else if (savedPosts.isNotEmpty) {
                          final posts = savedPosts;
                          if (posts.isEmpty) {
                            return SizedBox(
                              height: Get.height * 0.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Projects Available",
                                    style: AppTextStyle.subtitle1.copyWith(
                                        fontSize: multiplier * 0.07,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                          final postsToUse = posts
                              .where((post) => post.title
                                  .toString()
                                  .toLowerCase()
                                  .contains(search.toLowerCase()))
                              .toList();
                          return Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: GridView.builder(
                              itemCount: postsToUse.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => const ProjectDetails(),
                                        arguments: postsToUse[index]);
                                  },
                                  child: Container(
                                    width: Get.width * 0.35,
                                    height: Get.height * 0.35,
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundVariant2,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color:
                                              AppColors.grey.withOpacity(0.1),
                                          width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: Get.height * 0.1,
                                          decoration: BoxDecoration(
                                            color:
                                                AppColors.grey.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.grey
                                                    .withOpacity(0.1),
                                                width: 1),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: Get.width * 0.01,
                                                left: Get.width * 0.01,
                                                right: Get.width * 0.01),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                "",
                                                fit: BoxFit.cover,
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(
                                                    Icons.tab_rounded,
                                                    color: AppColors.primary,
                                                    size: 25,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.width * 0.02,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.01,
                                              right: Get.width * 0.01),
                                          child: Text.rich(
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                      fontSize:
                                                          multiplier * 0.065,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              TextSpan(
                                                  text: '',
                                                  children:
                                                      highlightOccurrences(
                                                          postsToUse[index]
                                                              .title
                                                              .toString(),
                                                          search))),
                                        ),
                                        SizedBox(
                                          height: Get.width * 0.02,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.01,
                                              right: Get.width * 0.01),
                                          child: Text(
                                            postsToUse[index]
                                                .projectTypes
                                                .toString()
                                                .capitalizeFirst!
                                                .replaceAll("_", " "),
                                            style: AppTextStyle.subtitle1
                                                .copyWith(
                                                    fontSize:
                                                        multiplier * 0.055,
                                                    color: AppColors.primary,
                                                    fontWeight:
                                                        FontWeight.normal),
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.width * 0.02,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: Get.width * 0.01,
                                              right: Get.width * 0.01),
                                          child: Text(
                                            postsToUse[index]
                                                .createdAt
                                                .toString(),
                                            style: AppTextStyle.subtitle1
                                                .copyWith(
                                                    fontSize: multiplier * 0.05,
                                                    color: AppColors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return SizedBox(
                              height: Get.height * 0.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Projects Available",
                                    style: AppTextStyle.subtitle1.copyWith(
                                        fontSize: multiplier * 0.07,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                          return const AppLoader();
                        }
                      }),
                if (controller.currentType == "Product Partner")
                  Expanded(
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return currentOrder == "Ongoing Orders"
                            ? OrderItem(
                                price: '203000',
                                date: DateTime.now(),
                                status: 'Pending',
                                orderItemName: '10 tons of coconut',
                              )
                            : const OrderRequestItem();
                      },
                    ),
                  ),
                if (controller.currentType == "Service Partner")
                  Expanded(
                    child: FutureBuilder<ApiResponse>(
                        future:
                            controller.userRepo.getData("/projects/my-request"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data!.isSuccessful) {
                            final posts =
                                MyProjects.fromJsonList(snapshot.data!.data);
                            savedPosts.clear();
                            savedPosts.addAll(posts);
                            if (posts.isEmpty) {
                              return SizedBox(
                                height: Get.height * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No Projects Available",
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }
                            final postsToUse = posts
                                .where((post) => post.title
                                    .toString()
                                    .toLowerCase()
                                    .contains(search.toLowerCase()))
                                .toList();
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.03,
                                  right: Get.width * 0.03),
                              child: GridView.builder(
                                itemCount: postsToUse.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15),
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => const ProjectDetails(),
                                          arguments: postsToUse[index]);
                                    },
                                    child: Container(
                                      width: Get.width * 0.35,
                                      height: Get.height * 0.35,
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundVariant2,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color:
                                                AppColors.grey.withOpacity(0.1),
                                            width: 1),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            height: Get.height * 0.1,
                                            decoration: BoxDecoration(
                                              color: AppColors.grey
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColors.grey
                                                      .withOpacity(0.1),
                                                  width: 1),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.width * 0.01,
                                                  left: Get.width * 0.01,
                                                  right: Get.width * 0.01),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  "",
                                                  fit: BoxFit.cover,
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                      Icons.tab_rounded,
                                                      color: AppColors.primary,
                                                      size: 25,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.width * 0.02,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.01,
                                                right: Get.width * 0.01),
                                            child: Text.rich(
                                                style: AppTextStyle.subtitle1
                                                    .copyWith(
                                                        fontSize:
                                                            multiplier * 0.065,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                TextSpan(
                                                    text: '',
                                                    children:
                                                        highlightOccurrences(
                                                            postsToUse[index]
                                                                .title
                                                                .toString(),
                                                            search))),
                                          ),
                                          SizedBox(
                                            height: Get.width * 0.02,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.01,
                                                right: Get.width * 0.01),
                                            child: Text(
                                              postsToUse[index]
                                                  .projectTypes
                                                  .toString()
                                                  .capitalizeFirst!
                                                  .replaceAll("_", " "),
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                      fontSize:
                                                          multiplier * 0.055,
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.normal),
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.width * 0.02,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.01,
                                                right: Get.width * 0.01),
                                            child: Text(
                                              postsToUse[index]
                                                  .createdAt
                                                  .toString(),
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                      fontSize:
                                                          multiplier * 0.05,
                                                      color: AppColors.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (savedPosts.isNotEmpty) {
                            final posts = savedPosts;
                            if (posts.isEmpty) {
                              return SizedBox(
                                height: Get.height * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No Projects Available",
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }
                            final postsToUse = posts
                                .where((post) => post.title
                                    .toString()
                                    .toLowerCase()
                                    .contains(search.toLowerCase()))
                                .toList();
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width * 0.03,
                                  right: Get.width * 0.03),
                              child: GridView.builder(
                                itemCount: postsToUse.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15),
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => const ProjectDetails(),
                                          arguments: postsToUse[index]);
                                    },
                                    child: Container(
                                      width: Get.width * 0.35,
                                      height: Get.height * 0.35,
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundVariant2,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color:
                                                AppColors.grey.withOpacity(0.1),
                                            width: 1),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            height: Get.height * 0.1,
                                            decoration: BoxDecoration(
                                              color: AppColors.grey
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColors.grey
                                                      .withOpacity(0.1),
                                                  width: 1),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.width * 0.01,
                                                  left: Get.width * 0.01,
                                                  right: Get.width * 0.01),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  "",
                                                  fit: BoxFit.cover,
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                      Icons.tab_rounded,
                                                      color: AppColors.primary,
                                                      size: 25,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.width * 0.02,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.01,
                                                right: Get.width * 0.01),
                                            child: Text.rich(
                                                style: AppTextStyle.subtitle1
                                                    .copyWith(
                                                        fontSize:
                                                            multiplier * 0.065,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                TextSpan(
                                                    text: '',
                                                    children:
                                                        highlightOccurrences(
                                                            postsToUse[index]
                                                                .title
                                                                .toString(),
                                                            search))),
                                          ),
                                          SizedBox(
                                            height: Get.width * 0.02,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.01,
                                                right: Get.width * 0.01),
                                            child: Text(
                                              postsToUse[index]
                                                  .projectTypes
                                                  .toString()
                                                  .capitalizeFirst!
                                                  .replaceAll("_", " "),
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                      fontSize:
                                                          multiplier * 0.055,
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.normal),
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.width * 0.02,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.01,
                                                right: Get.width * 0.01),
                                            child: Text(
                                              postsToUse[index]
                                                  .createdAt
                                                  .toString(),
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                      fontSize:
                                                          multiplier * 0.05,
                                                      color: AppColors.grey,
                                                      fontWeight:
                                                          FontWeight.normal),
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return SizedBox(
                                height: Get.height * 0.65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "No Projects Available",
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }
                            return SizedBox(
                              height: Get.height * 0.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                  ),
              ],
            ),
          ),
          floatingActionButton: controller.currentType == "Product Partner" ||
                  controller.currentType == "Service Partner"
              ? FloatingActionButton(
                  onPressed: () {
                    //Get.toNamed(Create.route);
                  },
                  backgroundColor: AppColors.primary,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: Get.width * 0.05,
                        height: Get.width * 0.05,
                        child: Image.asset(
                          "assets/images/Group 46942.png",
                          fit: BoxFit.contain,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(Create.route);
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
                ),
        ),
      );
    });
  }

  Padding getGroupedProjects(
      List<MyProjects> postsToUse, HomeController controller) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: ListView.builder(
            itemCount: postsToUse.length,
            itemBuilder: (ctx, i) {
              return MyProjectWidget(
                id: postsToUse[i].id ?? '',
                controller: controller,
                projectType: postsToUse[i].projectTypes ?? '',
                orderSlug: postsToUse[i].projectSlug ?? '',
              );
            })
        // GridView.builder(
        //   itemCount: postsToUse.length,
        //   gridDelegate:
        //       const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           mainAxisSpacing: 15,
        //           crossAxisSpacing: 15),
        //   scrollDirection: Axis.vertical,
        //   padding: const EdgeInsets.all(0),
        //   shrinkWrap: true,
        //   itemBuilder: (BuildContext context, int index) {
        //     return InkWell(
        //       onTap: () {
        //         Get.to(() => const ProjectDetails(),
        //             arguments: postsToUse[index]);
        //       },
        //       child: Container(
        //         width: Get.width * 0.35,
        //         height: Get.height * 0.35,
        //         decoration: BoxDecoration(
        //           color: AppColors.backgroundVariant2,
        //           borderRadius: BorderRadius.circular(10),
        //           border: Border.all(
        //               color:
        //                   AppColors.grey.withOpacity(0.1),
        //               width: 1),
        //         ),
        //         child: Column(
        //           crossAxisAlignment:
        //               CrossAxisAlignment.stretch,
        //           children: [
        //             Container(
        //               height: Get.height * 0.1,
        //               decoration: BoxDecoration(
        //                 color:
        //                     AppColors.grey.withOpacity(0.1),
        //                 borderRadius:
        //                     BorderRadius.circular(10),
        //                 border: Border.all(
        //                     color: AppColors.grey
        //                         .withOpacity(0.1),
        //                     width: 1),
        //               ),
        //               child: Padding(
        //                 padding: EdgeInsets.only(
        //                     top: Get.width * 0.01,
        //                     left: Get.width * 0.01,
        //                     right: Get.width * 0.01),
        //                 child: ClipRRect(
        //                   borderRadius:
        //                       BorderRadius.circular(10),
        //                   child: Image.network(
        //                     "",
        //                     fit: BoxFit.cover,
        //                     color: Colors.black
        //                         .withOpacity(0.2),
        //                     errorBuilder: (context, error,
        //                         stackTrace) {
        //                       return const Icon(
        //                         Icons.tab_rounded,
        //                         color: AppColors.primary,
        //                         size: 25,
        //                       );
        //                     },
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             SizedBox(
        //               height: Get.width * 0.02,
        //             ),
        //             Padding(
        //               padding: EdgeInsets.only(
        //                   left: Get.width * 0.01,
        //                   right: Get.width * 0.01),
        //               child: Text.rich(
        //                   style: AppTextStyle.subtitle1
        //                       .copyWith(
        //                           fontSize:
        //                               multiplier * 0.065,
        //                           color: Colors.black,
        //                           fontWeight:
        //                               FontWeight.w600),
        //                   textAlign: TextAlign.start,
        //                   maxLines: 1,
        //                   overflow: TextOverflow.ellipsis,
        //                   TextSpan(
        //                       text: '',
        //                       children:
        //                           highlightOccurrences(
        //                               postsToUse[index]
        //                                   .title
        //                                   .toString(),
        //                               search))),
        //             ),
        //             SizedBox(
        //               height: Get.width * 0.02,
        //             ),
        //             Padding(
        //               padding: EdgeInsets.only(
        //                   left: Get.width * 0.01,
        //                   right: Get.width * 0.01),
        //               child: Text(
        //                 postsToUse[index]
        //                     .projectTypes
        //                     .toString()
        //                     .capitalizeFirst!
        //                     .replaceAll("_", " "),
        //                 style: AppTextStyle.subtitle1
        //                     .copyWith(
        //                         fontSize:
        //                             multiplier * 0.055,
        //                         color: AppColors.primary,
        //                         fontWeight:
        //                             FontWeight.normal),
        //                 textAlign: TextAlign.start,
        //                 maxLines: 1,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //             ),
        //             SizedBox(
        //               height: Get.width * 0.02,
        //             ),
        //             Padding(
        //               padding: EdgeInsets.only(
        //                   left: Get.width * 0.01,
        //                   right: Get.width * 0.01),
        //               child: Text(
        //                 postsToUse[index]
        //                     .createdAt
        //                     .toString(),
        //                 style: AppTextStyle.subtitle1
        //                     .copyWith(
        //                         fontSize: multiplier * 0.05,
        //                         color: AppColors.grey,
        //                         fontWeight:
        //                             FontWeight.normal),
        //                 textAlign: TextAlign.start,
        //                 maxLines: 1,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
        );
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Color(0xffEC8B20)),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }
}
