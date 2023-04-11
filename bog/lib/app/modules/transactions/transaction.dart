import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';

import '../../data/model/transactions_model.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/new_app_bar.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  static const route = '/notification';

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late Future<ApiResponse> getTransactions;

  var search = '';

  @override
  void initState() {
    final controller = Get.find<HomeController>();
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
                      List<TransactionsModel> transactions =
                          <TransactionsModel>[];

                      for (var element in response) {
                        transactions.add(TransactionsModel.fromJson(element));
                      }

                      if (search.isNotEmpty) {
                        transactions = {
                          ...transactions.where((element) => element.type!
                              .toLowerCase()
                              .contains(search.toLowerCase())),
                          ...transactions.where((element) => element
                              .transactionId!
                              .toLowerCase()
                              .contains(search.toLowerCase())),
                          ...transactions.where((element) => element.amount
                              .toString()
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                        }.toList();
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
                                      left: width * 0.02, right: width * 0.02),
                                  child: SizedBox(
                                      height: Get.height * 0.06,
                                      width: Get.width  * 0.96,
                                      child: AppInput(
                                        hintText: "Search",
                                        prefexIcon: Icon(
                                          FeatherIcons.search,
                                          color:
                                              AppColors.grey.withOpacity(0.5),
                                        ),
                                        onChanged: (val) {
                                          if (search != val) {
                                            setState(() {
                                              search = val;
                                            });
                                          }
                                        },
                                      )),
                                ),
                             
                              ],
                            ),
                            
                            SizedBox(
                              height: width * 0.02,
                            ),
                            SizedBox(
                              height: Get.height * 0.74,
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
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: transaction
                                                              .transactionId ??
                                                          '',
                                                      style: AppTextStyle
                                                          .subtitle1
                                                          .copyWith(
                                                              fontSize:
                                                                  multiplier *
                                                                      0.07,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    (transaction.status ?? '')
                                                        .toUpperCase(),
                                                    style: AppTextStyle
                                                        .subtitle1
                                                        .copyWith(
                                                            fontSize:
                                                                multiplier *
                                                                    0.05,
                                                            color:
                                                                AppColors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                  child: Wrap(
                                                alignment: WrapAlignment.end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'NGN ${transaction.amount ?? 0}',
                                                        style: AppTextStyle
                                                            .subtitle1
                                                            .copyWith(
                                                                fontSize:
                                                                    multiplier *
                                                                        0.065,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      transaction.createdAt ==
                                                              null
                                                          ? const SizedBox
                                                              .shrink()
                                                          : Text(
                                                              DateFormat(
                                                                      'dd MMM yyyy')
                                                                  .format(transaction
                                                                      .createdAt!),
                                                              style:
                                                                  AppTextStyle
                                                                      .caption2
                                                                      .copyWith(
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                            )
                                                    ],
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
