import 'package:bog/app/global_widgets/app_input.dart';
import 'package:bog/app/global_widgets/app_radio_button.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/global_widgets/update_slider.dart';
import 'package:bog/app/modules/switch/switch.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scroll_indicator/scroll_indicator.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../data/providers/my_pref.dart';
import '../modules/subscription/subscription_view.dart';
import 'app_button.dart';
import 'confirm_logout.dart';

final options = ['Yes', 'No'];
final ScrollController scrollController = ScrollController();
class AppOverlay {
  static Future<void> loadingOverlay({
    required Future<dynamic> Function() asyncFunction,
  }) async =>
      await Get.showOverlay(
        asyncFunction: asyncFunction,
        loadingWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: LoadingAnimationWidget.inkDrop(
                color: AppColors.primary,
                size: 35,
              ),
            ),
          ],
        ),
      );

  static void successOverlay({required String message}) {
    showDialog(
        context: Get.context!,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: Material(
                  elevation: 10,
                  color: Colors.black.withOpacity(0.2),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width * 0.8,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Success',
                                textAlign: TextAlign.center,
                                style: Get.textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17 * Get.textScaleFactor * 0.90,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 11),
                              Center(
                                child: Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.bodyText2.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 22),
                              AppButton(
                                title: 'Okay',
                                onPressed: () {
                                  Get.back();
                                  Get.back();
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ));
  }

  static Future<void> newLoadingOverlay({
    required Future<dynamic> Function() asyncFunction,
  }) async =>
      await Get.showOverlay(
        asyncFunction: asyncFunction,
        loadingWidget: //const LoadingScreen(),

            Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 26, 26, 25),
                  borderRadius: BorderRadius.circular(10)),
              child: LoadingAnimationWidget.discreteCircle(
                color: AppColors.background,
                secondRingColor: AppColors.primary,
                size: 35,
              ),
            ),
          ],
        ),
      );

  static void showInfoDialog(
      {required String title,
      String? content,
      Widget? contentReplacement,
      bool? doubleFunction,
      Function()? onPressed,
      String? buttonText}) {
    showDialog(
      context: Get.context!,
      builder: (context) => Material(
        elevation: 10,
        color: Colors.black.withOpacity(0.2),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.8,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 17 * Get.textScaleFactor * 0.90,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 11),
                    Center(
                      child: contentReplacement ??
                          Text(
                            content ?? "",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bodyText2.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: doubleFunction != null && doubleFunction
                          ? Row(
                              children: [
                                Expanded(
                                  child: AppButton(
                                    title: 'No',
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: AppButton(
                                    bckgrndColor: Colors.red,
                                    title: buttonText ?? 'Yes',
                                    onPressed: onPressed ?? Get.back,
                                  ),
                                )
                              ],
                            )
                          : AppButton(
                              title: buttonText ?? "Okay",
                              borderRadius: 100,
                              onPressed: onPressed ?? Get.back),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  static void showAcceptFormDialog(
      {required String title,
      bool? doubleFunction,
      Function()? onPressed,
      String? buttonText}) {
    showDialog(
      context: Get.context!,
      builder: (context) => Material(
        elevation: 10,
        color: Colors.black.withOpacity(0.2),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.8,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: SizedBox(
                  height: Get.height * 0.6,
                  child: Scrollbar(
                    controller: scrollController,
                    trackVisibility: true,
                    thumbVisibility: true,

                    child: ListView(
                      controller: scrollController,
                      
                      children: [
                        Text(
                          'Project Interest Form',
                          
                          // textAlign: TextAlign.center,
                          style: Get.textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 17 * Get.textScaleFactor * 0.90,
                              color: Colors.black),
                        ),
                        SizedBox(height: Get.height * 0.01),
                         Text(
                          'With the details contained in the view form, fill and submit the document below to show interest.',
                          
                          // textAlign: TextAlign.center,
                          style: Get.textTheme.bodyText1!.copyWith(
                              
                              fontSize: 14 * Get.textScaleFactor,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 11),
                       AppRadioButton(options: options, label: '1. Are you interested in this project', option1: 'Yes', onchanged: (value){}),
                       PageInput(hint: '', label: '2. What is your best price for rendering your service on this project', keyboardType: TextInputType.number,textWidth: 0.6,),
                         PageInput(hint: '', label: '3. How soon can you deliver this project? (Give us answer in weeks)', keyboardType: TextInputType.number,textWidth: 0.6,),
                         AppRadioButton(options: options, label: '4. What is your interest on this project', option1: 'Quantity Surveyor', onchanged: (value){}),
                        // ScrollIndicator(scrollController: scrollController, ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          child: doubleFunction != null && doubleFunction
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: AppButton(
                                        title: 'No',
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: AppButton(
                                       // bckgrndColor: Colors.red,
                                        title: buttonText ?? 'Yes',
                                         bckgrndColor: Colors.green,
                                        onPressed: onPressed ?? Get.back,
                                      ),
                                    )
                                  ],
                                )
                              : AppButton(
                                  title: buttonText ?? "Okay",
                                  borderRadius: 100,
                                  bckgrndColor: Colors.green,
                                  onPressed: onPressed ?? Get.back),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    static void showAcceptDialog(
      {required String title,
      String? content,
      Widget? contentReplacement,
      bool? doubleFunction,
      Function()? onPressed,
      String? buttonText}) {
    showDialog(
      context: Get.context!,
      builder: (context) => Material(
        elevation: 10,
        color: Colors.black.withOpacity(0.2),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.8,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 17 * Get.textScaleFactor * 0.90,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 11),
                    Center(
                      child: contentReplacement ??
                          Text(
                            content ?? "",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bodyText2.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: doubleFunction != null && doubleFunction
                          ? Row(
                              children: [
                                Expanded(
                                  child: AppButton(
                                    title: 'No',
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: AppButton(
                                   // bckgrndColor: Colors.red,
                                    title: buttonText ?? 'Yes',
                                     bckgrndColor: Colors.green,
                                    onPressed: onPressed ?? Get.back,
                                  ),
                                )
                              ],
                            )
                          : AppButton(
                              title: buttonText ?? "Okay",
                              borderRadius: 100,
                              bckgrndColor: Colors.green,
                              onPressed: onPressed ?? Get.back),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showPercentageDialog(
      {required String title,
      required TextEditingController controller,
      required double value,
      String? content,
      Widget? contentReplacement,
      bool? doubleFunction,
      Function()? onPressed,
      String? buttonText}) {
    showDialog(
      context: Get.context!,
      builder: (context) => Material(
        elevation: 10,
        color: Colors.black.withOpacity(0.2),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width * 0.9,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyText2.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.black),
                    ),
                    const SizedBox(height: 11),
                    Center(
                      child: contentReplacement ??
                          Text(
                            content ?? "",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.bodyText2.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                    ),
                    const SizedBox(height: 11),
                    UpdateSlider(
                      controller: controller,
                      val: value,
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: doubleFunction != null && doubleFunction
                          ? Row(
                              children: [
                                Expanded(
                                  child: AppButton(
                                    title: 'No',
                                    bckgrndColor: Colors.red,
                                    onPressed: () {
                                      controller.clear();
                                      Get.back();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: AppButton(
                                    bckgrndColor: Colors.green,
                                    title: buttonText ?? 'Update',
                                    onPressed: onPressed ?? Get.back,
                                  ),
                                )
                              ],
                            )
                          : AppButton(
                              title: buttonText ?? "Okay",
                              borderRadius: 100,
                              onPressed: onPressed ?? Get.back),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showKycDialog(
      {required String title,
      String? content,
      Widget? contentReplacement,
      bool? doubleFunction,
      Function()? onPressed,
      String? buttonText}) {
    showDialog(
      context: Get.context!,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          
          final val = MyPref.setOverlay.val;
          if (val == false){
             MyPref.setSubscribeOverlay.val = true;
              AppOverlay.showSubscribeDialog(
            title: 'No Active Subscriptions',
            buttonText: 'Subscribe',
            content:
                "You don't have an active subscription, select a subscription to enjoy full benefits",
            onPressed: () => Get.to(() => const SubscriptionScreen()));
      
          }
          return !val;
        },
        child: Material(
          elevation: 10,
          color: Colors.black.withOpacity(0.2),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.8,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: Get.textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17 * Get.textScaleFactor * 0.90,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                          const ConfirmLogout());
                                },
                                icon: const Icon(
                                  Icons.logout_outlined,
                                  color: Colors.red,
                                )),
                          )
                        ],
                      ),
                      const SizedBox(height: 11),
                      Center(
                        child: contentReplacement ??
                            Text(
                              content ?? "",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: doubleFunction != null && doubleFunction
                            ? Row(
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      title: 'No',
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: AppButton(
                                      bckgrndColor: Colors.red,
                                      title: buttonText ?? 'Yes',
                                      onPressed: onPressed ?? Get.back,
                                    ),
                                  )
                                ],
                              )
                            : AppButton(
                                title: buttonText ?? "Okay",
                                /*   padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25), */
                                borderRadius: 100,
                                onPressed: onPressed ?? Get.back),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                            title: 'Or Switch Account',
                            borderRadius: 100,
                            bckgrndColor: const Color.fromRGBO(244, 67, 54, 1),
                            onPressed: () {
                              // Get.back();
                              Get.to(() => const SwitchUser());
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showSubscribeDialog(
      {required String title,
      String? content,
      Widget? contentReplacement,
      bool? doubleFunction,
      Function()? onPressed,
      String? buttonText}) {
    showDialog(
      context: Get.context!,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          final val = MyPref.setSubscribeOverlay.val;
          return !val;
        },
        child: Material(
          elevation: 10,
          color: Colors.black.withOpacity(0.2),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Get.width * 0.8,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: Get.textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17 * Get.textScaleFactor * 0.90,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                          const ConfirmLogout());
                                },
                                icon: const Icon(
                                  Icons.logout_outlined,
                                  color: Colors.red,
                                )),
                          )
                        ],
                      ),
                      const SizedBox(height: 11),
                      Center(
                        child: contentReplacement ??
                            Text(
                              content ?? "",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.bodyText2.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: doubleFunction != null && doubleFunction
                            ? Row(
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      title: 'No',
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: AppButton(
                                      bckgrndColor: Colors.red,
                                      title: buttonText ?? 'Yes',
                                      onPressed: onPressed ?? Get.back,
                                    ),
                                  )
                                ],
                              )
                            : AppButton(
                                title: buttonText ?? "Okay",
                                /*   padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25), */
                                borderRadius: 100,
                                onPressed: onPressed ?? Get.back),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                            title: 'Or Switch Account',
                            borderRadius: 100,
                            bckgrndColor: const Color.fromRGBO(244, 67, 54, 1),
                            onPressed: () {
                              // Get.back();
                              Get.to(() => const SwitchUser());
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


