import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

import '../../../core/theme/theme.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/admin_progress_model.dart';
import '../../data/model/client_project_model.dart';

import '../../data/model/cost_summary_model.dart';
import '../../data/model/log_in_model.dart';
import '../../data/model/project_transactions_update.dart';
import '../../data/providers/api.dart';
import '../../data/providers/api_response.dart';

import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/new_app_bar.dart';
import '../orders/order_details.dart';

class NewProjectDetailPage extends StatefulWidget {
  final String id;
  final bool isClient;
  const NewProjectDetailPage(
      {super.key, required this.id, required this.isClient});

  @override
  State<NewProjectDetailPage> createState() => _NewProjectDetailPageState();
}

class _NewProjectDetailPageState extends State<NewProjectDetailPage> {
  late Future<List<ApiResponse>> getAllDetails;

  var publicKey = Api.publicKey;
  final plugin = PaystackPlugin();
  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);

    super.initState();
    getAllDetails = initializeData();
  }

  Future<List<ApiResponse>> initializeData() async {
    final controller = Get.find<HomeController>();

    final getProjectDetails =
        controller.userRepo.getData('/projects/v2/view-project/${widget.id}');
    final getAdminUpdate =
        controller.userRepo.getData('/projects/notification/${widget.id}/view');
    final getTransactions = controller.userRepo
        .getData('/projects/installments/${widget.id}/view?type=installment');
    final getCostSummary = controller.userRepo
        .getData('/projects/installments/${widget.id}/view?type=cost');
    final getAllDetails = [
      getProjectDetails,
      getAdminUpdate,
      getTransactions,
      getCostSummary
    ];

    List<ApiResponse> result = await Future.wait(getAllDetails);
    return result;
  }

  void onApiChange() {
    setState(() {
      getAllDetails = initializeData();
    });
  }

  void checkOut(String id, String installmentId, int priceChosen) async {
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    final price = priceChosen * 100;
    final email = logInDetails.email;
    Charge charge = Charge()
      ..amount = price
      ..reference = 'TR-${DateTime.now().millisecondsSinceEpoch}'
      ..email = email
      ..currency = "NGN";

    CheckoutResponse response1 = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
      fullscreen: true,
    );

    if (response1.status == true) {
      AppOverlay.loadingOverlay(asyncFunction: () async {
        final controller = Get.find<HomeController>();
        final response = await controller.userRepo
            .postData('/projects/installments/$id/payment', {
          "amount": priceChosen,
          "installmentId": installmentId,
          "reference": response1.reference
        });
        if (response.isSuccessful) {
          Get.snackbar('Success', 'Review sent',
              backgroundColor: AppColors.successGreen,
              colorText: AppColors.background);
          controller.currentBottomNavPage.value = 1;
          controller.updateNewUser(controller.currentType);
          controller.update(['home']);
        } else {
          Get.snackbar(
            'Error',
            response.message ?? 'An error occurred',
            colorText: AppColors.background,
            backgroundColor: Colors.red,
          );
        }
      });
    } else {
      Get.snackbar('Error', 'An error occcurred',
          backgroundColor: Colors.red, colorText: AppColors.background);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'projectDetails',
          builder: (controller) {
            return Scaffold(
              appBar: newAppBarBack(context, 'Project Details'),
              backgroundColor: AppColors.backgroundVariant2,
              body: SingleChildScrollView(
                child: FutureBuilder<List<ApiResponse>>(
                  future: getAllDetails,
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const AppLoader();
                    } else {
                      if (snapshot.hasData) {
                        final response1 = snapshot.data![0].data;
                        final clientProject =
                            ClientProjectModel.fromJson(response1);
                        final response2 =
                            snapshot.data![1].data as List<dynamic>;
                        var adminUpdates = <AdminProgressModel>[];
                        final response3 =
                            snapshot.data![2].data as List<dynamic>;
                        final transactionUpdates =
                            <ProjectTransactionsUpdate>[];
                        final response4 =
                            snapshot.data![3].data as List<dynamic>;
                        final costSummary = <CostSummaryModel>[];
                        for (var element in response2) {
                          adminUpdates
                              .add(AdminProgressModel.fromJson(element));
                        }
                        for (var element in response3) {
                          transactionUpdates
                              .add(ProjectTransactionsUpdate.fromJson(element));
                        }
                        for (var element in response4) {
                          costSummary.add(CostSummaryModel.fromJson(element));
                        }
                        adminUpdates.removeWhere(
                            (element) => element.by == 'service_partner');
                        return Padding(
                          padding: EdgeInsets.only(
                              right: Get.width * 0.05,
                              left: Get.width * 0.045,
                              top: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'Project ID:  ',
                                                  style: AppTextStyle.subtitle1
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                              TextSpan(
                                                  text:
                                                      clientProject.projectSlug,
                                                  style: AppTextStyle.subtitle1
                                                      .copyWith(
                                                          color:
                                                              AppColors.primary,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                            ]),
                                          ),
                                          Text(
                                            clientProject.status ?? '',
                                            style: AppTextStyle.caption
                                                .copyWith(
                                                    color: clientProject
                                                                .status ==
                                                            'pending'
                                                        ? AppColors
                                                            .serviceYellow
                                                        : clientProject
                                                                    .status ==
                                                                'approved'
                                                            ? AppColors
                                                                .successGreen
                                                            : Colors.black),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Request Date: ${DateFormat('dd/MMM/yyyy').format(clientProject.createdAt ?? DateTime.now())}',
                                            style: AppTextStyle.caption
                                                .copyWith(
                                                    color: AppColors.ashColor),
                                          ),
                                          Text(
                                            clientProject.totalEndDate == null
                                                ? ''
                                                : 'Due Date: ${DateFormat('dd/MMM/yyyy').format(clientProject.totalEndDate!)}',
                                            style: AppTextStyle.caption
                                                .copyWith(
                                                    color: AppColors.ashColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: Get.height * 0.01),
                                      Divider(
                                          color:
                                              AppColors.newAsh.withOpacity(0.3),
                                          thickness: 1),
                                      Row(
                                        children: [
                                          Container(
                                            width: Get.width * 0.25,
                                            height: Get.width * 0.25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/dummy_image.png'),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(width: Get.width * 0.02),
                                          SizedBox(
                                            height: Get.width * 0.2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ColoredRow(
                                                    color: AppColors.primary,
                                                    content:
                                                        clientProject.title ??
                                                            '',
                                                    title: 'Project Name'),
                                                ColoredRow(
                                                    color: AppColors
                                                        .serviceYellow
                                                        .withOpacity(0.7),
                                                    content: clientProject
                                                            .projectTypes ??
                                                        '',
                                                    title: 'Service Required'),
                                                ColoredRow(
                                                    color: AppColors
                                                        .successGreen
                                                        .withOpacity(0.3),
                                                    content:
                                                        'NGN ${clientProject.totalCost ?? 0}',
                                                    title: 'Project Cost'),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Project Completion Rate: ${clientProject.progress ?? 0}%',
                                        style: AppTextStyle.caption
                                            .copyWith(color: Colors.black),
                                      ),
                                      SizedBox(height: Get.height * 0.01),
                                      TweenAnimationBuilder(
                                        tween: Tween<double>(
                                            begin: 0,
                                            end: (clientProject.progress ?? 0)
                                                .toDouble()),
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        builder: (context, double value, _) =>
                                            LinearProgressIndicator(
                                          backgroundColor: AppColors.newAsh,
                                          minHeight: 5,
                                          color: (value / 100) < 0.5
                                              ? Colors.red
                                              : Colors.green,
                                          value: (value / 100),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Admin Progress Updates',
                                        style: AppTextStyle.caption2
                                            .copyWith(color: Colors.black),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color:
                                            AppColors.newAsh.withOpacity(0.3),
                                      ),
                                      adminUpdates.isEmpty
                                          ? SizedBox(
                                              width: Get.width,
                                              height: Get.height * 0.25,
                                              child: Center(
                                                  child: Text(
                                                'No updates available currently',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.caption2
                                                    .copyWith(
                                                        color: Colors.black),
                                              )))
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: adminUpdates.length,
                                              itemBuilder: (context, i) {
                                                final update = adminUpdates[i];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    leading: SizedBox(
                                                      width: Get.width * 0.16,
                                                      height: Get.width * 0.16,
                                                      child: AppAvatar(
                                                        name: 'Admin',
                                                        radius:
                                                            Get.width * 0.16,
                                                        imgUrl: '',
                                                      ),
                                                    ),
                                                    title: Text(
                                                      (update.by ?? '')
                                                          .toUpperCase(),
                                                      style: AppTextStyle
                                                          .subtitle1
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  Get.width *
                                                                      0.04),
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          update.body ?? '',
                                                          style: AppTextStyle
                                                              .subtitle1
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      Get.width *
                                                                          0.035),
                                                        ),
                                                        SizedBox(
                                                            height: Get.height *
                                                                0.005),
                                                        Text(
                                                          timeago
                                                                  .format(update
                                                                          .createdAt ??
                                                                      DateTime
                                                                          .now())
                                                                  .capitalizeFirst ??
                                                              '',
                                                          style: AppTextStyle
                                                              .subtitle1
                                                              .copyWith(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      Get.width *
                                                                          0.035),
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: update.image ==
                                                            null
                                                        ? const SizedBox
                                                            .shrink()
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  update.image!,
                                                              height:
                                                                  Get.width *
                                                                      0.2,
                                                              width: Get.width *
                                                                  0.2,
                                                              fit: BoxFit.cover,
                                                            )),
                                                  ),
                                                );
                                              }),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Transactions',
                                        style: AppTextStyle.caption2
                                            .copyWith(color: Colors.black),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color:
                                            AppColors.newAsh.withOpacity(0.3),
                                      ),
                                      transactionUpdates.isEmpty
                                          ? SizedBox(
                                              width: Get.width,
                                              height: Get.height * 0.25,
                                              child: Center(
                                                child: Text(
                                                  'No transactions available currently',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle.caption2
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ))
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  transactionUpdates.length,
                                              itemBuilder: (context, i) {
                                                final update =
                                                    transactionUpdates[i];
                                                return ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  title: Text(
                                                    update.title ?? '',
                                                    style: AppTextStyle
                                                        .bodyText2
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  subtitle: Text(
                                                    'NGN ${update.amount ?? 0}',
                                                    style: AppTextStyle
                                                        .bodyText2
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .ashColor),
                                                  ),
                                                  trailing: update.paid ==
                                                              null ||
                                                          update.paid == false
                                                      ? SizedBox(
                                                          width:
                                                              Get.width * 0.2,
                                                          height: Get.height *
                                                              0.065,
                                                          child: TextButton(
                                                            child: Text(
                                                              'Pay Now',
                                                              style: AppTextStyle
                                                                  .bodyText2
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .primary),
                                                            ),
                                                            onPressed: () {
                                                              checkOut(
                                                                  clientProject
                                                                          .id ??
                                                                      '',
                                                                  update.id ??
                                                                      '',
                                                                  update.amount ??
                                                                      10000);
                                                            },
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      Get.width *
                                                                          0.065),
                                                          child: Text(
                                                            'Paid',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: AppTextStyle
                                                                .bodyText2
                                                                .copyWith(
                                                              color: AppColors
                                                                  .successGreen,
                                                            ),
                                                          ),
                                                        ),
                                                );
                                              })
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cost Summary',
                                        style: AppTextStyle.caption2
                                            .copyWith(color: Colors.black),
                                      ),
                                      Divider(
                                        thickness: 1,
                                        color:
                                            AppColors.newAsh.withOpacity(0.3),
                                      ),
                                      costSummary.isEmpty
                                          ? SizedBox(
                                              width: Get.width,
                                              height: Get.height * 0.25,
                                              child: Center(
                                                  child: Text(
                                                'No summary available currently',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle.caption2
                                                    .copyWith(
                                                        color: Colors.black),
                                              )))
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: costSummary.length,
                                              itemBuilder: (context, i) {
                                                final cost = costSummary[i];
                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      minVerticalPadding: 0,
                                                      title: Text(
                                                        cost.title ?? '',
                                                        style: AppTextStyle
                                                            .bodyText2
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      trailing: Text(
                                                        'NGN ${cost.amount ?? 0}',
                                                        style: AppTextStyle
                                                            .bodyText2
                                                            .copyWith(
                                                                color: AppColors
                                                                    .productPurple),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      color: AppColors.newAsh
                                                          .withOpacity(0.3),
                                                    ),
                                                  ],
                                                );
                                              }),
                                    ],
                                  ),
                                ),
                              ),
                              clientProject.status != 'completed'
                                  ? const SizedBox.shrink()
                                  : clientProject.reviews!.isNotEmpty
                                      ? MyReview(
                                          orderRating:
                                              (clientProject.reviews![0].star ??
                                                      0)
                                                  .toDouble(),
                                          myReview: clientProject
                                                  .reviews![0].review ??
                                              '')
                                      : ReviewWidget(
                                          projectId: widget.id,
                                          onUpdate: () {
                                            onApiChange();
                                          },
                                        ),
                              SizedBox(height: Get.height * 0.01),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('An error occurred, Please Try again'),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('An error occurred'),
                        );
                      }
                    }
                  },
                ),
              ),
              bottomNavigationBar: HomeBottomWidget(
                  isHome: false, controller: controller, doubleNavigate: false),
            );
          }),
    );
  }
}

