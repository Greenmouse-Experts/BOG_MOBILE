import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../controllers/home_controller.dart';
import '../data/providers/my_pref.dart';
import '../modules/meetings/meeting.dart';
import '../modules/subscription/subscription_view.dart';

import '../modules/switch/switch.dart';
import 'app_date_picker.dart';
import 'app_radio_button.dart';
import 'confirm_logout.dart';
import 'global_widgets.dart';
import 'page_dropdown.dart';
import 'update_slider.dart';

final options = ['Yes', 'No'];
final interestOptions = [
  'Quantity Surveyor',
  'Architect',
  'Structural Engineer',
  'Electrical Engineer',
  'Mechanical Engineer',
  'Contractor'
];
String chosenInterest = '';
String reasonOfInterest = '';

String selectedMeeting = '';
String selectedDate = '';
String selectedTime = '';
TextEditingController description = TextEditingController();

final _reviewKey = GlobalKey<FormState>();
final _interestKey = GlobalKey<FormState>();
int orderRating = 0;

TextEditingController bestPriceController = TextEditingController();
TextEditingController timeLineController = TextEditingController();
final ScrollController scrollController = ScrollController();

TextEditingController updateMessageController = TextEditingController();
TextEditingController fileController = TextEditingController();
TextEditingController productReviewController = TextEditingController();
File? pickedFile;

var dioSend = dio.Dio();

