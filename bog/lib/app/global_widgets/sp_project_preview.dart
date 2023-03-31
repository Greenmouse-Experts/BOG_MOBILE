import 'package:bog/app/controllers/home_controller.dart';
import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SPProjectPreview extends StatelessWidget {
  final String title;
  final String image;
  final int amount;
  final Color color;

  const SPProjectPreview(
      {super.key,
      required this.title,
      required this.image,
      required this.color,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return InkWell(
      onTap: () {
        controller.currentBottomNavPage.value = 2;
        controller.updateNewUser(controller.currentType);
        controller.update(['home']);
      },
      child: Container(
        width: Get.width * 0.42,
        height: Get.width * 0.36,
        decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(width: 1, color: color)),
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.21,
                    child: Text(
                      title,
                      style: AppTextStyle.subtitle1.copyWith(
                          color: color.withOpacity(0.6),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Spacer(),
                  Image.asset(image)
                ],
              ),
              Text(
                '$amount',
                style: AppTextStyle.headline6
                    .copyWith(color: AppColors.blackShade),
              )
            ],
          ),
        ),
      ),
    );
  }
}
