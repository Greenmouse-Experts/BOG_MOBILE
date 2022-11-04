import 'dart:convert';

import 'package:bog/app/global_widgets/app_ratings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/providers/api_response.dart';
import '../../../data/providers/my_pref.dart';
import '../../../global_widgets/app_button.dart';
import '../../../global_widgets/horizontal_item_tile.dart';
import '../../../global_widgets/item_counter.dart';
import '../../../global_widgets/page_input.dart';

class CartTab extends StatelessWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "My Cart",
                    style: AppTextStyle.subtitle1.copyWith(
                      color: Colors.black,
                      fontSize: Get.width * 0.045,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            const CartItem(),
            SizedBox(
              height: Get.height * 0.01,
            ),
            const CartItem(),
            SizedBox(
              height: Get.height * 0.1,
            ),
            //Divider
            Container(
              height: 1,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const PageInput(
              hint: 'Enter your coupon code',
              label: 'Do you have a coupon ? Enter it here',
              validator: null,
              isCompulsory: true,
              obscureText: false,
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub Total:",
                  style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black,
                    fontSize: Get.width * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "N 115,000",
                  style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black,
                    fontSize: Get.width * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Fee :",
                  style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black,
                    fontSize: Get.width * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "N 5,000",
                  style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black,
                    fontSize: Get.width * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount :",
                  style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black,
                    fontSize: Get.width * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "50%",
                  style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black,
                    fontSize: Get.width * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            //Dotted Line
            CustomPaint(painter: DashedLinePainter()),
            SizedBox(
              height: Get.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total :",
                  style: AppTextStyle.subtitle1.copyWith(
                    color: Colors.black,
                    fontSize: Get.width * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "N 150,000",
                  style: AppTextStyle.subtitle1.copyWith(
                    color: AppColors.primary,
                    fontSize: Get.width * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            AppButton(
              title: 'Proceed To Checkout',
              onPressed: () {},
              borderRadius: 10,
            ),
          ],
        ),
      );
    });
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*CachedNetworkImageProvider(
      "www.com",
    )*/
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.bostonUniRed,
                image: const DecorationImage(
                  image: AssetImage("assets/images/dummy_image.png"),
                  fit: BoxFit.cover,
                ),
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
                    child: const Text("30 Tonnes Sharp Sand"),
                  ),
                  AppRating(onRatingUpdate: (value) {}, rating: 4.5),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      'N 115,000',
                      style: AppTextStyle.caption.copyWith(
                        color: Colors.black,
                        fontSize: Get.width * 0.035,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ItemCounter(
                  initialCount: 1,
                  onCountChanged: (count) {

                  },
                ),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}