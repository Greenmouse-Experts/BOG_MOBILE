import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';

import '../../data/model/log_in_model.dart';
import '../../data/model/meeting_model.dart';
import '../../data/model/projetcs_model.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/new_app_bar.dart';
import '../../global_widgets/overlays.dart';

class Meetings extends StatefulWidget {
  const Meetings({Key? key}) : super(key: key);

  static const route = '/notification';

  @override
  State<Meetings> createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> with TickerProviderStateMixin {
  late Future<ApiResponse> getMeetings;
  late Future<ApiResponse> getMyRequests;
  late TabController tabController;
  late String userId;
  late String userTypeUsed;
  late String userEmail;
  var search = '';

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    final controller = Get.find<HomeController>();
    const userType = 'professional';
    userTypeUsed = userType;
    getMeetings = controller.userRepo
        .getData('/meeting/service-meeting?userType=$userType');
    getMyRequests = controller.userRepo
        .getData('/projects/service-request?userType=$userType');
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    userId = logInDetails.id ?? '';
    userEmail = logInDetails.email ?? '';
    super.initState();
  }

  Future<void> launchSocialMediaAppIfInstalled({
    required Uri url,
  }) async {
    try {
      bool launched =
          await launchUrl(url, mode: LaunchMode.externalApplication);

      if (!launched) {
        launchUrl(url);
      }
    } catch (e) {
      launchUrl(url);
    }
  }

