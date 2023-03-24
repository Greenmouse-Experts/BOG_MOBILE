import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

PreferredSizeWidget newAppBar(
    BuildContext context, String title, bool cangoBack) {
  final Size size = MediaQuery.of(context).size;
  double multiplier = 25 * size.height * 0.01;
  return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          color: AppColors.grey.withOpacity(0.3),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyle.subtitle1.copyWith(
            fontSize: multiplier * 0.07,
            color: Colors.black,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      leading: SizedBox()

      // cangoBack
      //     // ? IconButton(
      //     //     onPressed: () {
      //     //       Get.back();
      //     //     },
      //     //     icon: cangoBack
      //     //         ? const Icon(Icons.arrow_back_ios_new_outlined)
      //     //         : const SizedBox.shrink())
      //     : null,
      );
}
