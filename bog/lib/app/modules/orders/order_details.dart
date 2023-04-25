import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/order_details.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/order_details_builder.dart';

class OrderDetails extends StatefulWidget {
  final String id;
  const OrderDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late Future<ApiResponse> orderFuture;

  int orderRating = 0;
  TextEditingController reviewController = TextEditingController();
  @override
  void initState() {
    final controller = Get.find<HomeController>();
    orderFuture =
        controller.userRepo.getData('/orders/order-detail/${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                            'NGN ${(orderDetail.totalAmount ?? 0) - (orderDetail.deliveryFee ?? 0)}'),
                                    FeeSection(
                                        leading: 'Delivery Fee',
                                        content:
                                            'NGN ${orderDetail.deliveryFee}'),
                                    FeeSection(
                                        leading: 'Discount',
                                        content: 'NGN ${orderDetail.discount}'),
                                    Divider(
                                      thickness: 1,
                                      color: AppColors.grey.withOpacity(0.1),
                                    ),
                                    FeeSection(
                                        leading: 'Order Total',
                                        content:
                                            'NGN ${orderDetail.totalAmount}'),
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
                                    orderDetail.orderReview!.isNotEmpty
                                        ? const Center()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PageInput(
                                                  hint: 'Leave review',
                                                  label: 'Review Order',
                                                  isTextArea: true,
                                                  controller: reviewController),
                                              Text(
                                                'Leave a rating',
                                                style: AppTextStyle.bodyText2
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                              RatingBar.builder(
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  orderRating = rating.toInt();
                                                },
                                              ),
                                              SizedBox(
                                                  height: Get.height * 0.02),
                                              AppButton(
                                                title: 'Submit Review',
                                                onPressed: () async {
                                                  if (reviewController
                                                          .text.isEmpty ||
                                                      orderRating == 0) {
                                                    Get.snackbar(
                                                        'Complete Fields',
                                                        'You need to fill all fields before giving a review',
                                                        colorText: AppColors
                                                            .backgroundVariant1,
                                                        backgroundColor:
                                                            Colors.red);
                                                    return;
                                                  }
                                                  final response = await controller
                                                      .userRepo
                                                      .postData(
                                                          '/review/product/create-review',
                                                          {
                                                        "star": orderRating,
                                                        "review":
                                                            reviewController
                                                                .text,
                                                        "orderId": widget.id
                                                      });
                                                  if (response.isSuccessful) {
                                                    AppOverlay.successOverlay(
                                                      message:
                                                          'Order Reviewed Successfully',
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                    );
                                                  } else {
                                                    Get.snackbar(
                                                        'Error',
                                                        response.message ??
                                                            'An error occurred',
                                                        colorText: AppColors
                                                            .backgroundVariant1,
                                                        backgroundColor:
                                                            Colors.red);
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                  ],
                                ),
                              );
                            } else {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return SizedBox(
                                    height: Get.height * 0.72,
                                    child: const Center(
                                        child: Text('No order detail')));
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

class MyReview extends StatelessWidget {
  const MyReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