class RowTitle extends StatelessWidget {
  const RowTitle({
    super.key,
    required this.detail,
    required this.title,
  });

  final String detail;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.grey.withOpacity(0.9),
              fontSize: Get.textScaleFactor * 16),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          detail,
          style: TextStyle(
              color: Colors.black,
              fontSize: Get.textScaleFactor * 16,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class ReviewWidget extends StatefulWidget {
  final Function onUpdate;
  final String projectId;
  const ReviewWidget(
      {super.key, required this.onUpdate, required this.projectId});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  TextEditingController reviewController = TextEditingController();
  int orderRating = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.height * 0.01),
        PageInput(
          hint: 'Leave review',
          label: 'Review Project',
          controller: reviewController,
          isTextArea: true,
        ),
        Text(
          'Leave a rating',
          style: AppTextStyle.bodyText2.copyWith(color: Colors.black),
        ),
        RatingBar.builder(
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            orderRating = rating.toInt();
          },
        ),
        SizedBox(height: Get.height * 0.01),
        AppButton(
          title: 'Submit Review',
          onPressed: () async {
            if (reviewController.text.isEmpty || orderRating == 0) {
              Get.snackbar('Complete Fields',
                  'You need to fill all fields before giving a review',
                  colorText: AppColors.backgroundVariant1,
                  backgroundColor: Colors.red);
              return;
            }
            final controller = Get.find<HomeController>();
            final response = await controller.userRepo
                .postData('/review/project/create-review', {
              "projectId": widget.projectId,
              "star": orderRating,
              "review": reviewController.text
            });

            if (response.isSuccessful) {
              AppOverlay.successOverlay(
                message: 'Project Reviewed Successfully',
                onPressed: () {
                  Get.back();
                  widget.onUpdate();
                },
              );
            } else {
              Get.snackbar('Error', response.message ?? 'An error occurred',
                  colorText: AppColors.backgroundVariant1,
                  backgroundColor: Colors.red);
            }
          },
        )
      ],
    );
  }
}

class ColoredRow extends StatelessWidget {
  final Color color;
  final String title;
  final String content;
  const ColoredRow(
      {super.key,
      required this.color,
      required this.content,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          VerticalDivider(
            thickness: 3,
            width: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '$title:  ',
                style: AppTextStyle.subtitle2.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal)),
            TextSpan(
                text: content,
                style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w500)),
          ]))
        ],
      ),
    );
  }
}
