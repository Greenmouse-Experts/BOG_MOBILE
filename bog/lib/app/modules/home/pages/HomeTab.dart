import 'dart:convert';
import 'dart:math';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/model/log_in_model.dart';
import '../../../data/providers/api_response.dart';
import '../../../data/providers/my_pref.dart';
import '../../../global_widgets/app_avatar.dart';
import '../../../global_widgets/app_drawer.dart';
import '../../../global_widgets/horizontal_item_tile.dart';
import '../../create/create.dart';
import '../../notifications/notification.dart';
import '../../shop/shop.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final HomeController controller = Get.find<HomeController>();
  var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.updateNewUser(logInDetails.userType.toString().replaceAll("_", " ").capitalizeFirst.toString(),updatePages: false);
  }
  @override
  Widget build(BuildContext context) {
    String title = "N 300,000";
    String subTitle = "Monthly Earnings";
    String icon = "";

    List ranking = [
      {'class': 'Mon', 'total': 23},
      {'class': 'Tue', 'total': 14},
      {'class': 'Wed', 'total': 80},
      {'class': 'Thur', 'total': 70},
      {'class': 'Fri', 'total': 21},
      {'class': 'Sat', 'total': 12},
      {'class': 'Sun', 'total': 50},
    ];

    return GetBuilder<HomeController>(builder: (controller) {
      return SizedBox(
        height: Get.height * 0.936,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: kToolbarHeight/1.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
              child: Row(
                children: [
                  Builder(
                      builder: (context1) {
                        return SizedBox(
                          width: Get.width * 0.16,
                          height: Get.width * 0.16,
                          child: IconButton(
                            icon: AppAvatar(
                              imgUrl: (logInDetails.photo).toString(),
                              radius: Get.width * 0.16,
                              name: logInDetails.name.toString(),
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        );
                      }
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello,",
                              style: AppTextStyle.subtitle1.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              logInDetails.name.toString(),
                              style: AppTextStyle.subtitle1.copyWith(
                                color: Colors.black,
                                fontSize: Get.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                        //Alarm Icon
                        IconButton(
                          icon: const Icon(Icons.notifications,color: Colors.grey),
                          onPressed: () {
                            Get.to(() => const NotificationPage());
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            if(controller.currentType == "Client")
              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Get.height * 0.18,
                  width: Get.width * 0.95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/house.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
            if(controller.currentType != "Client")
              Padding(
                padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05,top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Overview",
                      style: AppTextStyle.subtitle1.copyWith(
                        color: Colors.black,
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildOverViewContainer(
                          "assets/images/earnings.png",
                          title,
                          subTitle,
                          const Color(0xffD3DDFE),
                        ),

                        buildOverViewContainer(
                          "assets/images/sales.png",
                          "N 2,000,000",
                          "Total Sales",
                          const Color(0xffDEFEFE),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildOverViewContainer(
                          "assets/images/products.png",
                          "150",
                          "Products",
                          const Color(0xffF6DEFE),
                        ),

                        buildOverViewContainer(
                          "assets/images/orders.png",
                          "52",
                          "Orders",
                          const Color(0xffFED8D5),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            //indicator
            SizedBox(
              height: Get.height * 0.01,
            ),
            if(controller.currentType == "Client")
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
            SizedBox(
              height: Get.height * 0.01,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(controller.currentType == "Client")
                      Padding(
                      padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05,top: 10.0),
                      child: Text(
                        "What would you like to do?",
                        style: AppTextStyle.subtitle1.copyWith(
                          color: Colors.black,
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if(controller.currentType != "Client")
                      Padding(
                        padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05,top: 10.0),
                        child: Text(
                          "Sales",
                          style: AppTextStyle.subtitle1.copyWith(
                            color: Colors.black,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    if(controller.currentType == "Client")
                      Padding(
                      padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(Create.route);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.03,top: Get.width*0.05,bottom: Get.width*0.05),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Create A Project',
                                          style: AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 19,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Start a project with skilled \nprofessionals',
                                          style: AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
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
                                      width: Get.width*0.15,
                                      height: Get.width*0.15,
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
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width*0.03,right: Get.width*0.03,top: Get.width*0.05,bottom: Get.width*0.05),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Shop Products',
                                          style: AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 19,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Procure construction materials \nfor your projects',
                                          style: AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: Get.width * 0.02),
                                      child: Image.asset(
                                        'assets/images/image 809.png',
                                        width: Get.width*0.15,
                                        height: Get.width*0.15,
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
                    if(controller.currentType != "Client")
                      Padding(
                        padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05,top: 10.0),
                        child: SizedBox(
                          width: Get.width,
                          height: Get.height * 0.3,
                          child: DChartBarCustom(
                            radiusBar: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            showDomainLabel: true,
                            showMeasureLabel: true,
                            showMeasureLine: true,
                            showDomainLine: true,
                            spaceMeasureLinetoChart: 10,
                            showLoading: true,
                            spaceBetweenItem: Get.width * 0.05,
                            listData: List.generate(ranking.length, (index) {
                              Color currentColor =
                              Color((Random().nextDouble() * 0xFFFFFF).toInt());
                              return DChartBarDataCustom(
                                onTap: () {

                                },
                                elevation: 0,
                                value: ranking[index]['total'].toDouble(),
                                label: ranking[index]['class'],
                                color: AppColors.primary,
                                splashColor: AppColors.primary,
                                showValue: false,
                              );
                            }),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05,top: 10.0),
                      child: Text(
                        "Need Help?",
                        style: AppTextStyle.subtitle1.copyWith(
                          color: Colors.black,
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/Group 47034.png",
                          height: Get.height * 0.2,
                          width: Get.width*0.5,
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          "assets/images/Group 47035.png",
                          height: Get.height * 0.2,
                          width: Get.width*0.5,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Container buildOverViewContainer(String icon, String title, String subTitle, Color color) {
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