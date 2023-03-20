import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/model/my_products.dart';
import '../../../data/providers/api_response.dart';



import '../../../global_widgets/app_loader.dart';

import '../../../global_widgets/page_dropdown.dart';

import '../../add_products/add_products.dart';
import '../../checkout/checkout.dart';
import '../../orders/order_details.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  @override
  Widget build(BuildContext context) {
    String search = "";
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

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
                if (controller.currentType == "Client" ||
                    controller.currentType == "Corporate Client")
                  Expanded(
                    child: Padding(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
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
                                        deleteItem: () {
                                          controller.removeItem(
                                              product.id!, product);
                                        },
                                        itemDecrement: () {
                                          controller
                                              .cartItemDecrement(product.id!);
                                        },
                                        itemIncrement: () {
                                          controller
                                              .cartItemIncrement(product.id!);
                                        },
                                        title: product.name.toString(),
                                        image: product.image.toString(),
                                        price: "N ${product.price}",
                                        quantity: controller.productsMap[
                                                product.id.toString()] ??
                                            1,
                                        quantityChanged: (value) {
                                          //    controller.cartItemIncrement(product.id!);
                                          // controller.addProductToCart(product);
                                          // controller.productsMap[
                                          //     product.id.toString()] = value;
                                          // controller.update();
                                        },
                                      );
                                    }),
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
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
                                    label:
                                        'Do you have a coupon ? Enter it here',
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
                                        "N ${controller.subTotalPrice}",
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
                                        "Estimated Delivery Fee :",
                                        style: AppTextStyle.subtitle1.copyWith(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.035,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        "TBD",
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
                                        "Estimated Sales Tax :",
                                        style: AppTextStyle.subtitle1.copyWith(
                                          color: Colors.black,
                                          fontSize: Get.width * 0.035,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        "TBD",
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
                                        "N ${controller.subTotalPrice + 5000}",
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
                                      Get.to(() => const Checkout());
                                    },
                                    borderRadius: 10,
                                    enabled: controller.productsList.isNotEmpty,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  Expanded(
                    child: FutureBuilder<ApiResponse>(
                        future: controller.userRepo.getData("/products"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data!.isSuccessful) {
                            final posts =
                                MyProducts.fromJsonList(snapshot.data!.data).obs;
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
                                  deleteProd: () async{
                                    print(posts[index].id);
                                    final response = await controller.userRepo.deleteData('/product/${posts[index].id}');

                                    if (response.isSuccessful){
                                      posts.removeAt(index);
                                      setState(() {
                                        
                                      });
                                      Get.back();
                                      Get.showSnackbar(const GetSnackBar(message: 'Product Deleted Successfully', backgroundColor: Colors.green,));
                                    } else{
                                      Get.back();
                                      Get.showSnackbar(const GetSnackBar(message: "Product wasn't deleted",backgroundColor: Colors.red,));
                                    }
                                  },
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
                                child: const AppLoader());
                          }
                        }),
                  ),
                if (controller.currentType == "Service Partner")
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
                if (controller.currentType == "Service Partner")
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                if (controller.currentType == "Service Partner")
                  Expanded(
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return const ServiceRequestItem();
                      },
                    ),
                  )
              ],
            ),
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
        ),
      );
    });
  }
}

class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key,
      this.image = "assets/images/dummy_image.png",
      this.title = "30 Tonnes Sharp Sand",
      this.subTitle = "",
      this.price = "N 115,000",
      this.quantity = 1,
      this.quantityChanged,
      required this.itemIncrement,
      required this.itemDecrement,
      required this.deleteItem})
      : super(key: key);

  final String image;
  final String title;
  final String subTitle;
  final String price;
  final int quantity;
  final VoidCallback itemIncrement;
  final VoidCallback itemDecrement;
  final VoidCallback deleteItem;
  final Function(int)? quantityChanged;

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
            SizedBox(
              height: 90,
              width: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
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
                    child: Text(
                      title,
                      style: AppTextStyle.caption.copyWith(
                        color: Colors.black,
                        fontSize: Get.width * 0.035,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AppRating(onRatingUpdate: (value) {}, rating: 4.5),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      price,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      AppOverlay.showInfoDialog(
                          title: 'Delete Item from Cart',
                          buttonText: 'Delete Item',
                          content: 'Are you sure you want to delete this item?',
                          doubleFunction: true,
                          onPressed: () {
                            deleteItem();
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                ItemCounter(
                  itemDecrement: () {
                    itemDecrement();
                  },
                  itemIncrement: () {
                    itemIncrement();
                  },
                  initialCount: quantity,
                  onCountChanged: (count) {
                    if (quantityChanged != null) {
                      quantityChanged!(count);
                    }
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
  final String price;
  final DateTime date;
  final String status;
  final Color? statusColor;
  final String orderItemName;
  const OrderItem({
    Key? key,
    required this.status,
    this.statusColor,
    required this.orderItemName,
    required this.date,
    required this.price,
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
                      status.capitalize!,
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

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    this.title,
    this.subTitle,
    this.date,
    this.image,
   required this.deleteProd,
  }) : super(key: key);

  final String? title;
  final String? subTitle;
  final String? date;
  final String? image;
  final VoidCallback deleteProd;
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
                        color: const Color(0xFF9A9A9A),
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
                InkWell(
                  onTap: (){
                     AppOverlay.showInfoDialog(
                          title: 'Delete This Product',
                          buttonText: 'Delete Product',
                          content: 'Are you sure you want to delete this PRODUCT',
                          doubleFunction: true,
                          onPressed: () {
                            deleteProd();
                          });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015, top: 5),
                    child: Image.asset(
                      'assets/images/Group 47403.png',
                      height: Get.width * 0.07,
                      width: Get.width * 0.07,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.015, bottom: 5),
                  child: SizedBox(
                    width: Get.width * 0.2,
                    child: AppButton(
                      title: "Pending",
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      border: Border.all(color: const Color(0xFFECF6FC)),
                      bckgrndColor: const Color(0xFFECF6FC),
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
          Get.to(() => const OrderDetails(
                id: '',
              ));
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
                    border: Border.all(color: const Color(0xFFDC1515)),
                    bckgrndColor: Colors.white,
                    fontColor: const Color(0xFFDC1515),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.4,
                  child: AppButton(
                    title: "Accept",
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    border: Border.all(color: const Color(0xFF24B53D)),
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
          Get.to(() => const OrderDetails(
                id: '',
              ));
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
                    border: Border.all(color: const Color(0xFFDC1515)),
                    bckgrndColor: Colors.white,
                    fontColor: const Color(0xFFDC1515),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.4,
                  child: AppButton(
                    title: "Accept",
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    border: Border.all(color: const Color(0xFF24B53D)),
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