  List<MeetingModel> getMeetingByStatus(
      List<MeetingModel> meetings, String status) {
    final response =
        meetings.where((element) => element.status == status).toList();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: 'Meetings',
        builder: (controller) {
          return Column(
            children: [
              TabBar(
                controller: tabController,
                padding: EdgeInsets.zero,
                labelColor: Colors.black,
                unselectedLabelColor: const Color(0xff9A9A9A),
                indicatorColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.only(
                    left: Get.width * 0.045, right: Get.width * 0.045),
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
                    text: 'Completed',
                    iconMargin: EdgeInsets.zero,
                  ),
                  Tab(
                    text: 'Upcoming',
                    iconMargin: EdgeInsets.zero,
                  ),
                  Tab(
                    text: 'Pending',
                    iconMargin: EdgeInsets.zero,
                  ),
                ],
                onTap: (index) {},
              ),
              FutureBuilder<List<ApiResponse>>(
                  future: Future.wait([getMeetings, getMyRequests]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const AppLoader();
                    } else if (snapshot.data![0].isSuccessful &&
                        snapshot.data![1].isSuccessful &&
                        snapshot.connectionState == ConnectionState.done) {
                      final response1 = snapshot.data![0].data as List<dynamic>;
                      final meetings = <MeetingModel>[];
                      final response2 = snapshot.data![1].data as List<dynamic>;
                      final myRequests = <MyProjects>[];

                      final List<String> projectSlugs = [];

                      for (var element in response1) {
                        meetings.add(MeetingModel.fromJson(element));
                      }

                      for (var element in response2) {
                        myRequests.add(MyProjects.fromJson(element));
                      }

                      for (var element in myRequests) {
                        projectSlugs.add(element.projectSlug ?? '');
                      }

                      List<MeetingModel> completedMeetings =
                          getMeetingByStatus(meetings, 'completed');

                      if (search.isNotEmpty) {
                        completedMeetings = {
                          ...completedMeetings
                              .where((element) => element.meetingSlug!
                                  .toLowerCase()
                                  .contains(search.toLowerCase()))
                              .toList(),
                          ...completedMeetings
                              .where((element) => element.projectSlug!
                                  .toLowerCase()
                                  .contains(search.toLowerCase()))
                              .toList()
                        }.toList();
                      }
                      final upcomingMeetings =
                          getMeetingByStatus(meetings, 'placed');
                      final pendingMeetings =
                          getMeetingByStatus(meetings, 'pending');
                      return Container(
                        width: Get.width,
                        height: Get.height * 0.77,
                        padding: const EdgeInsets.all(8),
                        child: TabBarView(controller: tabController, children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03,
                                right: Get.width * 0.03),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AppInput(
                                      hintText:
                                          'Search with name or keyword ...',
                                      filledColor: Colors.grey.withOpacity(.1),
                                      prefexIcon: Icon(
                                        FeatherIcons.search,
                                        color: Colors.black.withOpacity(.5),
                                        size: Get.width * 0.05,
                                      ),
                                      onChanged: (val) {
                                        if (search != val) {
                                          setState(() {
                                            search = val;
                                          });
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.03,
                                    ),
                                    getMeetingsList(
                                        completedMeetings, false, controller)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      if (projectSlugs.isEmpty) {
                                        Get.snackbar('No Projects Available',
                                            'You have no projects available currently, request when you have one',
                                            backgroundColor: AppColors.primary,
                                            colorText: AppColors.background);
                                      } else {
                                        AppOverlay.showRequestMeetingDialog(
                                            isSP: true,
                                            projectSlugs: projectSlugs,
                                            email: userEmail,
                                            userId: userId,
                                            userType: userTypeUsed);
                                      }
                                    },
                                    backgroundColor: AppColors.primary,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                            width: Get.width * 0.05,
                                            height: Get.width * 0.05,
                                            child: Image.asset(
                                                "assets/images/Vector (3).png")),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          getMeetingsList(upcomingMeetings, false, controller),
                          getMeetingsList(pendingMeetings, true, controller)
                        ]),
                      );
                    } else {
                      return const Center(
                        child: Text('An error occurred'),
                      );
                    }
                  }),
            ],
          );
        });
  }

  Widget getMeetingsList(List<MeetingModel> realMeetings, bool isPending,
      HomeController controller) {
    final meetings = realMeetings.obs;
    return Obx(() {
      return SizedBox(
        height: Get.height * 0.65,
        child: meetings.isEmpty
            ? const Center(
                child: Text('You have no meetings available'),
              )
            : ListView.builder(
                itemCount: meetings.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final meeting = meetings[index];
                  return SizedBox(
                    height: Get.height * 0.08,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.16,
                          height: Get.width * 0.16,
                          child: IconButton(
                            icon: AppAvatar(
                                imgUrl: "",
                                radius: Get.width * 0.16,
                                name: "Land"),
                            onPressed: () {},
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              meeting.meetingSlug ?? '',
                              style: AppTextStyle.subtitle1.copyWith(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.04),
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Text(
                              meeting.status ?? '',
                              style: AppTextStyle.subtitle1.copyWith(
                                  color: Colors.grey,
                                  fontSize: Get.width * 0.035),
                            ),
                            //Divider
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Container(
                              height: 1,
                              width: Get.width * 0.65,
                              color: Colors.grey.withOpacity(.2),
                            ),
                          ],
                        ),
                        PopupMenuButton(
                            color: Colors.white,
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ),
                            itemBuilder: (context) {
                              return [
                                if (isPending)
                                  PopupMenuItem<int>(
                                      value: 1,
                                      child: SizedBox(
                                        height: 50,
                                        child: AppButton(
                                          title: 'Cancel Meeting',
                                          bckgrndColor: Colors.red,
                                          onPressed: () {
                                            Get.back();
                                            AppOverlay.showInfoDialog(
                                                title: 'Cancel Meeting',
                                                content:
                                                    'Are you sure you want to cancel this meeting?, This action cannot be undone',
                                                doubleFunction: true,
                                                onPressed: () async {
                                                  final response =
                                                      await controller.userRepo
                                                          .postData(
                                                              '/meeting/action',
                                                              {
                                                        'status': 'declined',
                                                        'meetingId': meeting.id,
                                                      });
                                                  if (response.isSuccessful) {
                                                    meetings.removeAt(index);
                                                    controller.update();

                                                    Get.back();

                                                    Get.snackbar('Success',
                                                        'Meeting cancelled successfully',
                                                        backgroundColor:
                                                            Colors.green,
                                                        colorText: AppColors
                                                            .background);
                                                  } else {
                                                    Get.back();
                                                    Get.snackbar(
                                                        'Error',
                                                        response.message ??
                                                            'An error occurred',
                                                        backgroundColor:
                                                            Colors.red,
                                                        colorText: AppColors
                                                            .background);
                                                  }
                                                });
                                          },
                                        ),
                                      )),
                                if (!isPending)
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: TextButton(
                                        onPressed: () {
                                          Get.back();
                                          AppOverlay.showMeetingDialog(
                                              meetingLink: meeting
                                                      .meetingInfo!.joinUrl ??
                                                  '',
                                              meetingPassword: meeting
                                                      .meetingInfo!.password ??
                                                  '');
                                        },
                                        child: const Text(
                                          'Meeting Info',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )),
                                  ),
                                if (!isPending)
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: TextButton(
                                        onPressed: () {
                                          launchSocialMediaAppIfInstalled(
                                              url: Uri.parse(meeting
                                                      .meetingInfo!.joinUrl ??
                                                  ''));
                                        },
                                        child: const Text(
                                          'Meeting Link',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )),
                                  ),
                              ];
                            })
                      ],
                    ),
                  );
                },
              ),
      );
    });
  }
}

