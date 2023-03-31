import 'dart:convert';

import 'package:bog/app/data/model/available_projects_model.dart';
import 'package:bog/app/data/model/order_request_model.dart';
import 'package:bog/app/data/model/projetcs_model.dart';
import 'package:bog/app/data/model/service_projects_model.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/formatter.dart';
import '../../../controllers/home_controller.dart';

import '../../../data/model/log_in_model.dart';
import '../../../data/providers/api_response.dart';

import '../../../data/providers/my_pref.dart';

import '../../../global_widgets/my_project_widget.dart';
import '../../../global_widgets/page_dropdown.dart';
import '../../../global_widgets/tabs.dart';
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
  var currentOrder = "New Order Requests".obs;
  List<MyProjects> savedPosts = [];

  late TabController tabController;

  late Future<ApiResponse> getMyProjects;
  late Future<ApiResponse> getAvailableProjects;
  late Future<ApiResponse> getServiceProjects;
  late Future<ApiResponse> getOrderRequests;

  TextEditingController projectUpdateController = TextEditingController();

  Widget prods = Container();
  var contentIndex = 0.obs;
  double multiplier = 25 * Get.height * 0.01;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<HomeController>();
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    final userType = controller.currentType == 'Client'
        ? 'private_client'
        : 'corporate_client';
    getMyProjects =
        controller.userRepo.getData("/projects/my-request/?userType=$userType");
    getServiceProjects = controller.userRepo
        .getData("/projects/service-request?userType=professional");
    getAvailableProjects = controller.userRepo
        .getData("/projects/dispatched-projects/${logInDetails.profile!.id}");
    getOrderRequests = controller.userRepo.getData('/orders/order-request');
    tabController = TabController(length: 2, vsync: this);
  }

  List<MyProjects> getProjectsByStatus(
      String status, List<MyProjects> projects) {
    final newList =
        projects.where((element) => element.approvalStatus == status).toList();
    return newList;
  }

  List<MyProjects> getProjectsByCustomerStatus(
      String status, List<MyProjects> projects) {
    final newList =
        projects.where((element) => element.status == status).toList();
    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'project',
      builder: (controller) {
      return Expanded(
        child: Scaffold(
          appBar: newAppBar(context, "My ${controller.projectTitle}"),
          body: SizedBox(
            height: Get.height * 0.91,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
               
                  if (controller.currentType == "Product Partner")
                  FutureBuilder<ApiResponse>(
                    future: getOrderRequests,
                    builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return const AppLoader();
                    } else {
                      if (snapshot.data!.isSuccessful){
                        final response = snapshot.data!.data as List<dynamic>;
                        final orderRequests = <OrderRequestsModel>[];

                        for (var element in response){
                          orderRequests.add(OrderRequestsModel.fromJson(element));
                        }

                        return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                          child: PageDropButtonWithoutBackground(
                            label: "",
                            hint: '',
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            onChanged: (val) {
                              currentOrder.value = val;
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
                    SizedBox(
                    height: Get.height * 0.8,
                    child: orderRequests.isEmpty ? const Center(child: Text('You have no requests available'),) : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orderRequests.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        final order = orderRequests[index];
                        return currentOrder.value == "Ongoing Orders"
                            ? OrderItem(
                                price: '203000',
                                date: DateTime.now(),
                                status: 'Pending',
                                orderItemName: '10 tons of coconut',
                              )
                            :  OrderRequestItem(
                              name: order.product!.name ?? '',
                              orderSlug: order.order!.orderSlug ?? '',
                              price: order.paymentInfo!.amount.toString() ,
                              quantity: order.quantity ?? 0,
                            );
                      },
                    ),
                    ),
                      ],
                    );
                      } else {
                        return const Center(child: Text('An error occurred'),);
                      }
                    }
                  }),
                    
                  if (controller.currentType == 'Product')
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
                  if (controller.currentType == 'Product')
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  if (controller.currentType == "Client" ||
                      controller.currentType == "Corporate Client")
                    FutureBuilder<ApiResponse>(
                        future: getMyProjects,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data!.isSuccessful) {
                            final List<MyProjects> posts =
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

                            List<Tab> tabs = [
                              const Tab(
                                child: Text('All'),
                              ),
                              const Tab(child: Text('Pending')),
                              const Tab(child: Text('Ongoing')),
                              const Tab(child: Text('Completed'))
                            ];

                            List<String> dropDownItem = [
                              'All',
                              'Pending',
                              'Ongoing',
                              'Completed'
                            ];

                            final approvedProjects =
                                getProjectsByStatus('approved', postsToUse);
                            final pendingProjects =
                                getProjectsByStatus('pending', postsToUse);
                            final inReviewProjects =
                                getProjectsByStatus('in_review', postsToUse);
                            final cancelledProjects =
                                getProjectsByCustomerStatus(
                                    'completed', postsToUse);
                            final allPendingProjects = [
                              ...pendingProjects,
                              ...inReviewProjects,
                            ];

                            allPendingProjects.sort(
                                (a, b) => a.createdAt!.compareTo(b.createdAt!));
                            final newAllPendingProjects =
                                allPendingProjects.reversed.toList();

                            List<Widget> contents = [
                              getAllProjects(
                                postsToUse,
                                controller,
                              ),
                              getAllProjects(
                                newAllPendingProjects,
                                controller,
                              ),
                              getGroupedProjects(approvedProjects, controller,
                                  isPending: false,
                                  isOngoing: true,
                                  inReview: false),
                              getGroupedProjects(cancelledProjects, controller,
                                  isPending: false,
                                  isOngoing: true,
                                  inReview: false)
                            ].obs;

                            prods = contents[0];
                            return SizedBox(
                                height: Get.height * 0.8,
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8),
                                //       child: Column(
                                //         children: [
                                //           PageDropButton(
                                //             onChanged: (val) {
                                //               setState(() {
                                //                 final index = dropDownItem.indexWhere(
                                //                     (element) => element == val);
                                //                 contentIndex.value = index;
                                //                 prods = contents[index];
                                //               });
                                //             },
                                //             label: '',
                                //             hint: 'Status',
                                //             padding: const EdgeInsets.symmetric(
                                //                 horizontal: 10),
                                //             value: dropDownItem.first,
                                //             items: dropDownItem.map((value) {
                                //               return DropdownMenuItem<String>(
                                //                 value: value,
                                //                 child: Text(value.toString()),
                                //               );
                                //             }).toList(),
                                //           ),
                                //           const SizedBox(height: 10),
                                //           ListView.builder(
                                //               shrinkWrap: true,
                                //               physics:
                                //                   const NeverScrollableScrollPhysics(),
                                //               itemCount: contents.length,
                                //               itemBuilder: (context, i) {
                                //                 return
                                //                     //contentIndex.value == i
                                //                     //      ?
                                //                     contents[i];
                                //                 //   : const SizedBox.shrink();
                                //               })
                                //         ],
                                //       ),
                                //     )

                                child: VerticalTabs(
                                    backgroundColor:
                                        AppColors.backgroundVariant2,
                                    tabBackgroundColor:
                                        AppColors.backgroundVariant2,
                                    indicatorColor: AppColors.primary,
                                    tabsShadowColor:
                                        AppColors.backgroundVariant2,
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
                            return const AppLoader();
                          }
                        }),
                
                 
                  if (controller.currentType == "Service Partner")
                    Column(
                      children: [
                        TabBar(
                          controller: tabController,
                          padding: EdgeInsets.zero,
                          labelColor: Colors.black,
                          unselectedLabelColor: const Color(0xff9A9A9A),
                          indicatorColor: AppColors.primary,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.only(
                              left: Get.width * 0.045,
                              right: Get.width * 0.045),
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
                              text: 'My Projects',
                              iconMargin: EdgeInsets.zero,
                            ),
                            Tab(
                              text: 'Available Projects',
                              iconMargin: EdgeInsets.zero,
                            ),
                          ],
                          onTap: (index) {},
                        ),
                        Container(
                          height: 1,
                          width: Get.width,
                          color: AppColors.grey.withOpacity(0.1),
                        ),
                        FutureBuilder<List<ApiResponse>>(
                            future: Future.wait(
                                [getServiceProjects, getAvailableProjects]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const AppLoader();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  final response1 =
                                      snapshot.data![0].data as List<dynamic>;
                                  final response2 =
                                      snapshot.data![1].data as List<dynamic>;
                                  final serviceProjects =
                                      <ServiceProjectsModel>[];
                                  final availableProjects =
                                      <AvailableProjectsModel>[];
                                  for (var element in response1) {
                                    serviceProjects.add(
                                        ServiceProjectsModel.fromJson(element));
                                 
                                  }
                                  for (var element in response2) {
                                    availableProjects.add(
                                        AvailableProjectsModel.fromJson(
                                            element));
                                  }
                           
                                  return SizedBox(
                                    height: Get.height * 0.735,
                                    child: TabBarView(
                                        controller: tabController,
                                        children: [
                                          serviceProjects.isEmpty
                                              ? const Center(
                                                  child: Text(
                                                      'No projects available'),
                                                )
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      serviceProjects.length,
                                                  itemBuilder: (ctx, i) {
                                                    return ListTile(
                                                        title: Text(
                                                          serviceProjects[i]
                                                                  .projectTypes
                                                                  ?.capitalizeFirst ??
                                                              '',
                                                          style: AppTextStyle
                                                              .headline5
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        subtitle: Text(
                                                          (serviceProjects[i]
                                                                  .projectSlug
                                                                  ?.capitalizeFirst ??
                                                              ''),
                                                          style: AppTextStyle
                                                              .bodyText2,
                                                        ),
                                                        trailing:
                                                            PopupMenuButton(
                                                                color: Colors
                                                                    .white,
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .more_vert,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                itemBuilder:
                                                                    (context) {
                                                                  return [
                                                                    PopupMenuItem(
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () {},
                                                                        child:
                                                                            const Text(
                                                                          'View Details',
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                          AppOverlay.showPercentageDialog(
                                                                              doubleFunction: true,
                                                                              controller: projectUpdateController,
                                                                              title: 'Update Project',
                                                                              content: 'Percentage Completion',
                                                                              onPressed: () async {
                                                                                if (projectUpdateController.text.isEmpty) {
                                                                                  Get.snackbar('Error', 'Put a valid value', backgroundColor: Colors.red);
                                                                                }
                                                                                final response = await controller.userRepo.putData('/projects/progress/${serviceProjects[i].serviceProviderId}/${serviceProjects[i].id}', {
                                                                                  "percent": projectUpdateController.text,
                                                                                });
                                                                                if (response.isSuccessful) {
                                                                                  Get.back();
                                                                                  setState(() {});
                                                                                  Get.snackbar(
                                                                                    'Success',
                                                                                    'Project Status updated successfully',
                                                                                    backgroundColor: Colors.green,
                                                                                  );
                                                                                  projectUpdateController.text = '';
                                                                                } else {
                                                                                  Get.snackbar(
                                                                                    'Error',
                                                                                    response.message ?? 'An error occurred',
                                                                                    backgroundColor: Colors.red,
                                                                                  );
                                                                                  projectUpdateController.text = '';
                                                                                }
                                                                              });
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Update Details',
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontSize: 12),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ];
                                                                }));
                                                  }),
                                          availableProjects.isEmpty
                                              ? const Center(
                                                  child: Text(
                                                      'No Available projects currently'))
                                              : ListView.builder(
                                                  itemCount:
                                                      availableProjects.length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return ServiceRequestItem(
                                                      id: availableProjects[
                                                                  index]
                                                              .projectId ??
                                                          '',
                                                      projectId: (availableProjects[
                                                                      index]
                                                                  .project!
                                                                  .projectSlug ??
                                                              '')
                                                          .toUpperCase(),
                                                      location: capitalizeFirst(
                                                          availableProjects[
                                                                      index]
                                                                  .project!
                                                                  .projectTypes ??
                                                              ''),
                                                    );
                                                  },
                                                )
                                        ]),
                                  );
                                } else {
                                  return const Center(
                                    child: Text('No Projects Available'),
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return TabBarView(
                                    controller: tabController,
                                    children: const [
                                      Center(
                                        child: Text(
                                            'An error occurred, please try again later'),
                                      ),
                                      Center(
                                        child: Text(
                                            'An error occurred, please try again later'),
                                      )
                                    ]);
                              } else {
                                return TabBarView(
                                    controller: tabController,
                                    children: const [
                                      Center(
                                          child: Text('No projects currently')),
                                      Center(
                                          child: Text(
                                              'No Available projects currently'))
                                    ]);
                              }
                            }),
                      ],
                    ),
                ],
              ),
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

  Widget getGroupedProjects(
      List<MyProjects> postsToUse, HomeController controller,
      {required bool isPending,
      required bool isOngoing,
      required bool inReview}) {
    return postsToUse.isEmpty
        ? const Center(
            child: Text('No Projects Available'),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: postsToUse.length,
                itemBuilder: (ctx, i) {
                  return MyProjectWidget(
                    inReview: inReview,
                    isCancelled: false,
                    isOngoing: isOngoing,
                    isPending: isPending,
                    id: postsToUse[i].id ?? '',
                    controller: controller,
                    projectType: postsToUse[i].projectTypes ?? '',
                    orderSlug: postsToUse[i].projectSlug ?? '',
                  );
                }));
  }

  Widget getAllProjects(
    List<MyProjects> postsToUse,
    HomeController controller,
  ) {
    return postsToUse.isEmpty
        ? const Center(
            child: Text('No Projects Available'),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: ListView.builder(
                itemCount: postsToUse.length,
                itemBuilder: (ctx, i) {
                  return MyProjectWidget(
                    inReview: postsToUse[i].approvalStatus == 'in_review',
                    isCancelled: postsToUse[i].approvalStatus == 'disapproved',
                    isOngoing: postsToUse[i].approvalStatus == 'approved',
                    isPending: postsToUse[i].approvalStatus == 'pending',
                    id: postsToUse[i].id ?? '',
                    controller: controller,
                    projectType: postsToUse[i].projectTypes ?? '',
                    orderSlug: postsToUse[i].projectSlug ?? '',
                  );
                }));
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
