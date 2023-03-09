// import 'dart:convert';

import 'package:bog/app/data/model/my_order_model.dart';
import 'package:bog/app/data/providers/api_response.dart';
import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/bottom_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../home/pages/CartTab.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
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
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    List<MyOrdersModel> myOrders = [];

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'MyOrderScreen',
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
                                    "My Orders",
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
                            text: 'Ongoing',
                            iconMargin: EdgeInsets.zero,
                          ),
                          Tab(
                            text: 'Completed',
                            iconMargin: EdgeInsets.zero,
                          ),
                          Tab(
                            text: 'Cancelled',
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
                      FutureBuilder<ApiResponse>(
                          future:
                              controller.userRepo.getData("/orders/my-orders"),
                          builder: (context, snapshot) {
                            // if (snapshot.connectionState ==
                            //     ConnectionState.waiting) {
                            //   return const AppLoader();
                            // } else if (snapshot.connectionState ==
                            //     ConnectionState.done) {
                            //   if (snapshot.hasData) {
                            //      final my2po = jsonDecode(snapshot.data);
                            //     // myOrders = MyOrdersModel.fromJsonList(
                            //     //     snapshot.data!.data as List<dynamic>);
                            //     final my2Orders =
                            //         snapshot.data!.data.toString();
                            //     return Text('Result: ${my2Orders.toString()}');
                            //   } else if (snapshot.hasError) {
                            //     return Text('Error: ${snapshot.error}');
                            //   } else {
                            //     return const Text('No result');
                            //   }
                            // } else {
                            //   return const Text('Active');
                            // }
                            return SizedBox(
                              height: Get.height * 0.78,
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.75,
                                          child: ListView.builder(
                                            itemCount: 4,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: false,
                                            padding: EdgeInsets.only(
                                                left: width * 0.02,
                                                right: width * 0.02),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return const OrderItem();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.75,
                                          child: ListView.builder(
                                            itemCount: 4,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: false,
                                            padding: EdgeInsets.only(
                                                left: width * 0.02,
                                                right: width * 0.02),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return const OrderItem(
                                                status: 'Completed',
                                                statusColor: Colors.green,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.75,
                                          child: ListView.builder(
                                            itemCount: 4,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: false,
                                            padding: EdgeInsets.only(
                                                left: width * 0.02,
                                                right: width * 0.02),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return const OrderItem(
                                                status: 'Cancelled',
                                                statusColor:
                                                    AppColors.bostonUniRed,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
                bottomNavigationBar:
                    HomeBottomWidget(controller: controller, isHome: false));
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
