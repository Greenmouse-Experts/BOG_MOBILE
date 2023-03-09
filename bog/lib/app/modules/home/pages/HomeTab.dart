import 'dart:convert';
import 'dart:math';

import 'package:bog/app/modules/settings/faq.dart';
import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    final Uri faq = Uri.parse('https://bog-project-new.netlify.app/faqs');
    final Uri support = Uri.parse('https://bog-project-new.netlify.app/terms');

    launchURL(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return GetBuilder<HomeController>(builder: (controller) {
      return SizedBox(
        height: Get.height * 0.93,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: kToolbarHeight / 1.5,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                          name: "${logInDetails.fname} ${logInDetails.lname}",
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
                              "${logInDetails.fname} ${logInDetails.lname}",
                              style: AppTextStyle.subtitle1.copyWith(
                                color: Colors.black,
                                fontSize: Get.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                        //Alarm Icon
                        IconButton(
                          icon: const Icon(Icons.notifications,
                              color: Colors.grey),
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
            if (controller.currentType == "Client" ||
                controller.currentType == "Corporate Client" ||
                controller.currentType == "Product Partner")
              SizedBox(
                height: Get.height * 0.015,
              ),
            if (controller.currentType == "Client" ||
                controller.currentType == "Corporate Client")
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.045, right: Get.width * 0.045),
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
                          image: AssetImage("assets/images/Frame 466380.png"),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (controller.currentType == "Product Partner")
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.05, right: Get.width * 0.05, top: 10.0),
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
            if (controller.currentType == "Client" ||
                controller.currentType == "Corporate Client" ||
                controller.currentType == "Product Partner")
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
            if (controller.currentType == "Client" ||
                controller.currentType == "Corporate Client" ||
                controller.currentType == "Product Partner")
              SizedBox(
                height: Get.height * 0.01,
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.currentType == "Client" ||
                        controller.currentType == "Corporate Client")
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
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            top: 10.0),
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
                    if (controller.currentType == "Client" ||
                        controller.currentType == "Corporate Client")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05, right: Get.width * 0.05),
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
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
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
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Create A Project',
                                            style:
                                                AppTextStyle.headline4.copyWith(
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
                                            style:
                                                AppTextStyle.headline4.copyWith(
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
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
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
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Shop Products',
                                            style:
                                                AppTextStyle.headline4.copyWith(
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
                                            style:
                                                AppTextStyle.headline4.copyWith(
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
                                        padding: EdgeInsets.only(
                                            right: Get.width * 0.02),
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
                    if (controller.currentType == "Product Partner")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.0,
                            right: Get.width * 0.05,
                            top: 10.0),
                        child: SizedBox(
                          width: Get.width,
                          height: Get.height * 0.3,
                          child: BarChart(
                            mainBarData(),
                            swapAnimationDuration:
                                const Duration(milliseconds: 150), // Optional
                            swapAnimationCurve: Curves.linear, // Optional
                          ),
                        ),
                      ),
                    if (controller.currentType == "Service Partner")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            top: 10.0),
                        child: Text(
                          "Overview",
                          style: AppTextStyle.subtitle1.copyWith(
                            color: Colors.black,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    if (controller.currentType == "Service Partner")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            top: 10.0),
                        child: SizedBox(
                          width: Get.width,
                          height: Get.height * 0.13,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  height: Get.height * 0.13,
                                  width: Get.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: const Color(0xff4CD964),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.025),
                                            child: Text(
                                              "02",
                                              style: AppTextStyle.headline4
                                                  .copyWith(
                                                color: Colors.black,
                                                fontSize: Get.width * 0.04,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.025),
                                            child: Text(
                                              "Current Projects",
                                              style: AppTextStyle.headline4
                                                  .copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: Get.width * 0.035,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Container(
                                          height: Get.height * 0.05,
                                          width: Get.height * 0.05,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff00E396)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(100.0)),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/image 804.png',
                                              width: Get.width * 0.05,
                                              height: Get.width * 0.05,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                  height: Get.height * 0.13,
                                  width: Get.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: const Color(0xff4C52D9),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.025),
                                            child: Text(
                                              "N 2,300,000",
                                              style: AppTextStyle.headline4
                                                  .copyWith(
                                                color: Colors.black,
                                                fontSize: Get.width * 0.04,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.025),
                                            child: Text(
                                              "Total Earning",
                                              style: AppTextStyle.headline4
                                                  .copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: Get.width * 0.035,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Container(
                                          height: Get.height * 0.05,
                                          width: Get.height * 0.05,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff4C52D9)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(100.0)),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/images/image 804.png',
                                              width: Get.width * 0.05,
                                              height: Get.width * 0.05,
                                              color: const Color(0xff4C52D9),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (controller.currentType == "Service Partner")
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                    if (controller.currentType == "Service Partner")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            top: 10.0),
                        child: Text(
                          "Upcoming Deadlines",
                          style: AppTextStyle.subtitle1.copyWith(
                            color: Colors.black,
                            fontSize: Get.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    if (controller.currentType == "Service Partner")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            top: 20.0),
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.13,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF9F9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color: const Color(0xffFFF9F9),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: Get.width * 0.01,
                                color: const Color(0xffDC1515),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.025),
                                    child: Text(
                                      "Land Survey Project",
                                      style: AppTextStyle.headline4.copyWith(
                                        color: Colors.black,
                                        fontSize: Get.width * 0.04,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.025),
                                        child: Icon(
                                          Icons.calendar_today_rounded,
                                          color: Colors.black.withOpacity(0.5),
                                          size: Get.width * 0.045,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.01),
                                        child: Text(
                                          "Start  : 12 - 10- 22 ",
                                          style:
                                              AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.03),
                                        child: Icon(
                                          Icons.calendar_today_rounded,
                                          color: Colors.black.withOpacity(0.5),
                                          size: Get.width * 0.045,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.01),
                                        child: Text(
                                          "Due  : 12 - 01- 23  ",
                                          style:
                                              AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.025),
                                        child: Text(
                                          "Project Status :",
                                          style:
                                              AppTextStyle.headline4.copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.025),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0xffE8F4FE),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            child: Text(
                                              "Ongoing",
                                              style: AppTextStyle.headline4
                                                  .copyWith(
                                                color: AppColors.primary,
                                                fontSize: Get.width * 0.035,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    if (controller.currentType == "Service Partner")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            top: 20.0),
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.13,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFFFF9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color: const Color(0xffFFF9F9),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: Get.width * 0.01,
                                color: const Color(0xffFCE727),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.025),
                                    child: Text(
                                      "Land Survey Project",
                                      style: AppTextStyle.headline4.copyWith(
                                        color: Colors.black,
                                        fontSize: Get.width * 0.04,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.025),
                                        child: Icon(
                                          Icons.calendar_today_rounded,
                                          color: Colors.black.withOpacity(0.5),
                                          size: Get.width * 0.045,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.01),
                                        child: Text(
                                          "Start  : 12 - 10- 22 ",
                                          style:
                                              AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.03),
                                        child: Icon(
                                          Icons.calendar_today_rounded,
                                          color: Colors.black.withOpacity(0.5),
                                          size: Get.width * 0.045,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.01),
                                        child: Text(
                                          "Due  : 12 - 01- 23  ",
                                          style:
                                              AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.025),
                                        child: Text(
                                          "Project Status :",
                                          style:
                                              AppTextStyle.headline4.copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.025),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0xffE8F4FE),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            child: Text(
                                              "Ongoing",
                                              style: AppTextStyle.headline4
                                                  .copyWith(
                                                color: AppColors.primary,
                                                fontSize: Get.width * 0.035,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    if (controller.currentType == "Service Partner")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            top: 20.0),
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.13,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF9F9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color: const Color(0xffF9FAFF),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: Get.width * 0.01,
                                color: const Color(0xff3F79AD),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.025),
                                    child: Text(
                                      "Land Survey Project",
                                      style: AppTextStyle.headline4.copyWith(
                                        color: Colors.black,
                                        fontSize: Get.width * 0.04,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.025),
                                        child: Icon(
                                          Icons.calendar_today_rounded,
                                          color: Colors.black.withOpacity(0.5),
                                          size: Get.width * 0.045,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.01),
                                        child: Text(
                                          "Start  : 12 - 10- 22 ",
                                          style:
                                              AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.03),
                                        child: Icon(
                                          Icons.calendar_today_rounded,
                                          color: Colors.black.withOpacity(0.5),
                                          size: Get.width * 0.045,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.01),
                                        child: Text(
                                          "Due  : 12 - 01- 23  ",
                                          style:
                                              AppTextStyle.headline4.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.025),
                                        child: Text(
                                          "Project Status :",
                                          style:
                                              AppTextStyle.headline4.copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.025),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0xffE8F4FE),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            child: Text(
                                              "Ongoing",
                                              style: AppTextStyle.headline4
                                                  .copyWith(
                                                color: AppColors.primary,
                                                fontSize: Get.width * 0.035,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.05,
                          right: Get.width * 0.05,
                          top: 10.0),
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.05, right: Get.width * 0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(
                      height: Get.height * 0.015,
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

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.primary,
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          borderSide: const BorderSide(color: AppColors.primary, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 1500,
            color: const Color(0xffE6F3FF),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              850,
            );
          case 1:
            return makeGroupData(
              1,
              750,
            );
          case 2:
            return makeGroupData(
              2,
              125,
            );
          case 3:
            return makeGroupData(
              3,
              1250,
            );
          case 4:
            return makeGroupData(
              4,
              500,
            );
          case 5:
            return makeGroupData(
              5,
              750,
            );
          case 6:
            return makeGroupData(
              6,
              110,
            );
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      minY: 0,
      //maxY: 2000,
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getSideTitles,
            reservedSize: 50,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xffDEDEDE),
            width: 1,
          ),
          left: BorderSide(
            color: const Color(0xffDEDEDE),
            width: 1,
          ),
          right: BorderSide.none,
          top: BorderSide.none,
        ),
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(
        show: false,
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff85858A),
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Mon', style: style);
        break;
      case 1:
        text = const Text('Tue', style: style);
        break;
      case 2:
        text = const Text('Wed', style: style);
        break;
      case 3:
        text = const Text('Thu', style: style);
        break;
      case 4:
        text = const Text('Fri', style: style);
        break;
      case 5:
        text = const Text('Sat', style: style);
        break;
      case 6:
        text = const Text('Sun', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget getSideTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff85858A),
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
    String valueToDisplay = value.toInt().toString();
    if (valueToDisplay.length == 4) {
      valueToDisplay = valueToDisplay.substring(0, 2) + "M";
    } else if (valueToDisplay.length == 5) {
      valueToDisplay = valueToDisplay.substring(0, 2) + "K";
    } else {
      valueToDisplay = valueToDisplay + "K";
    }
    Widget text = Text(
      valueToDisplay == "0K" ? "0" : valueToDisplay,
      style: style,
      maxLines: 1,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
            );
          case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
            );
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
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
