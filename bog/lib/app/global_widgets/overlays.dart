import 'package:bog/app/modules/switch/switch.dart';
import 'package:bog/core/loading_widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import 'app_button.dart';

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
                  color: const Color.fromARGB(255, 26, 26, 25),
                  borderRadius: BorderRadius.circular(10)),
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.bostonUniRed,
                size: 35,
              ),
            ),
          ],
        ),
      );

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
                              /*   padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25), */
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
                        child: AppButton(
                            title: 'Switch Account',
                            borderRadius: 100,
                            bckgrndColor: Color.fromRGBO(244, 67, 54, 1),
                            onPressed: () {
                              // Get.back();
                              Get.to(() => const SwitchUser());
                            }),
                      ),
                      const SizedBox(height: 10),
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
