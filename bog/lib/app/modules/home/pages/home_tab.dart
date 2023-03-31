import 'dart:convert';

import 'package:bog/app/data/model/notifications_model.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/modules/settings/faq.dart';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as pie_chart;
import 'package:badges/badges.dart' as badges;

import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/model/log_in_model.dart';

import '../../../data/model/user_details_model.dart';
import '../../../data/providers/api_response.dart';
import '../../../data/providers/my_pref.dart';
import '../../../global_widgets/activity_widget.dart';
import '../../../global_widgets/app_avatar.dart';

import '../../../global_widgets/sp_project_preview.dart';
import '../../create/create.dart';
import '../../notifications/notification.dart';
import '../../settings/support.dart';
import '../../shop/shop.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final HomeController controller = Get.find<HomeController>();
  var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));

  final labelMap = <String, String>{
    "Approved Projects": '52',
    "Projects in review": '38',
    "Disapproved Projects": '18',
  };

  late Future<ApiResponse> getNotifications;

  // late Future<ApiResponse> getAssignedSPProjects;
  // late Future<ApiResponse> getAvailableSPProjects;

  @override
  void initState() {
    final controller = Get.find<HomeController>();

    var logInDetails =
        UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));
    getNotifications = controller.userRepo
        .getData('/notifications/user/${logInDetails.profile!.id}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userDetails =
        UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));

    var isVerified = false;

    if (userDetails.profile!.isVerified != null) {
      isVerified = userDetails.profile!.isVerified!;
    }

    var kycScore = 0.0;
    if (userDetails.profile!.kycPoint != null) {
      kycScore = userDetails.profile!.kycPoint!.toDouble();
    }

    return GetBuilder<HomeController>(builder: (controller) {
      return SizedBox(
          height: Get.height * 0.93,
          child: FutureBuilder<ApiResponse>(
              future: getNotifications,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isSuccessful) {
                    final response = snapshot.data!.data as List<dynamic>;
                    final notifications = <NotificationsModel>[];

                    for (var element in response) {
                      notifications.add(NotificationsModel.fromJson(element));
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: kToolbarHeight / 1.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          child: Row(
                            children: [
                              Builder(builder: (context1) {
                                return SizedBox(
                                  width: Get.width * 0.16,
                                  height: Get.width * 0.16,
                                  child: IconButton(
                                    icon: AppAvatar(
                                      imgUrl: (logInDetails.photo).toString(),
                                      radius: Get.width * 0.16,
                                      name:
                                          "${logInDetails.fname} ${logInDetails.lname}",
                                    ),
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                  ),
                                );
                              }),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Welcome back,",
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "${logInDetails.fname} ",
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.05,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Alarm Icon
                                    IconButton(
                                      icon: badges.Badge(
                                        //    position: badges.BadgePosition(),
                                        badgeContent: Text(
                                          notifications.length.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        badgeStyle: const badges.BadgeStyle(
                                            badgeColor: AppColors.primary,
                                            padding: EdgeInsets.all(5)),
                                        child: const Icon(
                                          Icons.notifications,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.to(() =>
                                            NotificationPage(notifications));
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: AppColors.newAsh,
                        ),
                        if (controller.currentType == "Client" ||
                            controller.currentType == "Corporate Client")
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                        if (controller.currentType == "Client" ||
                            controller.currentType == "Corporate Client")
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.045,
                                right: Get.width * 0.045),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: Get.height * 0.18,
                                  width: Get.width * 0.95,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/Frame 466380.png"),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (controller.currentType == "Client" ||
                            controller.currentType == "Corporate Client")
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                        if (controller.currentType == "Client" ||
                            controller.currentType == "Corporate Client")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: Get.width * 0.018,
                                height: Get.width * 0.018,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                            ],
                          ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (controller.currentType == "Client" ||
                                    controller.currentType ==
                                        "Corporate Client")
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.05,
                                        right: Get.width * 0.05,
                                        top: 10.0),
                                    child: Text(
                                      "What would you like to do?",
                                      style: AppTextStyle.subtitle1.copyWith(
                                        color: Colors.black,
                                        fontSize: Get.width * 0.04,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                if (controller.currentType == "Product Partner")
                                  FutureBuilder<List<ApiResponse>>(
                                      future: Future.wait([
                                        controller.userRepo
                                            .getData("/products"),
                                        controller.userRepo
                                            .getData('/orders/order-request')
                                      ]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const AppLoader();
                                        } else {
                                          if (snapshot.hasError) {
                                            return const Center(
                                              child: Text(
                                                  'An error occurred, please try again later'),
                                            );
                                          } else {
                                            var response1 = [];
                                            var response2 = [];

                                            final dataMap = <String, double>{
                                              "Approved Orders": 52,
                                              "Orders in review": 38,
                                              "Disapproved Orders": 18,
                                            };
                                            if (snapshot
                                                    .data![0].isSuccessful &&
                                                snapshot
                                                    .data![1].isSuccessful) {
                                              response1 = snapshot.data![0].data
                                                  as List<dynamic>;
                                              response2 = snapshot.data![1].data
                                                  as List<dynamic>;
                                            }
                                            return ProductPartnerHomeWidget(
                                                orderRequest: response2.length,
                                                total: response1.length,
                                                kycScore: kycScore,
                                                dataMap: dataMap,
                                                labelMap: labelMap);
                                          }
                                        }
                                      }),
                                SizedBox(
                                  height: Get.height * 0.015,
                                ),
                                if (controller.currentType == "Client" ||
                                    controller.currentType ==
                                        "Corporate Client")
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.03,
                                        right: Get.width * 0.03),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Create.route);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: const Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: Get.width * 0.03,
                                                  right: Get.width * 0.03,
                                                  top: Get.width * 0.05,
                                                  bottom: Get.width * 0.05),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Request for Service Provider',
                                                        style: AppTextStyle
                                                            .headline4
                                                            .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 19,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Start a project with skilled \nprofessionals',
                                                        style: AppTextStyle
                                                            .headline4
                                                            .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/image 808.png',
                                                    width: Get.width * 0.15,
                                                    height: Get.width * 0.15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Shop.route);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: const Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: Get.width * 0.03,
                                                  right: Get.width * 0.03,
                                                  top: Get.width * 0.05,
                                                  bottom: Get.width * 0.05),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Shop Products',
                                                        style: AppTextStyle
                                                            .headline4
                                                            .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 19,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Procure construction materials \nfor your projects',
                                                        style: AppTextStyle
                                                            .headline4
                                                            .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.02,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            Get.width * 0.02),
                                                    child: Image.asset(
                                                      'assets/images/image 809.png',
                                                      width: Get.width * 0.15,
                                                      height: Get.width * 0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (controller.currentType == "Service Partner")
                                  FutureBuilder<List<ApiResponse>>(
                                      future: Future.wait([
                                        controller.userRepo.getData(
                                            '/projects/service-partner-analyze?y=2023'),
                                        controller.userRepo.getData(
                                            "/projects/dispatched-projects/${logInDetails.profile!.id}"),
                                      ]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const AppLoader();
                                        } else {
                                          if (snapshot.hasError) {
                                            return const Center(
                                              child: Text(
                                                  'An error occurred, please try again later'),
                                            );
                                          } else {
                                            var response1 = [];
                                            var response2 = [];
                                            if (snapshot
                                                    .data![0].isSuccessful &&
                                                snapshot
                                                    .data![1].isSuccessful) {
                                              response1 = snapshot.data![0]
                                                  .projects as List<dynamic>;
                                              response2 = snapshot.data![1].data
                                                  as List<dynamic>;
                                            }
                                            final assignedProjects =
                                                response1.length;
                                            final availableProjects =
                                                response2.length;

                                            final newdataMap = <String, double>{
                                              "Approved Projects":
                                                  response1.length.toDouble(),
                                              "Projects in review":
                                                  response1.length.toDouble(),
                                              "Disapproved Projects":
                                                  response1.length.toDouble(),
                                            };

                                            return SPHomeWidget(
                                              total: response1.length,
                                              isVerified: isVerified,
                                              kycScore: kycScore,
                                              dataMap: newdataMap,
                                              labelMap: labelMap,
                                              assignedProjects:
                                                  assignedProjects,
                                              availableProjects:
                                                  availableProjects,
                                            );
                                          }
                                        }
                                      }),
                                if (controller.currentType == "Service Partner")
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                if (controller.currentType == "Client" ||
                                    controller.currentType ==
                                        "Corporate Client")
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.05,
                                            right: Get.width * 0.05,
                                            top: 10.0),
                                        child: Text(
                                          "Need Help?",
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.04,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.015,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.05,
                                            right: Get.width * 0.05),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => const FAQ());
                                              },
                                              child: Image.asset(
                                                "assets/images/Group 47034.png",
                                                height: Get.height * 0.2,
                                                width: Get.width * 0.4,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => const Support());
                                              },
                                              child: Image.asset(
                                                "assets/images/Group 47035.png",
                                                height: Get.height * 0.2,
                                                width: Get.width * 0.4,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height: Get.height * 0.015,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('An error occurred'),
                    );
                  }
                } else {
                  return const AppLoader();
                }
              }));
    });
  }

  Container buildOverViewContainer(
      String icon, String title, String subTitle, Color color) {
    return Container(
      height: Get.height * 0.13,
      width: Get.width * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * 0.085,
              height: Get.width * 0.085,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image.asset(
                  icon,
                  width: Get.width * 0.045,
                  height: Get.width * 0.045,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                title,
                style: AppTextStyle.subtitle1.copyWith(
                  color: Colors.black,
                  fontSize: Get.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                subTitle,
                style: AppTextStyle.subtitle1.copyWith(
                  color: Colors.black,
                  fontSize: Get.width * 0.035,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductPartnerHomeWidget extends StatelessWidget {
  const ProductPartnerHomeWidget({
    super.key,
    required this.kycScore,
    required this.dataMap,
    required this.labelMap,
    required this.total,
    required this.orderRequest,
  });

  final double kycScore;
  final int total;
  final int orderRequest;
  final Map<String, double> dataMap;
  final Map<String, String> labelMap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Padding(
        padding: EdgeInsets.only(
          left: Get.width * 0.05,
          right: Get.width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: AppColors.primary,
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('NGN 3,180,000',
                            style: AppTextStyle.mid1
                                .copyWith(color: AppColors.white)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.visibility,
                              size: 15 * Get.textScaleFactor,
                            )),
                        const Spacer(),
                        Image.asset('assets/icons/verified.png'),
                        const SizedBox(width: 5),
                        Text(
                          'Verified',
                          style: AppTextStyle.caption
                              .copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                    Text(
                      'Total Earnings',
                      style: AppTextStyle.caption2
                          .copyWith(color: AppColors.white),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                          ),
                          child: Text(
                            'Request Payout',
                            style: AppTextStyle.caption.copyWith(
                                color: AppColors.blackShade.withOpacity(0.8)),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Validity Date',
                              style: AppTextStyle.caption
                                  .copyWith(color: AppColors.white),
                            ),
                            Text(
                              '11 months, 3 days',
                              style: AppTextStyle.caption
                                  .copyWith(color: AppColors.white),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'KYC Score',
                  style: AppTextStyle.caption2
                      .copyWith(color: AppColors.blackShade.withOpacity(0.8)),
                ),
                SizedBox(width: Get.width * 0.01),
                TweenAnimationBuilder(
                  tween: Tween<double>(
                    begin: 0,
                    end: kycScore / 100,
                  ),
                  duration: const Duration(milliseconds: 1000),
                  builder: (context, double val, _) {
                    return SizedBox(
                      width: Get.width * 0.55,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: LinearProgressIndicator(
                          color: kycScore < 50
                              ? Colors.red
                              : AppColors.successGreen,
                          value: val,
                          minHeight: 12,
                          backgroundColor: AppColors.backgroundGrey,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,
                  padding: EdgeInsets.all(Get.width * 0.015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kycScore < 50
                        ? Colors.red.withOpacity(0.1)
                        : AppColors.successGreen.withOpacity(0.1),
                  ),
                  child: Container(
                    width: Get.width * 0.1,
                    height: Get.width * 0.1,
                    padding: EdgeInsets.all(Get.width * 0.015),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kycScore < 50
                          ? Colors.red.withOpacity(0.3)
                          : AppColors.successGreen.withOpacity(0.3),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: Get.width * 0.05,
                      height: Get.width * 0.05,
                      padding: EdgeInsets.all(Get.width * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color:
                            kycScore < 50 ? Colors.red : AppColors.successGreen,
                      ),
                      child: Text(
                        '${kycScore.toInt()}%',
                        style: AppTextStyle.caption.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Key Activities',
                style: AppTextStyle.caption2
                    .copyWith(color: AppColors.blackShade.withOpacity(0.8)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActivityWidget(
                  onTap: () {
                    controller.currentBottomNavPage.value = 3;
                    controller.updateNewUser(controller.currentType);
                    controller.update(['home']);
                  },
                  total: total,
                  title: 'Total Products',
                  subTitle: 'Total Products on sale.',
                  image: 'assets/activity/products.png',
                  color: AppColors.productPurple,
                  isProduct: true,
                ),
                ActivityWidget(
                  onTap: () {},
                  total: 100,
                  isProduct: false,
                  title: 'Products in Store',
                  subTitle: 'Total Sales made.',
                  image: 'assets/activity/sales.png',
                  color: AppColors.productGreen.withOpacity(0.7),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActivityWidget(
                  onTap: () {
                    controller.currentBottomNavPage.value = 2;
                    controller.updateNewUser(controller.currentType);
                    controller.update(['home']);
                  },
                  total: orderRequest,
                  isProduct: false,
                  title: 'Order Requests',
                  subTitle: 'Total Order requests',
                  image: 'assets/activity/requests.png',
                  color: AppColors.productYellow.withOpacity(0.7),
                ),
                ActivityWidget(
                  onTap: () {},
                  total: 0,
                  isProduct: false,
                  title: 'Deliveries',
                  subTitle: 'Successful deliveries made',
                  image: 'assets/activity/delivery.png',
                  color: AppColors.productBlue,
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
            pie_chart.PieChart(
              dataMap: dataMap,
              chartType: pie_chart.ChartType.ring,
              chartRadius: Get.width * 0.25,
              colorList: const [
                AppColors.primary,
                AppColors.successGreen,
                AppColors.serviceYellow
              ],
              legendOptions: pie_chart.LegendOptions(
                  legendLabels: labelMap, showLegends: true),
              chartValuesOptions:
                  const pie_chart.ChartValuesOptions(showChartValues: false),
              emptyColor: AppColors.primary,
              animationDuration: const Duration(seconds: 2),
              centerText: total.toString(),
              ringStrokeWidth: 12,
              baseChartColor: AppColors.background,
              centerTextStyle: AppTextStyle.caption2
                  .copyWith(color: AppColors.blackShade.withOpacity(0.8)),
            )
          ],
        ));
  }
}

class SPHomeWidget extends StatelessWidget {
  const SPHomeWidget({
    super.key,
    required this.kycScore,
    required this.dataMap,
    required this.labelMap,
    required this.availableProjects,
    required this.assignedProjects,
    required this.isVerified,
    required this.total,
  });

  final int availableProjects;
  final int assignedProjects;
  final double kycScore;
  final bool isVerified;
  final int total;
  final Map<String, double> dataMap;
  final Map<String, String> labelMap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: Get.width * 0.05,
          right: Get.width * 0.05,
        ),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: AppColors.primary,
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('NGN 3,180,000',
                            style: AppTextStyle.mid1
                                .copyWith(color: AppColors.white)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.visibility,
                              size: 15 * Get.textScaleFactor,
                            )),
                        const Spacer(),
                        isVerified
                            ? Image.asset('assets/icons/verified.png')
                            : const SizedBox.shrink(),
                        const SizedBox(width: 5),
                        Text(
                          isVerified ? 'Verified' : 'Not Verified',
                          style: AppTextStyle.caption
                              .copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                    Text(
                      'Total Earnings',
                      style: AppTextStyle.caption2
                          .copyWith(color: AppColors.white),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                          ),
                          child: Text(
                            'Request Payout',
                            style: AppTextStyle.caption.copyWith(
                                color: AppColors.blackShade.withOpacity(0.8)),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Validity Date',
                              style: AppTextStyle.caption
                                  .copyWith(color: AppColors.white),
                            ),
                            Text(
                              '11 months, 3 days',
                              style: AppTextStyle.caption
                                  .copyWith(color: AppColors.white),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'KYC Score',
                  style: AppTextStyle.caption2
                      .copyWith(color: AppColors.blackShade.withOpacity(0.8)),
                ),
                SizedBox(width: Get.width * 0.01),
                TweenAnimationBuilder(
                  tween: Tween<double>(
                    begin: 0,
                    end: kycScore / 100,
                  ),
                  duration: const Duration(milliseconds: 1000),
                  builder: (context, double val, _) {
                    return SizedBox(
                      width: Get.width * 0.55,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: LinearProgressIndicator(
                          color: kycScore < 50
                              ? Colors.red
                              : AppColors.successGreen,
                          value: val,
                          minHeight: 12,
                          backgroundColor: AppColors.backgroundGrey,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  width: Get.width * 0.15,
                  height: Get.width * 0.15,
                  padding: EdgeInsets.all(Get.width * 0.015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kycScore < 50
                        ? Colors.red.withOpacity(0.1)
                        : AppColors.successGreen.withOpacity(0.1),
                  ),
                  child: Container(
                    width: Get.width * 0.1,
                    height: Get.width * 0.1,
                    padding: EdgeInsets.all(Get.width * 0.015),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kycScore < 50
                          ? Colors.red.withOpacity(0.3)
                          : AppColors.successGreen.withOpacity(0.3),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: Get.width * 0.05,
                      height: Get.width * 0.05,
                      padding: EdgeInsets.all(Get.width * 0.01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color:
                            kycScore < 50 ? Colors.red : AppColors.successGreen,
                      ),
                      child: Text(
                        '${kycScore.toInt()}%',
                        style: AppTextStyle.caption.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SPProjectPreview(
                      amount: availableProjects,
                      title: 'Available Projects',
                      image: 'assets/icons/available_projects.png',
                      color: AppColors.servicePurple,
                    ),
                    SPProjectPreview(
                      amount: assignedProjects,
                      title: 'Assigned Projects',
                      image: 'assets/icons/assigned_project.png',
                      color: AppColors.serviceYellow,
                    ),
                  ],
                ),
                SizedBox(height: Get.width * 0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SPProjectPreview(
                      amount: 12,
                      title: 'Completed Projects',
                      image: 'assets/icons/complete_projects.png',
                      color: AppColors.serviceBlue,
                    ),
                    SPProjectPreview(
                      amount: 12,
                      title: 'Ongoing Projects',
                      image: 'assets/icons/ongoing_projects.png',
                      color: AppColors.serviceRed,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                SizedBox(
                  child: pie_chart.PieChart(
                    dataMap: dataMap,
                    chartType: pie_chart.ChartType.ring,
                    chartRadius: Get.width * 0.25,
                    colorList: const [
                      AppColors.primary,
                      AppColors.successGreen,
                      AppColors.serviceYellow
                    ],
                    emptyColor: AppColors.primary,
                    animationDuration: const Duration(seconds: 2),
                    centerText: total.toString(),
                    ringStrokeWidth: 12,
                    legendOptions: pie_chart.LegendOptions(
                        legendLabels: labelMap, showLegends: true),
                    chartValuesOptions: const pie_chart.ChartValuesOptions(
                        showChartValues: false),
                    baseChartColor: AppColors.background,
                    centerTextStyle: AppTextStyle.caption2
                        .copyWith(color: AppColors.blackShade.withOpacity(0.8)),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
