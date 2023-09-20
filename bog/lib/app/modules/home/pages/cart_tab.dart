import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/model/my_products.dart';
import '../../../data/providers/api_response.dart';
import '../../../global_widgets/app_loader.dart';
import '../../../global_widgets/app_tool_tip.dart';
import '../../../global_widgets/global_widgets.dart';
import '../../add_products/add_products.dart';
import '../../checkout/checkout.dart';
import '../../meetings/meeting.dart';
import '../../project_details/view_form.dart';
import '../../shop/shop.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  String search = "";
  bool isDraft = false;
  bool isReview = false;
  bool isInStore = false;
  bool isAll = true;

  late Future<ApiResponse> getProducts;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() {
    final controller = Get.find<HomeController>();
    getProducts = controller.userRepo.getData("/products");
  }

  void onApiChange() {
    setState(() {
      initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Container(
                  color: controller.currentType == "Product Partner"
                      ? Colors.white
                      : null,
                  child: const SizedBox(
                    height: kToolbarHeight,
                  ),
                ),
                Container(
                  color: controller.currentType == "Product Partner"
                      ? Colors.white
                      : null,
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
                      if (controller.currentType == "Product Partner")
                        const Spacer(),
                      if (controller.currentType == "Product Partner")
                        const AppToolTip(
                          message:
                              'Click on the plus button at the bottom right corner of the page to add a new product, after adding, your product is saved in the draft tab. Add to shop button on the more icon on the draft tab moves your product to review tab and submits it to be reviewed by the admin. After admin approval, your product is added to the shop.',
                        ),
                    ],
                  ),
                ),
                if (controller.currentType != 'Service Partner')
                  Container(
                    color: controller.currentType == "Product Partner"
                        ? Colors.white
                        : null,
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
                            height: controller.productsList.isEmpty
                                ? Get.height * 0.7
                                : Get.height * 0.3,
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
                                            fontSize: Get.width > 600
                                                ? Get.width * 0.025
                                                : Get.width * 0.035,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        AppButton(
                                          title: 'Shop Now',
                                          onPressed: () {
                                            Get.to(() => const Shop());
                                          },
                                        )
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
                                      final productReviews = product.review;

                                      double sum = 0;
                                      var reviewAverage = 0.0;
                                      for (var item in productReviews!) {
                                        sum += item.star ?? 0;
                                      }
                                      reviewAverage = productReviews.isEmpty
                                          ? 0.0
                                          : sum / productReviews.length;
                                      return CartItem(
                                        isCheckOut: false,
                                        rating: reviewAverage,
                                        deleteItem: () {
                                          controller.removeItem(
                                              product.id!, product);
                                        },
                                        maxcount: product.remaining ?? 0,
                                        itemDecrement: () {
                                          controller
                                              .cartItemDecrement(product.id!);
                                        },
                                        itemIncrement: () {
                                          controller
                                              .cartItemIncrement(product.id!);
                                        },
                                        title: product.name.toString(),
                                        image: product.productImage!.isEmpty
                                            ? "https://www.woolha.com/media/2020/03/eevee.png"
                                            : product.productImage![0].url ??
                                                "https://www.woolha.com/media/2020/03/eevee.png",
                                        price: "N ${product.price}",
                                        quantity: controller
                                            .cartItems[product.id.toString()]!
                                            .quantity,
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
                          if (controller.productsList.isNotEmpty)
                            SizedBox(
                              height: Get.height * 0.4,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.05,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Sub Total:",
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width > 600
                                                ? Get.width * 0.025
                                                : Get.width * 0.035,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "N ${controller.subTotalPrice}",
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width > 600
                                                ? Get.width * 0.025
                                                : Get.width * 0.035,
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
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width > 600
                                                ? Get.width * 0.025
                                                : Get.width * 0.035,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "TBD",
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width > 600
                                                ? Get.width * 0.025
                                                : Get.width * 0.035,
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
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width > 600
                                                ? Get.width * 0.025
                                                : Get.width * 0.035,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "TBD",
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width > 600
                                                ? Get.width * 0.025
                                                : Get.width * 0.035,
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
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width > 600
                                                ? Get.width * 0.025
                                                : Get.width * 0.035,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "NGN ${controller.subTotalPrice}",
                                          style:
                                              AppTextStyle.subtitle1.copyWith(
                                            color: AppColors.primary,
                                            fontSize: Get.width > 600
                                                ? Get.width * 0.03
                                                : Get.width * 0.04,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.035,
                                    ),
                                    AppButton(
                                      title: 'Proceed To Checkout',
                                      onPressed: () {
                                        Get.to(() => const Checkout());
                                      },
                                      borderRadius: 10,
                                      enabled:
                                          controller.productsList.isNotEmpty,
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
                  Container(
                    color: controller.currentType == "Product Partner"
                        ? Colors.white
                        : null,
                    padding: EdgeInsets.only(
                        left: Get.width * 0.03, right: Get.width * 0.03),
                    child: AppInput(
                      hintText: 'Search with name or keyword ...',
                      filledColor: Colors.white,
                      prefexIcon: Icon(
                        FeatherIcons.search,
                        color: Colors.black.withOpacity(.5),
                        size: Get.width > 600
                            ? Get.width * 0.03
                            : Get.width * 0.05,
                      ),
                      onChanged: (value) {
                        if (search != value) {
                          setState(() {
                            search = value;
                          });
                        }
                      },
                    ),
                  ),
                if (controller.currentType == "Product Partner")
                  Column(
                    children: [
                      Container(
                        color: controller.currentType == "Product Partner"
                            ? Colors.white
                            : null,
                        height: Get.height * 0.01,
                      ),
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                    ],
                  ),
                if (controller.currentType == "Product Partner")
                  Expanded(
                    child: FutureBuilder<ApiResponse>(
                        future: getProducts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data!.isSuccessful) {
                            RxList<MyProducts> posts =
                                MyProducts.fromJsonList(snapshot.data!.data)
                                    .obs;
                            var drafts = posts
                                .where((p0) => p0.status == 'draft')
                                .toList()
                                .obs;
                            var review = posts
                                .where((p0) => p0.status == 'in_review')
                                .toList()
                                .obs;
                            var instore = posts
                                .where((p0) => p0.status == 'approved')
                                .toList()
                                .obs;
                            if (search.isNotEmpty) {
                              posts = posts
                                  .where((element) => element.name!
                                      .toLowerCase()
                                      .contains(search.toLowerCase()))
                                  .toList()
                                  .obs;
                              drafts = drafts
                                  .where((element) => element.name!
                                      .toLowerCase()
                                      .contains(search.toLowerCase()))
                                  .toList()
                                  .obs;
                              instore = instore
                                  .where((element) => element.name!
                                      .toLowerCase()
                                      .contains(search.toLowerCase()))
                                  .toList()
                                  .obs;
                              review = review
                                  .where((element) => element.name!
                                      .toLowerCase()
                                      .contains(search.toLowerCase()))
                                  .toList()
                                  .obs;
                            }
                            if (posts.isEmpty) {
                              return SizedBox(
                                height: Get.height * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "You have no products yet",
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
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      NumberButton(
                                        isActive: isAll,
                                        onPressed: () {
                                          setState(() {
                                            isAll = true;
                                            isReview = false;
                                            isDraft = false;
                                            isInStore = false;
                                          });
                                        },
                                        text: 'All',
                                        num: posts.length,
                                      ),
                                      NumberButton(
                                        isActive: isInStore,
                                        onPressed: () {
                                          setState(() {
                                            isAll = false;
                                            isInStore = true;
                                            isReview = false;
                                            isDraft = false;
                                          });
                                        },
                                        text: 'In Store',
                                        num: instore.length,
                                      ),
                                      NumberButton(
                                        isActive: isReview,
                                        onPressed: () {
                                          setState(() {
                                            isAll = false;
                                            isInStore = false;
                                            isReview = true;
                                            isDraft = false;
                                          });
                                        },
                                        text: 'Review',
                                        num: review.length,
                                      ),
                                      NumberButton(
                                        isActive: isDraft,
                                        onPressed: () {
                                          setState(() {
                                            isAll = false;
                                            isReview = false;
                                            isInStore = false;
                                            isDraft = true;
                                          });
                                        },
                                        text: 'Draft',
                                        num: drafts.length,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.01),
                                SizedBox(
                                  height: Get.height * 0.6475,
                                  child: ListView.builder(
                                    itemCount: isAll
                                        ? posts.length
                                        : isInStore
                                            ? instore.length
                                            : isReview
                                                ? review.length
                                                : drafts.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final prod = isAll
                                          ? posts[index]
                                          : isInStore
                                              ? instore[index]
                                              : isReview
                                                  ? review[index]
                                                  : drafts[index];

                                      return ProductItem(
                                        title: prod.name,
                                        status: prod.status,
                                        myProduct: prod,
                                        rem: (prod.remaining ?? 0).toString(),
                                        editProduct: () async {
                                          await Get.to(() =>
                                              AddProject(myProduct: prod));
                                          onApiChange();
                                        },
                                        addProduct: () async {
                                          final response = await controller
                                              .userRepo
                                              .patchData(
                                                  '/product/add-to-shop/${prod.id}',
                                                  '');
                                          if (response.isSuccessful) {
                                            onApiChange();
                                            Get.back();
                                            Get.showSnackbar(const GetSnackBar(
                                              message:
                                                  'Product Added Successfully',
                                              backgroundColor: Colors.green,
                                            ));
                                          } else {
                                            Get.back();
                                            Get.showSnackbar(GetSnackBar(
                                              message: response.message ??
                                                  "Product wasn't added",
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        },
                                        deleteProd: () async {
                                          final response = await controller
                                              .userRepo
                                              .deleteData(
                                                  '/product/${prod.id}');

                                          if (response.isSuccessful) {
                                            onApiChange();
                                            Get.back();
                                            Get.showSnackbar(const GetSnackBar(
                                              message:
                                                  'Product Deleted Successfully',
                                              backgroundColor: Colors.green,
                                            ));
                                          } else {
                                            Get.back();
                                            Get.showSnackbar(const GetSnackBar(
                                              message: "Product wasn't deleted",
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        },
                                        subTitle: "N ${prod.price}",
                                        quantity: prod.quantity,
                                        image: prod.image,
                                      );
                                    },
                                  ),
                                ),
                              ],
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
                  const Meetings(),
              ],
            ),
          ),
          floatingActionButton: controller.currentType == "Client" ||
                  controller.currentType == "Corporate Client" ||
                  controller.currentType == "Service Partner"
              ? null
              : FloatingActionButton(
                  onPressed: () async {
                    await Get.to(() => const AddProject());
                    onApiChange();
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
      required this.image,
      this.title = "30 Tonnes Sharp Sand",
      this.subTitle = "",
      this.price = "N 115,000",
      this.quantity = 1,
      this.quantityChanged,
      required this.itemIncrement,
      required this.itemDecrement,
      required this.deleteItem,
      required this.rating,
      required this.isCheckOut,
      required this.maxcount})
      : super(key: key);

  final String image;
  final String title;
  final String subTitle;
  final String price;
  final int quantity;
  final int maxcount;
  final double rating;
  final bool isCheckOut;
  final VoidCallback itemIncrement;
  final VoidCallback itemDecrement;
  final VoidCallback deleteItem;
  final Function(int)? quantityChanged;

  @override
  Widget build(BuildContext context) {
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
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
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
                  imageUrl: image,
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
                        fontSize: Get.width > 600
                            ? Get.width * 0.025
                            : Get.width * 0.035,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AppRating(onRatingUpdate: (value) {}, rating: rating),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.015),
                    child: Text(
                      price,
                      style: AppTextStyle.caption.copyWith(
                        color: Colors.black,
                        fontSize: Get.width > 600
                            ? Get.width * 0.025
                            : Get.width * 0.035,
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
                !isCheckOut
                    ? IconButton(
                        onPressed: () {
                          AppOverlay.showInfoDialog(
                              title: 'Delete Item from Cart',
                              buttonText: 'Delete Item',
                              content:
                                  'Are you sure you want to delete this item?',
                              doubleFunction: true,
                              onPressed: () {
                                Get.back();
                                deleteItem();
                              });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                    : const SizedBox(),
                isCheckOut
                    ? Text('Quantity: $quantity')
                    : ItemCounter(
                        itemDecrement: () {
                          itemDecrement();
                        },
                        itemIncrement: () {
                          itemIncrement();
                        },
                        maxCount: maxcount,
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
                      fontSize: Get.width > 600
                          ? Get.width * 0.025
                          : Get.width * 0.035,
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

class NumberButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;
  final String text;
  final int num;
  const NumberButton(
      {super.key,
      required this.isActive,
      required this.onPressed,
      required this.text,
      required this.num});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            decoration: BoxDecoration(
                color: isActive ? AppColors.primary : const Color(0XFFF7F7F7),
                borderRadius: BorderRadius.circular(12)),

            // ElevatedButton.styleFrom(
            //     elevation: 0,
            //     backgroundColor:
            //
            //     shape: RoundedRectangleBorder(
            //         borderRadius:
            //     fixedSize: Size(Get.width * 0.1, Get.height * 0.02)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: AppTextStyle.caption.copyWith(
                      color: isActive
                          ? AppColors.backgroundVariant1
                          : Colors.black),
                ),
                SizedBox(width: Get.width * 0.005),
                Container(
                  width: Get.width * 0.06,
                  height: Get.height * 0.02,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.backgroundVariant1,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    '$num',
                    style:
                        AppTextStyle.caption.copyWith(color: AppColors.primary),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    this.title,
    this.subTitle,
    this.quantity,
    this.image,
    required this.status,
    this.rem,
    required this.deleteProd,
    required this.addProduct,
    required this.myProduct,
    required this.editProduct,
  }) : super(key: key);

  final String? title;
  final String? subTitle;
  final String? quantity;
  final String? image;
  final String? status;
  final String? rem;
  final VoidCallback editProduct;
  final VoidCallback deleteProd;
  final VoidCallback addProduct;
  final MyProducts myProduct;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                height: Get.width * 0.2,
                width: Get.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: image.toString(),
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.primary),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        height: Get.width * 0.2,
                        width: Get.width * 0.2,
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
                      child: Text(title ?? "",
                          style: AppTextStyle.headline4.copyWith(
                              fontSize: Get.width > 600
                                  ? Get.width * 0.024
                                  : Get.width * 0.033,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.015),
                      child: Text(
                        subTitle ?? '',
                        style: AppTextStyle.caption.copyWith(
                          color: Colors.black,
                          fontSize: Get.width > 600
                              ? Get.width * 0.023
                              : Get.width * 0.032,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.015),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Qty: ${quantity ?? 0}',
                            style: AppTextStyle.caption.copyWith(
                              color: const Color(0xFF9A9A9A),
                              fontSize: Get.width > 600
                                  ? Get.width * 0.023
                                  : Get.width * 0.03,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Remaining: ${rem ?? 0}',
                            style: AppTextStyle.caption.copyWith(
                              color: const Color(0xFF9A9A9A),
                              fontSize: Get.width > 600
                                  ? Get.width * 0.023
                                  : Get.width * 0.03,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
                  PopupMenuButton(
                      color: Colors.white,
                      child: const Icon(Icons.more_vert_outlined,
                          color: AppColors.ashColor, size: 30),
                      itemBuilder: (context) {
                        return [
                          if (status == 'draft')
                            PopupMenuItem(
                                child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                      AppOverlay.showInfoDialog(
                                          title: 'Add product to shop',
                                          buttonText: 'Add',
                                          content:
                                              'Are you sure you want to add this product to shop',
                                          doubleFunction: true,
                                          onPressed: () async => addProduct());
                                    },
                                    child: Text(
                                      'Add to Shop',
                                      style: TextStyle(
                                          fontSize: 12 * Get.textScaleFactor,
                                          color: Colors.black),
                                    ))),
                          if (status != 'approved')
                            PopupMenuItem(
                                child: TextButton(
                                    onPressed: () {
                                      Get.back();

                                      editProduct();
                                    },
                                    child: Text(
                                      'Edit Product',
                                      style: TextStyle(
                                          fontSize: 12 * Get.textScaleFactor,
                                          color: Colors.black),
                                    ))),
                          PopupMenuItem(
                              child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                    AppOverlay.showInfoDialog(
                                        title: 'Delete This Product',
                                        buttonText: 'Delete Product',
                                        content:
                                            'Are you sure you want to delete this Product',
                                        doubleFunction: true,
                                        onPressed: () async => deleteProd());
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontSize: 12 * Get.textScaleFactor,
                                        color: Colors.red),
                                  )))
                        ];
                      }),
                  Padding(
                    padding:
                        EdgeInsets.only(left: Get.width * 0.015, bottom: 5),
                    child: SizedBox(
                      width: Get.width * 0.2,
                      child: AppButton(
                        title: (status == 'in_review'
                            ? 'In Review'
                            : status?.capitalizeFirst ?? 'Pending'),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        fontSize: 12 * Get.textScaleFactor,
                        onPressed: () {},
                        border: Border.all(
                            color: status == 'approved'
                                ? AppColors.successGreen.withOpacity(0.1)
                                : status == 'disapproved'
                                    ? Colors.red.withOpacity(0.1)
                                    : const Color(0xFFECF6FC)),
                        bckgrndColor: const Color(0xFFECF6FC),
                        fontColor: status == 'approved'
                            ? AppColors.successGreen
                            : status == 'disapproved'
                                ? Colors.red
                                : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderRequestItem extends StatelessWidget {
  final String orderSlug;
  final int quantity;
  final String price;
  final String name;
  final String status;
  const OrderRequestItem({
    Key? key,
    required this.orderSlug,
    required this.quantity,
    required this.price,
    required this.name,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Get.to(() => const OrderProgressPage()),
      child: Container(
        margin: EdgeInsets.only(
            left: Get.width * 0.03,
            right: Get.width * 0.03,
            bottom: 20,
            top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Order ID :  $orderSlug ",
                          style: AppTextStyle.caption.copyWith(
                            color: Colors.black,
                            fontSize: Get.width > 600
                                ? Get.width * 0.025
                                : Get.width * 0.035,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.005),
                        child: Text(
                          name,
                          style: AppTextStyle.caption.copyWith(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: Get.width > 600
                                ? Get.width * 0.023
                                : Get.width * 0.033,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Get.height * 0.01),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.015),
                      child: Text(
                        'NGN $price',
                        style: AppTextStyle.caption.copyWith(
                          color: AppColors.primary,
                          fontSize: Get.width > 600
                              ? Get.width * 0.025
                              : Get.width * 0.035,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.015),
                      child: Text(
                        'Qty: $quantity',
                        style: AppTextStyle.caption.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: Get.width > 600
                              ? Get.width * 0.023
                              : Get.width * 0.033,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              children: [
                Text(
                  'Status:  ${status.toUpperCase()}',
                  style: AppTextStyle.caption.copyWith(
                      fontSize: Get.width > 600
                          ? Get.width * 0.025
                          : Get.width * 0.035,
                      fontWeight: FontWeight.w400,
                      color: status == 'cancelled'
                          ? Colors.red
                          : status == 'completed'
                              ? AppColors.successGreen
                              : Colors.black),
                ),
                const Spacer(),
                // // IconButton(
                // //     onPressed: () {
                // //       AppOverlay.showInfoDialog(
                // //           title: 'Accept Delivery',
                // //           doubleFunction: true,
                // //           content:
                // //               'Do you want to accept responsibility for delivering this product?',
                // //           buttonText: 'Accept');
                // //     },
                // //     icon: const Icon(Icons.more_vert_outlined)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ServiceRequestItem extends StatelessWidget {
  final String projectId;
  final String location;
  final String id;
  final String userId;
  const ServiceRequestItem({
    Key? key,
    required this.projectId,
    required this.location,
    required this.id,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            offset: const Offset(0, 3),
          ),
        ],
      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Project ID :  $projectId",
                            style: AppTextStyle.caption.copyWith(
                              color: Colors.black,
                              fontSize: Get.width > 600
                                  ? Get.width * 0.025
                                  : Get.width * 0.035,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Get.to(() => ViewFormPage(id: id));
                              },
                              icon: const Icon(
                                Icons.visibility_outlined,
                                color: AppColors.primary,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.005),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Project Type: $location',
                            style: AppTextStyle.caption.copyWith(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: Get.width * 0.033,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  child: TextButton(
                                      onPressed: () async {
                                        final controller =
                                            Get.find<HomeController>();
                                        Get.back();
                                        final response =
                                            await controller.userRepo.postData(
                                                '/projects/apply-project', {
                                          'areYouInterested': true,
                                          'projectId': id,
                                          'userId': userId
                                        });

                                        if (response.isSuccessful) {
                                          Get.snackbar(
                                              'Success',
                                              response.message ??
                                                  'Project application successful',
                                              backgroundColor: Colors.green,
                                              colorText: AppColors.background);
                                        } else {
                                          Get.snackbar(
                                              'Error',
                                              response.message ??
                                                  'An error occurred',
                                              backgroundColor: Colors.red,
                                              colorText: AppColors.background);
                                        }
                                      },
                                      child: const Text(
                                        'Accept project',
                                        style: TextStyle(color: Colors.black),
                                      ))),
                              PopupMenuItem(
                                  child: TextButton(
                                      onPressed: () {
                                        AppOverlay.showAcceptFormDialog(
                                            userId: userId,
                                            projectId: id,
                                            title: 'Confirm',
                                            doubleFunction: true,
                                            buttonText: 'Submit');
                                      },
                                      child: const Text(
                                        'Fill Interest Form',
                                        style: TextStyle(color: Colors.black),
                                      ))),
                            ];
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 10),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     SizedBox(
          //       width: Get.width * 0.4,
          //       child: AppButton(
          //         title: "Decline",
          //         onPressed: () {
          //           AppOverlay.showInfoDialog(
          //               title: 'Confirm',
          //               content:
          //                   'Are you sure you want to decline this project',
          //               doubleFunction: true,
          //               buttonText: 'Continue');
          //         },
          //         padding: const EdgeInsets.symmetric(vertical: 10),
          //         border: Border.all(color: const Color(0xFFDC1515)),
          //         bckgrndColor: Colors.white,
          //         fontColor: const Color(0xFFDC1515),
          //       ),
          //     ),
          //     SizedBox(
          //       width: Get.width * 0.4,
          //       child: AppButton(
          //         title: "Accept",
          //         onPressed: () {
          //           AppOverlay.showInterestAcceptance(userId: userId, id: id);

          //           // AppOverlay.showAcceptFormDialog(
          //           //     userId: userId,
          //           //     projectId: id,
          //           //     title: 'Confirm',
          //           //     doubleFunction: true,
          //           //     buttonText: 'Submit');
          //         },
          //         padding: const EdgeInsets.symmetric(vertical: 10),
          //         border: Border.all(color: const Color(0xFF24B53D)),
          //         bckgrndColor: Colors.white,
          //         fontColor: const Color(0xFF24B53D),
          //       ),
          //     ),
          //   ],
          // )
        ],
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
