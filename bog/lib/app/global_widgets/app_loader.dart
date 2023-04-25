import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.65,
      child: const Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: AppColors.primary,
          // color: AppColors.primary,
        ),
      ),
    );
  }
}
