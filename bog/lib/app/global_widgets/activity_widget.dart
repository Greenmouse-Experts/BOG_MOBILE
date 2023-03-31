import 'package:bog/core/theme/app_colors.dart';
import 'package:bog/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final Color color;
  final bool isProduct;
  final int total;
  final VoidCallback onTap;

  const ActivityWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.color,
      required this.isProduct,
      required this.total,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: Get.width * 0.425,
        child: Card(
          color: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: Get.width * 0.04,
                      backgroundColor: AppColors.white,
                      child: Image.asset(image),
                    ),
                    SizedBox(width: Get.width * 0.005),
                    SizedBox(
                        width: Get.width * 0.24,
                        child: Text(
                          title,
                          style: AppTextStyle.subtitle2
                              .copyWith(color: AppColors.white),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          total.toString(),
                          style: AppTextStyle.headline6
                              .copyWith(color: AppColors.blackShade),
                        ),
                        isProduct
                            ? IconButton(
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: AppColors.servicePurple,
                                  size: Get.width * 0.065,
                                ))
                            : const IconButton(
                                onPressed: null, icon: SizedBox.shrink())
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      subTitle,
                      style: AppTextStyle.caption
                          .copyWith(color: AppColors.blackShade),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
