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
import '../../../global_widgets/app_input.dart';
import '../../../global_widgets/horizontal_item_tile.dart';
import '../../../global_widgets/item_counter.dart';
import '../../../global_widgets/page_input.dart';
import '../../add_products/add_products.dart';
import '../../orders/order_details.dart';

class CartTab extends StatelessWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String search = "";
    return GetBuilder<HomeController>(builder: (controller) {
      return Expanded(
        child: Scaffold(
          body: SizedBox(
            height: Get.height * 0.91,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                Padding(
                  padding: EdgeInsets.only(left: Get.width*0.035, right: Get.width*0.03,top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        controller.cartTitle,
                        style: AppTextStyle.subtitle1.copyWith(
                          color: Colors.black,
                          fontSize: Get.width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                if(controller.currentType == "Client"  || controller.currentType == "Corporate Client")
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                      ),
                    ),
                  ),
                if(controller.currentType == "Product Partner")
                  Padding(
                    padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
                    child: AppInput(
                      hintText: 'Search with name or keyword ...',
                      filledColor: Colors.grey.withOpacity(.1),
                      prefexIcon: Icon(
                        FeatherIcons.search,
                        color: Colors.black.withOpacity(.5),
                        size: Get.width * 0.05,
                      ),
                      onChanged: (value) {
                        search = value;
                        controller.update();
                      },
                    ),
                  ),
                if(controller.currentType == "Product Partner")
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                if(controller.currentType == "Product Partner")
                  Expanded(
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return const ProductItem();
                      },
                    ),
                  )
              ],
            ),
          ),
          floatingActionButton: controller.currentType == "Client" || controller.currentType == "Corporate Client" ? null : FloatingActionButton(
            onPressed: (){
              Get.to(() => const AddProject());
            },
            backgroundColor: AppColors.primary,
            child: Stack(
              children: [
                SizedBox(
                  width: Get.width * 0.05,
                  height: Get.width * 0.05,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: Get.width * 0.05,
                  ),
                ),
              ],
            ),
          ),
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

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*CachedNetworkImageProvider(
      "www.com",
    )*/
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
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      'Monday, 31 October 2022 ',
                      style: AppTextStyle.caption.copyWith(
                        color: Color(0xFF9A9A9A),
                        fontSize: Get.width * 0.033,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      'Pending Shipping ',
                      style: AppTextStyle.caption.copyWith(
                        color: Color(0xFFEC8B20),
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
                    'N 115,000',
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

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*CachedNetworkImageProvider(
      "www.com",
    )*/
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
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      'Monday, 31 October 2022 ',
                      style: AppTextStyle.caption.copyWith(
                        color: Color(0xFF9A9A9A),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.015,top: 5),
                  child: Image.asset('assets/images/Group 47403.png',height: Get.width * 0.07,width: Get.width * 0.07,),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.015,bottom: 5),
                  child: SizedBox(
                    width: Get.width * 0.2,
                    child: AppButton(
                      title: "Pending",
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      border: Border.all(color: Color(0xFFECF6FC)),
                      bckgrndColor: Color(0xFFECF6FC),
                      fontColor: AppColors.primary,
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

class OrderRequestItem extends StatelessWidget {
  const OrderRequestItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*CachedNetworkImageProvider(
      "www.com",
    )*/
    return Container(
      margin: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03,bottom: 20,top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: (){
          Get.to(() => const OrderDetails());
        },
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.005),
                        child: Text(
                          "Order ID :  SAN - 123- NDS ",
                          style: AppTextStyle.caption.copyWith(
                            color: Colors.black,
                            fontSize: Get.width * 0.035,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.005),
                        child: Text(
                          '30 Tonnes of Sharp Sand  ',
                          style: AppTextStyle.caption.copyWith(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: Get.width * 0.033,
                            fontWeight: FontWeight.w500,
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
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.015),
                      child: Text(
                        'N 115,000',
                        style: AppTextStyle.caption.copyWith(
                          color: AppColors.primary,
                          fontSize: Get.width * 0.035,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.015),
                      child: Text(
                        'x2',
                        style: AppTextStyle.caption.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: Get.width * 0.033,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * 0.4,
                  child: AppButton(
                    title: "Decline",
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    border: Border.all(color: Color(0xFF24B53D)),
                    bckgrndColor: Colors.white,
                    fontColor: Color(0xFF24B53D),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.4,
                  child: AppButton(
                    title: "Accept",
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    border: Border.all(color: Color(0xFF24B53D)),
                    bckgrndColor: Colors.white,
                    fontColor: const Color(0xFF24B53D),
                  ),
                ),
              ],
            )
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