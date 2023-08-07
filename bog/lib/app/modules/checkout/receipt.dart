import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:open_filex/open_filex.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/order_details.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/new_app_bar.dart';
import '../../global_widgets/order_details_builder.dart';
import 'pdf_page.dart';

class AppReceipt extends StatefulWidget {
  final String id;
  const AppReceipt({Key? key, required this.id}) : super(key: key);

  @override
  State<AppReceipt> createState() => _AppReceiptState();
}

class _AppReceiptState extends State<AppReceipt> {
  late Future<ApiResponse> orderFuture;
  @override
  void initState() {
    final controller = Get.find<HomeController>();
    orderFuture =
        controller.userRepo.getData('/orders/order-detail/${widget.id}');
    super.initState();
  }

  double? _progress;

  Future<void> downloadFile(String url, String slug) async {
    final dio = Dio();
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${appDocumentsDirectory.path}/$slug.pdf';

    try {
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final file = File(filePath);
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      OpenFilex.open(file.path);
    } catch (e) {
      AppOverlay.showInfoDialog(title: 'Error', content: e.toString());
    }
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
              appBar: newAppBarBack(context, 'Order Details'),
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.check_circle_rounded,
                                        size: Get.width * 0.25,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Thank You for Your Order',
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.1,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'The order confimation email with details of your order and a link to track the progress has been sent to your email address.',
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Order ID: ${orderDetail.orderSlug}',
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.07,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    const Text('Item(s)'),
                                    const SizedBox(height: 5),
                                    OrderDetailsBuilder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      orderItems: orderDetail.orderItems!,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: AppColors.grey.withOpacity(0.1),
                                    ),
                                    FeeSection(
                                        leading: 'Sub Total',
                                        content:
                                            'NGN ${orderDetail.totalAmount}'),
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
                                    Center(
                                      child: _progress != null
                                          ? const CircularProgressIndicator(
                                              color: AppColors.primary,
                                            )
                                          : AppButton(
                                              title: 'Print Receipt',
                                              onPressed: () async {
                                                final link =
                                                    orderDetail.orderSlug!;
                                                String strippedLink =
                                                    link.replaceAll(
                                                        RegExp(r'[^\d]+'), '');
                                                final finalLink =
                                                    'https://bog.greenmouseproperties.com/uploads/$strippedLink.pdf';
                                                Platform.isIOS
                                                    ? await downloadFile(
                                                        finalLink, strippedLink)
                                                    : FileDownloader
                                                        .downloadFile(
                                                        url: finalLink,
                                                        onProgress: (fileName,
                                                            progress) {
                                                          setState(() {
                                                            _progress =
                                                                progress;
                                                          });
                                                        },
                                                        onDownloadCompleted:
                                                            (path) {
                                                          AppOverlay
                                                              .showInfoDialog(
                                                            title:
                                                                'Download Complete',
                                                            content:
                                                                'Your receipt has downloaded successfully',
                                                            onPressed: () {
                                                              Get.to(() =>
                                                                  PDFScreen(
                                                                    path: path,
                                                                  ));
                                                              // PDFView(
                                                              //   filePath: path,
                                                              //   enableSwipe: true,
                                                              //   swipeHorizontal: true,
                                                              //   autoSpacing: false,
                                                              //   pageFling: false,
                                                              // );
                                                            },
                                                          );
                                                          setState(() {
                                                            _progress = null;
                                                          });
                                                        },
                                                        onDownloadError:
                                                            (errorMessage) {
                                                          AppOverlay.showInfoDialog(
                                                              title:
                                                                  errorMessage,
                                                              content:
                                                                  'Please try again later!');
                                                          setState(() {
                                                            _progress = null;
                                                          });
                                                        },
                                                      );
                                              },
                                            ),
                                    )
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
