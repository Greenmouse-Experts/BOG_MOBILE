import 'dart:convert';

import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/app/data/model/get_subscription_model.dart';
import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';
import 'package:bog/app/global_widgets/overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../data/model/log_in_model.dart';
import '../../data/model/user_details_model.dart';
import '../../data/providers/api.dart';
import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/subscription_widget.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late Future<ApiResponse> getSubscriptions;
  var publicKey = Api.publicKey;
  final plugin = PaystackPlugin();

  void checkout(
      {required String planId,
      required String userType,
      required int price}) async {
    final controller = Get.find<HomeController>();
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    final userId = logInDetails.id ?? '';
    final newPrice = price * 100;

    Charge charge = Charge()
      ..amount = newPrice
      ..reference = 'TR-${DateTime.now().millisecondsSinceEpoch}'
      ..email = logInDetails.email ?? ''
      ..currency = "NGN";

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
      fullscreen: true,
    );

    if (response.status == true) {
      AppOverlay.loadingOverlay(asyncFunction: () async {
        final res =
            await controller.userRepo.postData('/subscription/subscribe', {
          "planId": planId,
          "reference": response.reference!,
          "userId": userId,
          "userType": userType
        });
        if (res.isSuccessful) {
          final userDetails =
              UserDetailsModel.fromJson(jsonDecode(MyPref.userDetails.val));
          userDetails.profile!.hasActiveSubscription = true;
          MyPref.userDetails.val = jsonEncode(userDetails);
          Get.back();
          Get.snackbar('Success', 'Subscription made successfully',
              backgroundColor: AppColors.successGreen,
              colorText: AppColors.background);
          MyPref.setSubscribeOverlay.val = false;
        } else {
          Get.snackbar('Error',
              res.message ?? 'An error occurred, please try again later',
              backgroundColor: Colors.red, colorText: AppColors.background);
        }
      });
    } else {
      Get.snackbar('Error', response.message,
          backgroundColor: Colors.red, colorText: AppColors.background);
    }
  }

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    final controller = Get.find<HomeController>();
    getSubscriptions = controller.userRepo.getData('/subscription/plans');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
      child: GetBuilder<HomeController>(
        builder: (controller) {
          final userType = controller.currentType == 'Product Partner'
              ? 'vendor'
              : 'professional';
          return Scaffold(
            appBar: newAppBarBack(context, 'Subscriptions'),
            body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: Get.width * 0.05),
                  child: FutureBuilder<ApiResponse>(
                      future: getSubscriptions,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data!.isSuccessful) {
                          final response = snapshot.data!.data as List<dynamic>;
                          final subscriptionsList = <GetSubscriptionModel>[];

                          for (var element in response) {
                            subscriptionsList
                                .add(GetSubscriptionModel.fromJson(element));
                          }

                          if (subscriptionsList.isEmpty) {
                            return const Center(
                              child:
                                  Text('No Subscriptions Available Currently'),
                            );
                          } else {
                            return ListView.builder(
                                itemCount: subscriptionsList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  final subscription = subscriptionsList[i];
                                  final List<String> benefits = [];
                                  if (subscription.benefits != null) {
                                    for (var element
                                        in subscription.benefits!) {
                                      benefits.add(element.benefit ?? '');
                                    }
                                  }

                                  return SubscriptionWidget(
                                    onPressed: () {
                                      final userDetails =
                                          UserDetailsModel.fromJson(jsonDecode(
                                              MyPref.userDetails.val));
                                      if (userDetails.profile!.isVerified !=
                                          true) {
                                        Get.snackbar('Error',
                                            '“Your KYC is not verified by Admin, please try Subscribing later',
                                            backgroundColor: Colors.red,
                                            colorText: AppColors.background);
                                      } else {
                                        checkout(
                                            planId: subscription.id ?? '',
                                            userType: userType,
                                            price: subscription.amount ?? 0);
                                      }
                                    },
                                    name: subscription.name ?? '',
                                    amount: subscription.amount ?? 0,
                                    duration: subscription.duration ?? 0,
                                    benefits: benefits,
                                  );
                                });
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const AppLoader();
                        } else {
                          return const Center(
                            child: Text('An error occurred'),
                          );
                        }
                      })

                  // Column(
                  //   children: [
                  //     SubscriptionWidget()
                  //   ],
                  // ),
                  ),
            ),
          );
        },
      ),
    );
  }
}
