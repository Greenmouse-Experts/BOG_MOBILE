import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../controllers/home_controller.dart';
import '../modules/sign_in/sign_in.dart';

class ConfirmLogout extends StatelessWidget {
  const ConfirmLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundVariant1,
      title: Text(
        'Log out',
        style: AppTextStyle.headline6.copyWith(color: Colors.red),
      ),
      content: Text(
        'Are you sure you want to Log out?',
        style: AppTextStyle.bodyText1.copyWith(color: AppColors.grey),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'No',
              style: AppTextStyle.headline4.copyWith(color: Colors.red),
            )),
        TextButton(
            onPressed: () async {
              final controller = Get.find<HomeController>();
              controller.signOut();
              Get.offAll(() => const SignIn());
            },
            child: Text(
              'Yes',
              style: AppTextStyle.headline4.copyWith(color: AppColors.blue),
            ))
      ],
    );
  }
}
