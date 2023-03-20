import 'package:bog/app/data/model/order_details.dart';
import 'package:bog/app/data/providers/api_response.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/custom_app_bar.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/order_details_builder.dart';

class OrderDetails extends StatefulWidget {
  final String id;
  const OrderDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  // var pageController = PageController();
  late Future<ApiResponse> orderFuture;
  @override
  void initState() {
    final controller = Get.find<HomeController>();
    orderFuture =
        controller.userRepo.getData('/orders/order-detail/${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  var title = Get.arguments as String?;
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'OrderDetails',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppBar(title: 'Order Details'),
                      FutureBuilder<ApiResponse>(
                          future: orderFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data!.isSuccessful) {
                              final orderDetail = OrderDetailsModel.fromJson(
                                  snapshot.data!.data);
                              print(orderDetail.orderSlug);
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: width * 0.05,
                                    left: width * 0.045,
                                    top: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order ID: ${orderDetail.orderSlug}',
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    // PageInput(hint: 'Leave review', label: 'Order Review', isTextArea: true, controller: controller.orderReview,),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.primary
                                              .withOpacity(0.25)),
                                      child: Text(
                                        'Status: ${orderDetail.status}',
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.07,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text('Item(s)'),
                                    const SizedBox(height: 5),
                                    OrderDetailsBuilder(
                                      orderItems: orderDetail.orderItems!,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: AppColors.grey.withOpacity(0.1),
                                    ),
                                    FeeSection(
                                        leading: 'Sub Total',
                                        content:
                                            '₦ ${orderDetail.totalAmount}'),
                                    FeeSection(
                                        leading: 'Delivery Fee',
                                        content:
                                            '₦ ${orderDetail.deliveryFee}'),
                                    FeeSection(
                                        leading: 'Discount',
                                        content: '₦ ${orderDetail.discount}'),
                                    Divider(
                                      thickness: 1,
                                      color: AppColors.grey.withOpacity(0.1),
                                    ),
                                    FeeSection(
                                        leading: 'Order Total',
                                        content:
                                            '₦ ${orderDetail.totalAmount}'),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Transaction Reference',
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: Get.width * 0.3,
                                              child: Text(
                                                'Payment Ref: ${orderDetail.orderItems![0].paymentInfo!.reference}',
                                                maxLines: 2,
                                              )),
                                          Text(DateFormat.yMd()
                                              .format(orderDetail.createdAt!)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                                '${orderDetail.orderItems![0].paymentInfo!.amount}'),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Review Order',
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    PageInput(
                                        hint: 'Leave review',
                                        label: '',
                                        isTextArea: true,
                                        controller: controller.orderReview)
                                  ],
                                ),
                              );
                            } else {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return const Text('No order detail');
                              }
                              return const AppLoader();
                            }
                          }),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: HomeBottomWidget(
                  controller: controller, doubleNavigate: false, isHome: false),
            );
          }),
    );
  }
}

class OrderReview extends StatefulWidget {
  const OrderReview({super.key});

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  final reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PageInput(
      hint: 'Leave review',
      label: '',
      isTextArea: true,
      controller: reviewController,
    );
  }
}