class NewMeetings extends StatefulWidget {
  const NewMeetings({super.key});

  @override
  State<NewMeetings> createState() => _NewMeetingsState();
}

class _NewMeetingsState extends State<NewMeetings>
    with TickerProviderStateMixin {
  late TabController tabController;
  late Future<ApiResponse> getMeetings;
  late Future<ApiResponse> getMyRequests;
  late String userId;
  late String userTypeUsed;
  late String userEmail;

  Future<void> launchSocialMediaAppIfInstalled({
    required Uri url,
  }) async {
    try {
      bool launched =
          await launchUrl(url, mode: LaunchMode.externalApplication);

      if (!launched) {
        launchUrl(url);
      }
    } catch (e) {
      launchUrl(url);
    }
  }

  List<MeetingModel> getMeetingByStatus(
      List<MeetingModel> meetings, String status) {
    final response =
        meetings.where((element) => element.status == status).toList();
    return response;
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    final controller = Get.find<HomeController>();
    final userType = controller.currentType == 'Client'
        ? 'private_client'
        : controller.currentType == 'Corporate Client'
            ? 'corporate_client'
            : controller.currentType == 'Product Partner'
                ? 'vendor'
                : 'professional';
    userTypeUsed = userType;
    getMeetings =
        controller.userRepo.getData('/meeting/my-meeting?userType=$userType');
    getMyRequests =
        controller.userRepo.getData('/projects/my-request?userType=$userType');
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    userId = logInDetails.id ?? '';
    userEmail = logInDetails.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'Meetings',
          builder: (controller) {
            return Scaffold(
              appBar: newAppBarBack(context, 'Meetings'),
              backgroundColor: AppColors.backgroundVariant2,
              body: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    padding: EdgeInsets.zero,
                    labelColor: Colors.black,
                    unselectedLabelColor: const Color(0xff9A9A9A),
                    indicatorColor: AppColors.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.only(
                        left: Get.width * 0.045, right: Get.width * 0.045),
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
                        text: 'Completed',
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Upcoming',
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: 'Pending',
                        iconMargin: EdgeInsets.zero,
                      ),
                    ],
                    onTap: (index) {},
                  ),
                  meetingsWidget(getMeetings, getMyRequests),
                ],
              ),
            
              bottomNavigationBar: HomeBottomWidget(
                  isHome: false, controller: controller, doubleNavigate: false),
            );
          }),
    );
  }

  FutureBuilder<List<ApiResponse>> meetingsWidget(
      Future<ApiResponse> getMeetings, Future<ApiResponse> getMyRequests) {
    return FutureBuilder<List<ApiResponse>>(
        future: Future.wait([getMeetings, getMyRequests]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          } else if (snapshot.data![0].isSuccessful &&
              snapshot.data![1].isSuccessful &&
              snapshot.connectionState == ConnectionState.done) {
            final response1 = snapshot.data![0].data as List<dynamic>;
            final meetings = <MeetingModel>[];
            final response2 = snapshot.data![1].data as List<dynamic>;
            final myRequests = <MyProjects>[];

            final List<String> projectSlugs = [];

            for (var element in response1) {
              meetings.add(MeetingModel.fromJson(element));
            }

            for (var element in response2) {
              myRequests.add(MyProjects.fromJson(element));
            }

            for (var element in myRequests) {
              projectSlugs.add(element.projectSlug ?? '');
            }

            final completedMeetings = getMeetingByStatus(meetings, 'completed');
            final upcomingMeetings = getMeetingByStatus(meetings, 'placed');
            final pendingMeetings = getMeetingByStatus(meetings, 'pending');
            return Container(
              width: Get.width,
              height: Get.height * 0.73,
              padding: const EdgeInsets.all(8),
              child: TabBarView(controller: tabController, children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.03, right: Get.width * 0.03),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppInput(
                            hintText: 'Search with name or keyword ...',
                            filledColor: Colors.grey.withOpacity(.1),
                            prefexIcon: Icon(
                              FeatherIcons.search,
                              color: Colors.black.withOpacity(.5),
                              size: Get.width * 0.05,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          getMeetingsList(completedMeetings, false)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            if (projectSlugs.isEmpty) {
                              Get.snackbar('No Projects Available',
                                  'You have no projects available currently, request when you have one',
                                  backgroundColor: AppColors.primary,
                                  colorText: AppColors.background);
                            } else {
                              AppOverlay.showRequestMeetingDialog(
                                  isSP: false,
                                  projectSlugs: projectSlugs,
                                  email: userEmail,
                                  userId: userId,
                                  userType: userTypeUsed);
                            }
                          },
                          backgroundColor: AppColors.primary,
                          child: Stack(
                            children: [
                              SizedBox(
                                  width: Get.width * 0.05,
                                  height: Get.width * 0.05,
                                  child: Image.asset(
                                      "assets/images/Vector (3).png")),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                getMeetingsList(upcomingMeetings, false),
                getMeetingsList(pendingMeetings, true)
              ]),
            );
          } else {
            return const Center(
              child: Text('An error occurred'),
            );
          }
        });
  }

  Widget getMeetingsList(List<MeetingModel> realMeetings, bool isPending) {
    final meetings = realMeetings.obs;
    return Obx(() {
      return SizedBox(
        height: Get.height * 0.65,
        child: meetings.isEmpty
            ? const Center(
                child: Text('You have no meetings available'),
              )
            : ListView.builder(
                itemCount: meetings.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final meeting = meetings[index];
                  return SizedBox(
                    height: Get.height * 0.08,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.16,
                          height: Get.width * 0.16,
                          child: IconButton(
                            icon: AppAvatar(
                                imgUrl: "",
                                radius: Get.width * 0.16,
                                name: "Land"),
                            onPressed: () {},
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              meeting.meetingSlug ?? '',
                              style: AppTextStyle.subtitle1.copyWith(
                                  color: Colors.black,
                                  fontSize: Get.width * 0.04),
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Text(
                              meeting.status ?? '',
                              style: AppTextStyle.subtitle1.copyWith(
                                  color: Colors.grey,
                                  fontSize: Get.width * 0.035),
                            ),
                            //Divider
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Container(
                              height: 1,
                              width: Get.width * 0.65,
                              color: Colors.grey.withOpacity(.2),
                            ),
                          ],
                        ),
                        PopupMenuButton(
                            color: Colors.white,
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.black,
                            ),
                            itemBuilder: (context) {
                              return [
                                if (isPending)
                                  PopupMenuItem<int>(
                                      value: 1,
                                      child: SizedBox(
                                        height: 50,
                                        child: AppButton(
                                          title: 'Cancel Meeting',
                                          bckgrndColor: Colors.red,
                                          onPressed: () {
                                            Get.back();
                                            AppOverlay.showInfoDialog(
                                                title: 'Cancel Meeting',
                                                content:
                                                    'Are you sure you want to cancel this meeting?, This action cannot be undone',
                                                doubleFunction: true,
                                                onPressed: () async {
                                                  final controller = Get.find<
                                                      HomeController>();
                                                  final response =
                                                      await controller.userRepo
                                                          .postData(
                                                              '/meeting/action',
                                                              {
                                                        'status': 'declined',
                                                        'meetingId': meeting.id,
                                                      });
                                                  if (response.isSuccessful) {
                                                    meetings.removeAt(index);
                                                    controller.update();

                                                    Get.back();

                                                    Get.snackbar('Success',
                                                        'Meeting cancelled successfully',
                                                        backgroundColor:
                                                            Colors.green,
                                                        colorText: AppColors
                                                            .background);
                                                  } else {
                                                    Get.back();
                                                    Get.snackbar(
                                                        'Error',
                                                        response.message ??
                                                            'An error occurred',
                                                        backgroundColor:
                                                            Colors.red,
                                                        colorText: AppColors
                                                            .background);
                                                  }
                                                });
                                          },
                                        ),
                                      )),
                                if (!isPending)
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: TextButton(
                                        onPressed: () {
                                          Get.back();
                                          AppOverlay.showMeetingDialog(
                                              meetingLink: meeting
                                                      .meetingInfo!.joinUrl ??
                                                  '',
                                              meetingPassword: meeting
                                                      .meetingInfo!.password ??
                                                  '');
                                        },
                                        child: const Text(
                                          'Meeting Info',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )),
                                  ),
                                if (!isPending)
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: TextButton(
                                        onPressed: () {
                                          launchSocialMediaAppIfInstalled(
                                              url: Uri.parse(meeting
                                                      .meetingInfo!.joinUrl ??
                                                  ''));
                                        },
                                        child: const Text(
                                          'Meeting Link',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )),
                                  ),
                              ];
                            })
                      ],
                    ),
                  );
                },
              ),
      );
    });
  }
}
