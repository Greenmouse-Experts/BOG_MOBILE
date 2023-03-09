import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              right: Get.width * 0.05,
              left: Get.width * 0.045,
              top: kToolbarHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(
                  "assets/images/back.svg",
                  height: Get.width * 0.045,
                  width: Get.width * 0.045,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.subtitle1.copyWith(
                          fontSize: multiplier * 0.07,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
            ],
          ),
        ),
        SizedBox(height: Get.width * 0.04),
        Divider(
          thickness: 1,
          color: AppColors.grey.withOpacity(0.1),
        )
      ],
    );
  }
}
