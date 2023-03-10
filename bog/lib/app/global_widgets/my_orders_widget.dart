import 'package:bog/app/global_widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';

class MyOrdersWidget extends StatelessWidget {
  final String image;
  final String price;
  final DateTime date;
  final String status;
  final Color statusColor;
  final String orderItemName;
  const MyOrdersWidget(
      {super.key,
      required this.price,
      required this.date,
      required this.status,
      required this.statusColor,
      required this.orderItemName,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                    imageUrl: image,
                    // 'https://media.premiumtimesng.com/wp-content/files/2021/07/1625980458926blob.png',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const AppLoader(),
                    errorWidget: (context, url, error) => Image.asset(
                          'bog/assets/images/launch.png',
                          fit: BoxFit.cover,
                        )),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(orderItemName),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      date.format(AmericanDateFormats.dayOfWeek),
                      style: AppTextStyle.caption.copyWith(
                        color: const Color(0xFF9A9A9A),
                        fontSize: Get.width * 0.033,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      date.format(DateTimeFormats.american),
                      style: AppTextStyle.caption.copyWith(
                        color: const Color(0xFF9A9A9A),
                        fontSize: Get.width * 0.033,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      status.capitalize!,
                      style: AppTextStyle.caption.copyWith(
                        color: statusColor,
                        fontSize: Get.width * 0.033,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.015),
                  child: Text(
                    price,
                    style: AppTextStyle.caption.copyWith(
                      color: AppColors.primary,
                      fontSize: Get.width * 0.035,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
