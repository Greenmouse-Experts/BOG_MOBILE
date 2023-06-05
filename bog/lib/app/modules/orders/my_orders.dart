import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/my_order_model.dart' as order;
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/my_orders_widget.dart';
import '../../global_widgets/new_app_bar.dart';

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

  late Future<ApiResponse> getOrders;

  var searchPending = '';
  var searchCompleted = '';
  var searchCancelled = '';

  @override
  void initState() {
    super.initState();
    initializeData();
    tabController = TabController(length: 3, vsync: this);
  }

  void initializeData() {
    final controller = Get.find<HomeController>();
    final userType = controller.currentType == 'Client'
        ? 'private_client'
        : 'corporate_client';

    getOrders =
        controller.userRepo.getData("/orders/my-orders?userType=$userType");
  }

  void onApiChange() {
    setState(() {
      initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;

    List<order.MyOrderItem> getAllOrderItems(List<order.MyOrdersModel> orders) {
      return orders.expand((order) => order.orderItems).toList();
    }

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'MyOrderScreen',
          builder: (controller) {
            return Scaffold(
                appBar: newAppBarBack(context, 'My Orders'),
                backgroundColor: AppColors.backgroundVariant2,
                body: SafeArea(
                  child: SizedBox(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            fontSize: Get.width > 600
                                ? Get.width * 0.025
                                : Get.width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: Get.width > 600
                                ? Get.width * 0.025
                                : Get.width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: const [
                            Tab(
                              text: 'Pending',
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
                            future: getOrders,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const AppLoader();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data!.isSuccessful) {
                                  if (snapshot.hasData) {
                                    final res =
                                        snapshot.data!.data as List<dynamic>;

                                    final myOrdersData =
                                        <order.MyOrdersModel>[];
                                    for (var element in res) {
                                      myOrdersData.add(
                                          order.MyOrdersModel.fromJson(
                                              element));
                                    }

                                    final pendingOrders = myOrdersData
                                        .where((element) =>
                                            element.status == 'pending')
                                        .toList();
                                    final approvedOrders = myOrdersData
                                        .where((element) =>
                                            element.status == 'approved')
                                        .toList();
                                    final completedOrders = myOrdersData
                                        .where((element) =>
                                            element.status == 'completed')
                                        .toList();
                                    final cancelledOrders = myOrdersData
                                        .where((element) =>
                                            element.status == 'cancelled')
                                        .toList();
                                    List<order.MyOrderItem> pendingItems =
                                        getAllOrderItems(pendingOrders);

                                    List<order.MyOrderItem> approvedItems =
                                        getAllOrderItems(approvedOrders);

                                    if (searchPending.isNotEmpty) {
                                      pendingItems = {
                                        ...pendingItems.where((element) =>
                                            element.product!.name
                                                .toLowerCase()
                                                .contains(searchPending
                                                    .toLowerCase())),
                                        ...pendingItems.where((element) =>
                                            element.orderId!
                                                .toLowerCase()
                                                .contains(searchPending
                                                    .toLowerCase()))
                                      }.toList();
                                    }
                                    List<order.MyOrderItem> completedItems =
                                        getAllOrderItems(completedOrders);
                                    if (searchCompleted.isNotEmpty) {
                                      completedItems = {
                                        ...completedItems.where((element) =>
                                            element
                                                .product!.name
                                                .toLowerCase()
                                                .contains(searchCompleted
                                                    .toLowerCase())),
                                        ...completedItems.where((element) =>
                                            element
                                                .orderId!
                                                .toLowerCase()
                                                .contains(searchCompleted
                                                    .toLowerCase()))
                                      }.toList();
                                    }
                                    List<order.MyOrderItem> cancelledItems =
                                        getAllOrderItems(cancelledOrders);
                                    if (searchCancelled.isNotEmpty) {
                                      cancelledItems = {
                                        ...cancelledItems.where((element) =>
                                            element
                                                .product!.name
                                                .toLowerCase()
                                                .contains(searchCancelled
                                                    .toLowerCase())),
                                        ...cancelledItems.where((element) =>
                                            element
                                                .orderId!
                                                .toLowerCase()
                                                .contains(searchCancelled
                                                    .toLowerCase()))
                                      }.toList();
                                    }

                                    return SizedBox(
                                      height: Get.height * 0.72,
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
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal:
                                                          Get.width * 0.04),
                                                  child: AppInput(
                                                    hintText:
                                                        'Search with name or keyword ...',
                                                    filledColor: Colors.grey
                                                        .withOpacity(.1),
                                                    prefexIcon: Icon(
                                                      FeatherIcons.search,
                                                      color: Colors.black
                                                          .withOpacity(.5),
                                                      size: Get.width > 600
                                                          ? Get.width * 0.03
                                                          : Get.width * 0.05,
                                                    ),
                                                    onChanged: (val) {
                                                      if (searchPending !=
                                                          val) {
                                                        setState(() {
                                                          searchPending = val;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: Get.height * 0.66,
                                                    child: [
                                                      ...pendingItems,
                                                      ...approvedItems
                                                    ].isEmpty
                                                        ? const Center(
                                                            child: Text(
                                                                'No pending Orders'),
                                                          )
                                                        : MyDoubleOrderWidgetList(
                                                            cancelOrder: () {
                                                              onApiChange();
                                                            },
                                                            orderItemsList:
                                                                pendingItems,
                                                            orderItemsList2:
                                                                approvedItems,
                                                          ))
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
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal:
                                                          Get.width * 0.04),
                                                  child: AppInput(
                                                    hintText:
                                                        'Search with name or keyword ...',
                                                    filledColor: Colors.grey
                                                        .withOpacity(.1),
                                                    prefexIcon: Icon(
                                                      FeatherIcons.search,
                                                      color: Colors.black
                                                          .withOpacity(.5),
                                                      size: Get.width > 600
                                                          ? Get.width * 0.03
                                                          : Get.width * 0.05,
                                                    ),
                                                    onChanged: (val) {
                                                      if (searchCompleted !=
                                                          val) {
                                                        setState(() {
                                                          searchCompleted = val;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: Get.height * 0.66,
                                                    child: completedItems
                                                            .isEmpty
                                                        ? const Center(
                                                            child: Text(
                                                                'No Completed Orders'),
                                                          )
                                                        : MyOrderWidgetList(
                                                            cancelOrder: () {
                                                              onApiChange();
                                                            },
                                                            orderItemsList:
                                                                completedItems,
                                                            status: 'Completed',
                                                            statusColor:
                                                                Colors.green))
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
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal:
                                                          Get.width * 0.04),
                                                  child: AppInput(
                                                    hintText:
                                                        'Search with name or keyword ...',
                                                    filledColor: Colors.grey
                                                        .withOpacity(.1),
                                                    prefexIcon: Icon(
                                                      FeatherIcons.search,
                                                      color: Colors.black
                                                          .withOpacity(.5),
                                                      size: Get.width > 600
                                                          ? Get.width * 0.03
                                                          : Get.width * 0.05,
                                                    ),
                                                    onChanged: (val) {
                                                      if (searchCancelled !=
                                                          val) {
                                                        setState(() {
                                                          searchCancelled = val;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: Get.height * 0.66,
                                                    child: cancelledItems
                                                            .isEmpty
                                                        ? const Center(
                                                            child: Text(
                                                                'No cancelled Orders'),
                                                          )
                                                        : MyOrderWidgetList(
                                                            orders:
                                                                cancelledOrders,
                                                            cancelOrder: () {
                                                              onApiChange();
                                                            },
                                                            status: 'Cancelled',
                                                            orderItemsList:
                                                                cancelledItems,
                                                            statusColor:
                                                                Colors.red))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:   [
                                        Center(
                                          child: Text('An error occurred'),
                                        ),
                                      ],
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return TabBarView(
                                      controller: tabController,
                                      children: [
                                        Center(
                                          child: Text(
                                              'Error: ${snapshot.error.toString()}'),
                                        ),
                                        Center(
                                          child: Text(
                                              'Error: ${snapshot.error.toString()}'),
                                        ),
                                        Center(
                                          child: Text(
                                              'Error: ${snapshot.error.toString()}'),
                                        ),
                                      ]);
                                } else {
                                  return SizedBox(
                                    height: Get.height * 0.72,
                                    child: TabBarView(
                                      controller: tabController,
                                      children: [
                                        SingleChildScrollView(
                                          child: SizedBox(
                                              height: Get.height * 0.68,
                                              child: const Center(
                                                child:
                                                    Text('No pending Orders'),
                                              )),
                                        ),
                                        SingleChildScrollView(
                                          child: SizedBox(
                                              height: Get.height * 0.68,
                                              child: const Center(
                                                child:
                                                    Text('No Completed Orders'),
                                              )),
                                        ),
                                        SingleChildScrollView(
                                          child: SizedBox(
                                              height: Get.height * 0.68,
                                              child: const Center(
                                                child:
                                                    Text('No cancelled Orders'),
                                              )),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                return const Text('Active');
                              }
                            })
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
