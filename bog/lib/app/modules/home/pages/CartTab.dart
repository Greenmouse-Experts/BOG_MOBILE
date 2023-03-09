import 'dart:convert';

import 'package:bog/app/base/base.dart';
import 'package:bog/app/blocs/user_controller.dart';
import 'package:bog/app/global_widgets/app_ratings.dart';
import 'package:bog/app/modules/home/subscribe.dart';
import 'package:bog/core/utils/dialog_utils.dart';
import 'package:bog/core/widgets/bottom_nav.dart';
import 'package:bog/core/widgets/dialogs/messageDialog.dart';
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
import '../../../data/model/MyProducts.dart';
import '../../../data/providers/api_response.dart';
import '../../../data/providers/my_pref.dart';
import '../../../global_widgets/app_button.dart';
import '../../../global_widgets/app_input.dart';
import '../../../global_widgets/horizontal_item_tile.dart';
import '../../../global_widgets/item_counter.dart';
import '../../../global_widgets/page_dropdown.dart';
import '../../../global_widgets/page_input.dart';
import '../../add_products/add_products.dart';
import '../../checkout/checkout.dart';
import '../../orders/order_details.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {

  bool showSub = false;
  var subs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkSub();
    });
    subs.add(UserController.instance.stream.listen((event) {
      checkSub();
    }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for(var sub in subs) {
      sub?.cancel();
    }
  }

  void checkSub(){
    HomeController controller= Get.find();
    if(controller.currentType == "Service Partner"){
      bool subscribed = UserController.instance.currentUserProfile["hasActiveSubscription"]??false;
      // print(UserController.instance.currentUserProfile);
      // print(subscribed);
      if(!subscribed){
        showSub = true;
        if(mounted)setState(() {});
      }else{
        showSub = false;
        if(mounted)setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String search = "";
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              // height: Get.height * 0.91,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: kToolbarHeight,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.width * 0.035,
                          right: Get.width * 0.03,
                          top: 10),
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
                    addSpace(15),
                    if (controller.currentType == "Client" ||
                        controller.currentType == "Corporate Client")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.03, right: Get.width * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: Get.height * 0.3,
                              child: controller.productsList.isEmpty
                                  ? Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: Get.width * 0.03),
                                            child: Icon(
                                              FeatherIcons.shoppingCart,
                                              size: Get.width * 0.2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          Text(
                                            "Nothing in your cart",
                                            style: AppTextStyle.subtitle1.copyWith(
                                              color: Colors.black,
                                              fontSize: Get.width * 0.035,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: controller.productsList.length,
                                      shrinkWrap: false,
                                      itemBuilder: (context, index) {
                                        var product =
                                            controller.productsList[index];
                                        return CartItem(
                                          title: product.name.toString(),
                                          image: product.image.toString(),
                                          price: "N ${product.price}",
                                          quantity: controller.productsMap[
                                                  product.id.toString()] ??
                                              1,
                                          quantityChanged: (value) {
                                            controller.productsMap[
                                                product.id.toString()] = value;
                                            controller.update();
                                          },
                                        );
                                      }),
                            ),
                            SizedBox(
                              height: Get.height * 0.025,
                            ),
                            //Divider
                            Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            SizedBox(
                              height: Get.height * 0.025,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            SizedBox(
                              height: Get.height * 0.4,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          "N ${controller.totalPrice}",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          "0%",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          "N ${controller.totalPrice + 5000}",
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
                                      onPressed: () {
                                        Get.to(() => Checkout());
                                      },
                                      borderRadius: 10,
                                      enabled: controller.productsList.isNotEmpty,
                                    ),
                                    addSpace(20)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (controller.currentType == "Product Partner")
                      Padding(
                        padding: EdgeInsets.only(
                            left: Get.width * 0.03, right: Get.width * 0.03),
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
                    if (controller.currentType == "Product Partner")
                      SizedBox(
                        height: Get.height * 0.015,
                      ),
                    if (controller.currentType == "Product Partner")
                      FutureBuilder<ApiResponse>(
                          future: controller.userRepo.getData("/products"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done &&
                                snapshot.data!.isSuccessful) {
                              final posts =
                                  MyProducts.fromJsonList(snapshot.data!.data);
                              if (posts.isEmpty) {
                                return SizedBox(
                                  height: Get.height * 0.7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "No Products Available",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.07,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return ListView.builder(
                                itemCount: posts.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0),
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductItem(
                                    title: posts[index].name,
                                    subTitle: "N ${posts[index].price}",
                                    date: posts[index].createdAt,
                                    image: posts[index].image,
                                  );
                                },
                              );
                            } else {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return SizedBox(
                                  height: Get.height * 0.7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "No Products Found",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            fontSize: multiplier * 0.07,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return SizedBox(
                                height: Get.height * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              );
                            }
                          }),
                    if (controller.currentType == "Service Partner")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.03, right: Get.width * 0.03),
                            child: PageDropButtonWithoutBackground(
                              label: "",
                              hint: '',
                              padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                              onChanged: (val) {
                                //currentOrder = val;
                                controller.update();
                              },
                              value: "All Service Orders",
                              items: ["All Service Orders"]
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: AppTextStyle.subtitle1.copyWith(
                                      color: AppColors.primary,
                                      fontSize: Get.width * 0.035,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (BuildContext context, int index) {
                              return ServiceRequestItem();
                            },
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),

            if(showSub)messageDialog(Icons.subscriptions, blue0, "No active subscription", "To view your orders, you must choose a subscription plan",
                "Subscribe",cancellable: false,
            onclick: (_){
              launchScreen(context, Subscribe(),result: (_){
                checkSub();
              });
            },)
          ],
        ),
        floatingActionButton: controller.currentType == "Client" ||
                controller.currentType == "Corporate Client" ||
                controller.currentType == "Service Partner"
            ? null
            : FloatingActionButton(
                onPressed: () {
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
      );
    },);
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    this.status = "Pending Shipping",
    this.statusColor,
  }) : super(key: key);

  final String status;
  final Color? statusColor;
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
                      status,
                      style: AppTextStyle.caption.copyWith(
                        color: statusColor ?? const Color(0xFFEC8B20),
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
    this.title,
    this.subTitle,
    this.date,
    this.image,
  }) : super(key: key);

  final String? title;
  final String? subTitle;
  final String? date;
  final String? image;
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
            SizedBox(
              height: 90,
              width: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image.toString(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.grey.withOpacity(0.1), width: 1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.background,
                          size: Get.width * 0.1,
                        ),
                      ),
                    );
                  },
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
                    child: Text(title ?? "30 Tonnes Sharp Sand"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      subTitle ?? 'N 115,000',
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
                      date ?? 'Monday, 31 October 2022 ',
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
                  padding: EdgeInsets.only(left: Get.width * 0.015, top: 5),
                  child: Image.asset(
                    'assets/images/Group 47403.png',
                    height: Get.width * 0.07,
                    width: Get.width * 0.07,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.015, bottom: 5),
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
      margin: EdgeInsets.only(
          left: Get.width * 0.03, right: Get.width * 0.03, bottom: 20, top: 5),
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
        onTap: () {
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
                    border: Border.all(color: Color(0xFFDC1515)),
                    bckgrndColor: Colors.white,
                    fontColor: Color(0xFFDC1515),
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

class ServiceRequestItem extends StatelessWidget {
  const ServiceRequestItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*CachedNetworkImageProvider(
      "www.com",
    )*/
    return Container(
      margin: EdgeInsets.only(
          left: Get.width * 0.03, right: Get.width * 0.03, bottom: 20, top: 5),
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
        onTap: () {
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
                          "Project ID : LAN -SUV-132  ",
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
                          'Location : Ogba-Ikeja, Lagos',
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
                    border: Border.all(color: Color(0xFFDC1515)),
                    bckgrndColor: Colors.white,
                    fontColor: Color(0xFFDC1515),
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
