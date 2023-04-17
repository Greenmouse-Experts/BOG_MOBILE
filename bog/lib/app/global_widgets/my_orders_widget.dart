import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../data/model/my_order_model.dart';
import '../modules/orders/order_details.dart';
import 'app_loader.dart';

class MyOrdersWidget extends StatelessWidget {
  final String image;
  final String price;
  final DateTime date;
  final String status;
  final Color statusColor;
  final String orderItemName;
  final String id;
  final Function cancelOrder;
  final String? refundStatus;
  const MyOrdersWidget(
      {super.key,
      required this.price,
      required this.date,
      required this.status,
      required this.statusColor,
      required this.orderItemName,
      required this.image,
      required this.id,
      required this.cancelOrder,
      this.refundStatus});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(OrderDetails(
          id: id,
        ));
      },
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                        imageUrl: image,
                        // 'https://media.premiumtimesng.com/wp-content/files/2021/07/1625980458926blob.png',

                        fit: BoxFit.cover,
                        placeholder: (context, url) => const AppLoader(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error))),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.015),
                      child: Text(orderItemName),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.015),
                      child: Text(
                        date.format(DateTimeFormats.american),
                        style: AppTextStyle.caption.copyWith(
                          color: const Color(0xFF9A9A9A),
                          fontSize: Get.width * 0.033,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.015),
                      child: Text(
                        status.capitalize!,
                        style: AppTextStyle.caption.copyWith(
                          color: statusColor,
                          fontSize: Get.width * 0.033,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015, top: 5),
                    child: Text(
                      price,
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.primary,
                        fontSize: Get.width * 0.035,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  status == 'Pending'
                      ? SizedBox(
                          width: Get.width * 0.2,
                          child: AppButton(
                            bckgrndColor: Colors.red,
                            title: 'Cancel',
                            onPressed: () {
                              AppOverlay.showInfoDialog(
                                  title: 'Cancel Order',
                                  content:
                                      'Are you sure you want to cancel this order',
                                  onPressed: () async {
                                    final controller =
                                        Get.find<HomeController>();
                                    final response = await controller.userRepo
                                        .getData('/orders/cancel-order/$id');
                                    if (response.isSuccessful) {
                                      Get.back();
                                      AppOverlay.successOverlay(
                                          message:
                                              'Order cancelled successfully',
                                          onPressed: () {
                                            Get.back();
                                            cancelOrder();
                                          });
                                    } else {
                                      Get.snackbar(
                                          'Error',
                                          response.message ??
                                              'An error occurred',
                                          backgroundColor: Colors.red,
                                          colorText:
                                              AppColors.backgroundVariant1);
                                    }
                                  },
                                  doubleFunction: true,
                                  buttonText: 'Cancel');
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  status == 'Cancelled'
                      ? Text(
                          'Status: ${refundStatus == 'request refund' ? 'Pending' : 'Not Refunded'}',
                          style: AppTextStyle.caption
                              .copyWith(color: Colors.black),
                        )
                      : const SizedBox.shrink(),
                  status == "Cancelled"
                      ? PopupMenuButton(
                          child: const Icon(Icons.more_vert_outlined),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  child: TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        AppOverlay.showInfoDialog(
                                            title: 'Request Refund',
                                            content:
                                                'Are you sure you want to request refund on this order',
                                            onPressed: () async {
                                              final controller =
                                                  Get.find<HomeController>();
                                              final response = await controller
                                                  .userRepo
                                                  .getData(
                                                      '/orders/request-refund/$id');
                                              if (response.isSuccessful) {
                                                Get.back();
                                                AppOverlay.successOverlay(
                                                    message:
                                                        'Refund requested successfully',
                                                    onPressed: () {
                                                      Get.back();
                                                      cancelOrder();
                                                    });
                                              } else {
                                                Get.snackbar(
                                                    'Error',
                                                    response.message ??
                                                        'An error occurred',
                                                    backgroundColor: Colors.red,
                                                    colorText: AppColors
                                                        .backgroundVariant1);
                                              }
                                            },
                                            doubleFunction: true,
                                            buttonText: 'Request');
                                      },
                                      child: Text(
                                        'Request Refund',
                                        style: AppTextStyle.caption2
                                            .copyWith(color: Colors.red),
                                      )))
                            ];
                          })
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyOrderWidgetList extends StatelessWidget {
  final List<MyOrderItem> orderItemsList;

  final Color statusColor;
  final String status;
  final Function cancelOrder;
  final List<MyOrdersModel>? orders;
  const MyOrderWidgetList(
      {super.key,
      required this.orderItemsList,
      required this.statusColor,
      required this.cancelOrder,
      required this.status,
      this.orders});

  @override
  Widget build(BuildContext context) {
    String? refundStatus;

    return ListView.builder(
      itemCount: orderItemsList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      padding: EdgeInsets.only(left: Get.width * 0.02, right: Get.width * 0.02),
      itemBuilder: (BuildContext context, int i) {
        if (orders != null) {
          final orderNew = orders!.firstWhere(
              (element) => element.orderItems.contains(orderItemsList[i]));
          refundStatus = orderNew.refundStatus;
        }
        return MyOrdersWidget(
          status: status,
          statusColor: statusColor,
          id: orderItemsList[i].orderId!,
          image: orderItemsList[i].product!.image,
          date: orderItemsList[i].createdAt ?? DateTime.now(),
          orderItemName: orderItemsList[i].product!.name,
          price: orderItemsList[i].amount.toString(),
          cancelOrder: cancelOrder,
          refundStatus: refundStatus,
        );
      },
    );
  }
}

class MyDoubleOrderWidgetList extends StatelessWidget {
  final List<MyOrderItem> orderItemsList;
  final List<MyOrderItem> orderItemsList2;

  final Function cancelOrder;
  const MyDoubleOrderWidgetList({
    super.key,
    required this.orderItemsList,
    required this.cancelOrder,
    required this.orderItemsList2,
  });

  @override
  Widget build(BuildContext context) {
    final orders = [...orderItemsList, ...orderItemsList2];
    return ListView.builder(
      itemCount: orders.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: false,
      padding: EdgeInsets.only(left: Get.width * 0.02, right: Get.width * 0.02),
      itemBuilder: (BuildContext context, int i) {
        return MyOrdersWidget(
          status: orderItemsList.contains(orders[i]) ? 'Pending' : 'Approved',
          statusColor: orderItemsList.contains(orders[i])
              ? const Color(0xFFEC8B20)
              : Colors.green,
          id: orders[i].orderId!,
          image: orders[i].product!.image,
          date: orders[i].createdAt ?? DateTime.now(),
          orderItemName: orders[i].product!.name,
          price: orders[i].amount.toString(),
          cancelOrder: cancelOrder,
        );
      },
    );
  }
}
