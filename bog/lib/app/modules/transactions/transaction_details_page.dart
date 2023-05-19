import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/data/model/transaction_info_model.dart';
import 'package:bog/app/data/providers/api_response.dart';
import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_loader.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/theme.dart';
import '../../data/model/transactions_model.dart';
import '../../global_widgets/new_app_bar.dart';

class TransactionDetailsPage extends StatelessWidget {
  final TransactionsModel transaction;
  const TransactionDetailsPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
      child: GetBuilder<HomeController>(builder: (controller) {
        return Scaffold(
          appBar: newAppBarBack(context, 'Transaction Details'),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 2, horizontal: Get.width * 0.04),
              child: FutureBuilder<ApiResponse>(
                  future: controller.userRepo
                      .getData('/transaction/${transaction.id}'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const AppLoader();
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error!.toString()),
                      );
                    }
                    final transactionInfo =
                        TransactionInfoModel.fromJson(snapshot.data!.data!);
                    return Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: Get.height * 0.01),
                            child: Row(
                              children: [
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Project ID:  ',
                                        style: AppTextStyle.subtitle2.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: transaction.transactionId,
                                        style: AppTextStyle.subtitle2.copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600)),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.007),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: Get.height * 0.01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width,
                                ),
                                Text(
                                  'Transaction Details',
                                  style: AppTextStyle.subtitle1.copyWith(
                                      fontSize: Get.textScaleFactor * 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: Get.height * 0.03),
                                LineDetail(
                                    title: 'Transaction Date',
                                    content: DateFormat.yMMMMd().format(
                                        transaction.createdAt ??
                                            DateTime.now())),
                                LineDetail(
                                    title: 'Payment Reference',
                                    content:
                                        transaction.paymentReference ?? ''),
                                LineDetail(
                                    title: 'Amount',
                                    content: 'NGN ${transaction.amount ?? 0}'),
                                LineDetail(
                                    title: 'Transaction Status',
                                    content: transaction.status ?? ''),
                                LineDetail(
                                    title: 'Transaction Type',
                                    content: transaction.type ?? ''),
                                LineDetail(
                                    title: 'Transaction Description',
                                    content: transaction.description ?? ''),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.05),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: Get.height * 0.01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Get.width,
                                ),
                                Text(
                                  'User Details',
                                  style: AppTextStyle.subtitle1.copyWith(
                                      fontSize: Get.textScaleFactor * 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: Get.height * 0.03),
                                LineDetail(
                                    title: 'User Name',
                                    content: transactionInfo
                                            .transaction?.user?.name ??
                                        ''),
                                LineDetail(
                                    title: 'Order / Project Id',
                                    content: transactionInfo.detail?.id ?? ''),
                                LineDetail(
                                    title: 'User Email',
                                    content:
                                        '${transactionInfo.transaction?.user?.email ?? 0}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        );
      }),
    );
  }
}

class LineDetail extends StatelessWidget {
  final String title;
  final String content;
  const LineDetail({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: Get.width * 0.3,
              child: Text(
                '$title :',
                style: AppTextStyle.subtitle1.copyWith(
                    fontSize: multiplier * 0.058,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                maxLines: 2,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: Get.width * 0.5,
              child: Text(
                content,
                maxLines: 2,
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Divider(
          color: Colors.grey.withOpacity(0.3),
        )
      ],
    );
  }
}