getCloseButton({VoidCallback? onpressed}) {
  return Container(
    alignment: Alignment.topRight,
    child: GestureDetector(
        onTap: onpressed ?? Get.back,
        child: const Icon(
          Icons.clear,
          color: Colors.red,
        )),
  );
}

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

  static void successOverlay({required String message, Function()? onPressed}) {
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
                                style: Get.textTheme.bodyLarge!.copyWith(
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
                                  if (onPressed == null) {
                                    Get.back();
                                    Get.back();
                                  } else {
                                    onPressed();
                                  }
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

  static void showProductReviewDialog(
      {required String productId, required String userId, required VoidCallback reload}) {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return WillPopScope(
              child: Material(
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
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: Form(
                              key: _reviewKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getCloseButton(onpressed: () {
                                    orderRating = 0;
                                    productReviewController.clear();
                                    Get.back();
                                  }),
                                  SizedBox(
                                    width: Get.width,
                                    child: Text(
                                      'Your Review',
                                      style: Get.textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              17 * Get.textScaleFactor * 0.90,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  PageInput(
                                    validator: MinLengthValidator(1,
                                        errorText: 'Enter a valid review'),
                                    hint: '',
                                    label: 'Enter Review',
                                    keyboardType: TextInputType.multiline,
                                    textWidth: 0.6,
                                    controller: productReviewController,
                                    isTextArea: true,
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Text('Leave a rating',
                                      style: AppTextStyle.bodyText2
                                          .copyWith(color: Colors.black)),
                                  RatingBar.builder(
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      orderRating = rating.toInt();
                                    },
                                  ),
                                  const SizedBox(height: 22),
                                  SizedBox(
                                    width: double.infinity,
                                    child: AppButton(
                                        title: "Submit",
                                        borderRadius: 12,
                                        // bckgrndColor: Colors.green,
                                        onPressed: () async {
                                          if (orderRating == 0) {
                                            Get.snackbar('Error',
                                                'You must leave a rating',
                                                backgroundColor: Colors.red,
                                                colorText:
                                                    AppColors.background);
                                            return;
                                          }

                                          if (_reviewKey.currentState!
                                              .validate()) {
                                            final controller =
                                                Get.find<HomeController>();
                                            final response = await controller
                                                .userRepo
                                                .postData(
                                                    '/review/product/create-product-review',
                                                    {
                                                  "productId": productId,
                                                  "review":
                                                      productReviewController
                                                          .text,
                                                  "star": orderRating,
                                                  "userId": userId,
                                                });
                                            if (response.isSuccessful) {
                                              orderRating = 0;
                                              productReviewController.clear();
                                              Get.back();
                                              Get.snackbar(
                                                  'Success',
                                                  response.message ??
                                                      'Product reviewed successfully',
                                                  backgroundColor: Colors.green,
                                                  colorText:
                                                      AppColors.background);
                                              reload();
                                            } else {
                                              orderRating = 0;
                                              productReviewController.clear();
                                              Get.back();
                                              Get.snackbar(
                                                  'Error',
                                                  response.message ??
                                                      'An error occurred',
                                                  backgroundColor: Colors.red,
                                                  colorText:
                                                      AppColors.background);
                                            }
                                          }
                                        }),
                                  ),
                                  const SizedBox(height: 22),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onWillPop: () async {
                orderRating = 0;
                productReviewController.clear();
                return true;
              });
        });
  }

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
                    getCloseButton(),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyLarge!.copyWith(
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

  static void showMeetingDialog(
      {required String meetingLink,
      required String meetingPassword,
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
                    getCloseButton(),
                    Text(
                      'Meeting Details',
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 17 * Get.textScaleFactor * 0.90,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 11),
                    PageInput(
                      textWidth: 0.6,
                      hint: '',
                      label: 'Meeting Link',
                      initialValue: meetingLink,
                      readOnly: true,
                    ),
                    PageInput(
                      textWidth: 0.6,
                      hint: '',
                      label: 'Meeting Password',
                      initialValue: meetingPassword,
                      readOnly: true,
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                          title: 'Close',
                          bckgrndColor: Colors.red,
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
      required String userId,
      Function()? onPressed,
      required String projectId,
      String? buttonText}) {
    showDialog(
      context: Get.context!,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          chosenInterest = '';
          reasonOfInterest = '';
          bestPriceController.clear();
          timeLineController.clear();
          return true;
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
                  child: SizedBox(
                    height: Get.height * 0.75,
                    child: Scrollbar(
                      controller: scrollController,
                      trackVisibility: true,
                      thumbVisibility: true,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Form(
                          key: _interestKey,
                          child: ListView(
                            controller: scrollController,
                            children: [
                              getCloseButton(onpressed: () {
                                chosenInterest = '';
                                reasonOfInterest = '';
                                bestPriceController.clear();
                                timeLineController.clear();
                                Get.back();
                              }),
                              SizedBox(
                                child: Text(
                                  'Project Interest Form',
                                  style: Get.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17 * Get.textScaleFactor * 0.90,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Text(
                                'With the details contained in the form below, fill and submit the document to show interest.',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.bodyText2.copyWith(
                                    fontSize: 14 * Get.textScaleFactor,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 11),
                              NewAppRadioButton(
                                  options: options,
                                  label:
                                      '1. Are you interested in this project',
                                  option1: '',
                                  onchanged: (value) {
                                    chosenInterest = value;
                                  }),
                              SizedBox(height: Get.height * 0.01),
                              PageInput(
                                validator: MinLengthValidator(4,
                                    errorText: 'Enter a valid price'),
                                hint: '',
                                label:
                                    '2. What is your best price for rendering your service on this project',
                                keyboardType: TextInputType.number,
                                textWidth: 0.6,
                                controller: bestPriceController,
                              ),
                              SizedBox(height: Get.height * 0.01),
                              PageInput(
                                validator: MinLengthValidator(1,
                                    errorText: 'Enter a valid timeline'),
                                hint: '',
                                label:
                                    '3. How soon can you deliver this project? (Give us answer in weeks)',
                                keyboardType: TextInputType.number,
                                textWidth: 0.6,
                                controller: timeLineController,
                              ),
                              SizedBox(height: Get.height * 0.01),
                              NewAppRadioButton(
                                  options: interestOptions,
                                  label:
                                      '4. What is your interest on this project',
                                  option1: '',
                                  onchanged: (value) {
                                    reasonOfInterest = value;
                                  }),
                              const SizedBox(height: 22),
                              SizedBox(
                                width: double.infinity,
                                child: AppButton(
                                    title: buttonText ?? "Okay",
                                    borderRadius: 12,
                                    // bckgrndColor: Colors.green,
                                    onPressed: () async {
                                      if (chosenInterest == '' ||
                                          chosenInterest == 'No') {
                                        Get.snackbar('Error',
                                            'You must be interested in this project to request',
                                            backgroundColor: Colors.red,
                                            colorText: AppColors.background);
                                        return;
                                      }
                                      if (reasonOfInterest == '') {
                                        Get.snackbar('Error',
                                            'You must select a reason of interest',
                                            backgroundColor: Colors.red,
                                            colorText: AppColors.background);
                                        return;
                                      }
                                      if (_interestKey.currentState!
                                          .validate()) {
                                        final controller =
                                            Get.find<HomeController>();
                                        final response = await controller
                                            .userRepo
                                            .postData('/projects/bid-project', {
                                          'areYouInterested': true,
                                          'deliveryTimeLine': int.parse(
                                              timeLineController.text),
                                          'projectCost': int.parse(
                                              bestPriceController.text),
                                          'projectId': projectId,
                                          'reasonOfInterest': reasonOfInterest,
                                          'userId': userId
                                        });
                                        if (response.isSuccessful) {
                                          chosenInterest = '';
                                          reasonOfInterest = '';
                                          bestPriceController.clear();
                                          timeLineController.clear();
                                          Get.back();
                                          Get.snackbar(
                                              'Success',
                                              response.message ??
                                                  'Project bid successful',
                                              backgroundColor: Colors.green,
                                              colorText: AppColors.background);
                                        } else {
                                          chosenInterest = '';
                                          reasonOfInterest = '';
                                          bestPriceController.clear();
                                          timeLineController.clear();
                                          Get.back();
                                          Get.snackbar(
                                              'Error',
                                              response.message ??
                                                  'An error occurred',
                                              backgroundColor: Colors.red,
                                              colorText: AppColors.background);
                                        }
                                      }
                                    }),
                              ),
                              const SizedBox(height: 22),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showRequestMeetingDialog(
      {bool? doubleFunction,
      required List<String> projectSlugs,
      required String email,
      required String userType,
      required String userId,
      Function()? onPressed,
      String? buttonText,
      required bool isSP}) {
    showDialog(
      context: Get.context!,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          selectedDate = '';
          selectedMeeting = '';
          selectedTime = '';
          description.clear();
          return true;
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
                  child: SizedBox(
                    height: Get.height * 0.575,
                    child: Scrollbar(
                      controller: scrollController,
                      trackVisibility: true,
                      thumbVisibility: true,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ListView(
                          controller: scrollController,
                          children: [
                            getCloseButton(onpressed: () {
                              selectedDate = '';
                              selectedMeeting = '';
                              selectedTime = '';
                              description.clear();
                              Get.back();
                            }),
                            Text(
                              'Request Meeting',
                              textAlign: TextAlign.center,
                              style: Get.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17 * Get.textScaleFactor * 0.90,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 11),
                            PageDropButton(
                              label: '',
                              hint: 'Project Id',
                              value: projectSlugs.first,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              onChanged: (val) {
                                selectedMeeting = val;
                              },
                              items: projectSlugs.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: Get.height * 0.01),
                            AppDatePicker(
                                label: 'Select Date',
                                onChanged: (onChanged) {
                                  selectedDate = onChanged;
                                }),
                            SizedBox(height: Get.height * 0.01),
                            AppTimePicker(
                                label: 'Select Time',
                                onChanged: (onChanged) {
                                  selectedTime = onChanged;
                                }),
                            SizedBox(height: Get.height * 0.01),
                            PageInput(
                              hint: '',
                              label: 'Description',
                              textWidth: 0.6,
                              controller: description,
                              isTextArea: true,
                            ),
                            const SizedBox(height: 22),
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                  title: buttonText ?? "Okay",
                                  borderRadius: 12,
                                  onPressed: () async {
                                    if (selectedDate == '' ||
                                        selectedMeeting == '' ||
                                        selectedTime == '' ||
                                        description.text.isEmpty) {
                                      Get.snackbar('Fill all fields',
                                          'All fields are required to submit this form',
                                          colorText: AppColors.background,
                                          backgroundColor: Colors.red);
                                      return;
                                    }
                                    final meetingRequest = {
                                      'date': selectedDate,
                                      'description': description.text,
                                      'projectSlug': selectedMeeting,
                                      'requestEmail': email,
                                      'requestId': userId,
                                      'time': selectedTime,
                                      'userType': userType
                                    };

                                    final controller =
                                        Get.find<HomeController>();
                                    final response = await controller.userRepo
                                        .postData(
                                            '/meeting/create', meetingRequest);
                                    if (response.isSuccessful) {
                                      selectedDate = '';
                                      selectedMeeting = '';
                                      selectedTime = '';
                                      description.clear();
                                      Get.back();
                                      AppOverlay.successOverlay(
                                          message:
                                              'Meeting Requested Successfully',
                                          onPressed: () {
                                            if (isSP) {
                                              Get.back();
                                              controller.currentBottomNavPage
                                                  .value = 0;
                                              controller.updateNewUser(
                                                  controller.currentType);
                                              controller.update(['home']);
                                            } else {
                                              Get.back();
                                              Get.back();
                                              Get.to(() => const NewMeetings());
                                            }
                                          });
                                    } else {
                                      selectedDate = '';
                                      selectedMeeting = '';
                                      selectedTime = '';
                                      description.clear();
                                      Get.back();
                                      Get.snackbar(
                                          'Error',
                                          response.message ??
                                              'An error occurred',
                                          backgroundColor: Colors.red,
                                          colorText: AppColors.background);
                                    }
                                  }),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showUpdateProjectProgressDialod({
    required String projectSlug,
    bool? doubleFunction,
    String? buttonText,
  }) {
    showDialog(
      context: Get.context!,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          updateMessageController.clear();
          fileController.clear();
          pickedFile = null;
          return true;
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
                      getCloseButton(onpressed: () {
                        updateMessageController.clear();
                        fileController.clear();
                        pickedFile = null;
                        Get.back();
                      }),
                      Text(
                        'Project Progress Update',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 17 * Get.textScaleFactor * 0.90,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 11),
                      SizedBox(
                        height: Get.height * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PageInput(
                                hint: '',
                                label: 'Update Message',
                                textWidth: 0.6,
                                controller: updateMessageController,
                                isTextArea: true,
                              ),
                              PageInput(
                                hint: '',
                                label: 'Add Image',
                                textWidth: 0.6,
                                controller: fileController,
                                isFilePicker: true,
                                onFilePicked: (file) {
                                  pickedFile = file;
                                },
                              ),
                              const SizedBox(height: 22),
                              SizedBox(
                                width: double.infinity,
                                child: AppButton(
                                    title: buttonText ?? "Okay",
                                    borderRadius: 12,
                                    onPressed: () async {
                                      if (pickedFile == null ||
                                          updateMessageController
                                              .text.isEmpty) {
                                        Get.snackbar('Required',
                                            'All fields are required',
                                            backgroundColor: Colors.red,
                                            colorText:
                                                AppColors.backgroundVariant2);
                                        return;
                                      }
                                      var body = {
                                        "image": [
                                          await dio.MultipartFile.fromFile(
                                            pickedFile!.path,
                                            filename: pickedFile!.path
                                                .split('/')
                                                .last,
                                          )
                                        ],
                                      };

                                      final formData =
                                          dio.FormData.fromMap(body);
                                      final imageRes = await dioSend.post(
                                          'https://bog.greenmouseproperties.com/upload',
                                          data: formData);
                                      if (imageRes.statusCode == 200) {
                                        final controller =
                                            Get.find<HomeController>();
                                        final response =
                                            await controller.userRepo.postData(
                                                '/projects/notification/create',
                                                {
                                              "body":
                                                  updateMessageController.text,
                                              "image": imageRes.data[0],
                                              "project_slug": projectSlug
                                            });
                                        if (response.isSuccessful) {
                                          Get.back();
                                          AppOverlay.successOverlay(
                                              message:
                                                  'Project Updated successfully',
                                              onPressed: () {
                                                Get.back();
                                              });
                                        } else {
                                          Get.snackbar(
                                              'Error',
                                              response.message ??
                                                  'An error occurred, please try again later',
                                              backgroundColor: Colors.red,
                                              colorText:
                                                  AppColors.backgroundVariant1);
                                        }
                                      } else {
                                        Get.snackbar('Error',
                                            'An error occurred, please try again later',
                                            backgroundColor: Colors.red,
                                            colorText:
                                                AppColors.backgroundVariant1);
                                      }
                                    }),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
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
                    getCloseButton(),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyLarge!.copyWith(
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
                    getCloseButton(),
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
          if (val == false) {
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
                      getCloseButton(onpressed: () {
                        if (MyPref.setOverlay.val) {
                          Get.snackbar('Error', 'Kindly complete kyc',
                              colorText: AppColors.backgroundVariant1,
                              backgroundColor: Colors.red);
                        } else {
                          Get.back();
                          MyPref.setSubscribeOverlay.val = true;
                          AppOverlay.showSubscribeDialog(
                              title: 'No Active Subscriptions',
                              buttonText: 'Subscribe',
                              content:
                                  "You don't have an active subscription, select a subscription to enjoy full benefits",
                              onPressed: () =>
                                  Get.to(() => const SubscriptionScreen()));
                        }
                      }),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: Get.textTheme.bodyLarge!.copyWith(
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
                                style: Get.textTheme.bodyLarge!.copyWith(
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
