import 'dart:convert';

import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/modules/project_details/new_project_details.dart';
import 'package:bog/app/modules/project_details/view_form.dart';
import 'package:bog/core/theme/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../data/model/log_in_model.dart';
import '../data/providers/api.dart';
import '../data/providers/my_pref.dart';

class MyProjectWidget extends StatefulWidget {
  final String projectType;
  final String orderSlug;
  final HomeController controller;
  final String id;
  final bool inReview;
  final bool isPending;
  final bool isOngoing;
  final bool isCancelled;
  const MyProjectWidget(
      {super.key,
      required this.projectType,
      required this.orderSlug,
      required this.controller,
      required this.id,
      required this.isPending,
      required this.isOngoing,
      required this.isCancelled,
      required this.inReview});

  @override
  State<MyProjectWidget> createState() => _MyProjectWidgetState();
}

class _MyProjectWidgetState extends State<MyProjectWidget> {
  var publicKey = Api.publicKey;
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);

    super.initState();
  }

  void checkOut(String id) async {
    print(id);
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    const price = 20000 * 100;
    final email = logInDetails.email;
    Charge charge = Charge()
      ..amount = price
      ..reference = 'ref_${DateTime.now().millisecondsSinceEpoch}'
      ..email = email
      ..currency = "NGN";

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
      fullscreen: true,
    );

    if (response.status == true) {
      AppOverlay.loadingOverlay(asyncFunction: () async {
        final controller = Get.find<HomeController>();
        final response = await controller.userRepo
            .patchData('/projects/request-for-approval/$id', {"amount": 20000});
        if (response.isSuccessful) {
          Get.snackbar('Success', 'Review sent', backgroundColor: Colors.red);
        } else {
          Get.snackbar('Error', response.message ?? 'An error occurred');
        }
      });

      // Get.snackbar('Sucess', 'Payment was successful',
      //     backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'An error occcurred', backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minLeadingWidth: 4,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.inReview)
                const CircleAvatar(
                  radius: 3,
                  backgroundColor: AppColors.primary,
                ),
              if (widget.isPending)
                const CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.black,
                ),
              if (widget.isOngoing)
                const CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.green,
                ),
              if (widget.isCancelled)
                const CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.red,
                ),
            ],
          ),
          title: Text(
            widget.projectType.toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            widget.orderSlug,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          trailing: PopupMenuButton(
              color: Colors.white,
              itemBuilder: (context) {
                return [
                  if (!widget.inReview)
                    PopupMenuItem<int>(
                      value: 1,
                      child: TextButton(
                          onPressed: () {
                            Get.to(() => NewProjectDetailPage(
                                  id: widget.id,
                                ));
                          },
                          child: const Text(
                            'View Details',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )),
                    ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                          Get.to(() => ViewFormPage(id: widget.id));
                        },
                        child: const Text(
                          'View Form',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )),
                  ),
                  if (!widget.isOngoing)
                    PopupMenuItem<int>(
                      value: 3,
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                            AppOverlay.showInfoDialog(
                              title: 'Commence Project',
                              content:
                                  'To proceed, a commitment fee of NGN 20,000 must be paid. This will be deducted from total cost of this project if approved.You will be refunded if this project is declined by the service partner',
                              doubleFunction: true,
                              onPressed: () {
                                checkOut(widget.id);
                              },
                            );
                          },
                          child: const Text(
                            'Commence Project',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )),
                    ),
                  PopupMenuItem<int>(
                    value: 4,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                          final response = await widget.controller.userRepo
                              .deleteData('/projects/delete/${widget.id}');
                          if (response.isSuccessful) {
                            Get.back();
                            Get.snackbar(
                                'Sucessful', 'Project Deleted Successfully',
                                backgroundColor: Colors.green);
                          } else {
                            Get.back();
                            Get.snackbar('Error', 'An error occurred');
                          }
                        },
                        child: const Text(
                          'Delete Project',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )),
                  ),
                ];
              },
              onSelected: (value) {},
              child: const Icon(
                Icons.more_vert,
                color: Colors.black,
              )),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.3),
        )
      ],
    );
  }
}
