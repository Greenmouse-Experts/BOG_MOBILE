import 'package:bog/app/data/model/transactions_model.dart';
import 'package:bog/app/data/providers/api_response.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/bottom_widget.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';

import '../../global_widgets/app_input.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  static const route = '/notification';

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late Future<ApiResponse> getTransactions;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    // final userType = controller.currentType == 'Client'
    //     ? 'private_client'
    //     : controller.currentType == 'Corporate Client'
    //         ? 'corporate_client'
    //         : controller.currentType == 'Product Partner'
    //             ? 'vendor'
    //             : 'professional';
    getTransactions = controller.userRepo.getData('/transactions/user');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return GetBuilder<HomeController>(
        id: 'Transaction',
        builder: (controller) {
          return Scaffold(
              appBar: newAppBarBack(context, 'Transactions'),
              backgroundColor: AppColors.backgroundVariant2,
              body: FutureBuilder<ApiResponse>(
                  future: getTransactions,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const AppLoader();
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.data!.isSuccessful) {
                      final response = snapshot.data!.data as List<dynamic>;
                      final transactions = <TransactionsModel>[];

                      for (var element in response) {
                        transactions.add(TransactionsModel.fromJson(element));
                      }

                      return SizedBox(
                        width: Get.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: width * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.02, right: width * 0.0),
                                  child: SizedBox(
                                      height: Get.height * 0.055,
                                      width: Get.width * 0.78,
                                      child: AppInput(
                                        hintText: "Search",
                                        prefexIcon: Icon(
                                          FeatherIcons.search,
                                          color:
                                              AppColors.grey.withOpacity(0.5),
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: width * 0.02),
                                  child: SizedBox(
                                    height: Get.height * 0.054,
                                    width: Get.height * 0.054,
                                    child: Image.asset(
                                      "assets/images/Group 47358.png",
                                      height: width * 0.08,
                                      width: width * 0.08,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: width * 0.02,
                            ),
                            SizedBox(
                              height: Get.height * 0.75,
                              child: transactions.isEmpty
                                  ? const Center(
                                      child:
                                          Text('You have no transactions yet'),
                                    )
                                  : ListView.builder(
                                      itemCount: transactions.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                          left: width * 0.02,
                                          right: width * 0.02),
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final transaction = transactions[index];
                                        return SizedBox(
                                          height: Get.height * 0.08,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Get.width * 0.1,
                                                height: Get.width * 0.1,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffE8F4FE),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/images/briefing-7 5.png",
                                                    width: Get.width * 0.05,
                                                    height: Get.width * 0.05,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.02,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: transaction
                                                          .transactionId ??
                                                      '',
                                                  style: AppTextStyle.subtitle1
                                                      .copyWith(
                                                          fontSize:
                                                              multiplier * 0.07,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          transaction.status ??
                                                              '',
                                                      style: AppTextStyle
                                                          .subtitle1
                                                          .copyWith(
                                                              fontSize:
                                                                  multiplier *
                                                                      0.05,
                                                              color: AppColors
                                                                  .grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Wrap(
                                                alignment: WrapAlignment.end,
                                                children: [
                                                  Text(
                                                    transaction.amount
                                                        .toString(),
                                                    style: AppTextStyle
                                                        .subtitle1
                                                        .copyWith(
                                                            fontSize:
                                                                multiplier *
                                                                    0.065,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ))
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('An error occurred'),
                      );
                    }
                  }),
              bottomNavigationBar: HomeBottomWidget(
                  isHome: false,
                  controller: controller,
                  doubleNavigate: false));
        });
  }
}
