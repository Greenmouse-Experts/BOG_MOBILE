import 'dart:convert';

import 'package:bog/app/global_widgets/overlays.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/complete_prod_review.dart' as cs;
import '../../data/model/log_in_model.dart';
import '../../data/model/my_products.dart';

import '../../data/providers/api_response.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_button.dart';

import '../../global_widgets/app_loader.dart';
import '../../global_widgets/bottom_widget.dart';
import '../../global_widgets/item_counter.dart';
import '../../global_widgets/new_app_bar.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  final MyProducts prod;
  const ProductDetails({Key? key, required this.productId, required this.prod})
      : super(key: key);

  static const route = '/productDetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with TickerProviderStateMixin {
  late TabController tabController;

  late Future<ApiResponse> getReviews;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    initializeData();
  }

  void onApiChange() {
    setState(() {
      initializeData();
    });
  }

  void initializeData() {
    final controller = Get.find<HomeController>();
    getReviews = controller.userRepo
        .getData('/review/product/get-review?productId=${widget.productId}');
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    var newProd = widget.prod;
    final product = newProd;
    final controller = Get.find<HomeController>();
    int currentQuantity = controller.cartItems.containsKey(product.id)
        ? controller.cartItems.values
            .firstWhere((element) => element.product.id == product.id)
            .quantity
        : 1;

    final productReviews = product.review;

    double sum = 0;
    var reviewAverage = 0.0;
    for (var item in productReviews!) {
      sum += item.star ?? 0;
    }
    reviewAverage = productReviews.isEmpty ? 0.0 : sum / productReviews.length;

    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'productDetails',
          builder: (controller) {
            return Scaffold(
              appBar: newAppBarBack(context, 'Product Details'),
              body: SingleChildScrollView(
                child: SizedBox(
                  width: Get.width,
                  child: FutureBuilder<ApiResponse>(
                      future: getReviews,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const AppLoader();
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          cs.CompProdReviewModel completeReviews;
                          completeReviews = cs.CompProdReviewModel();
                          List<cs.Review> reviews = [];
                          if (snapshot.data != null) {
                            completeReviews = cs.CompProdReviewModel.fromJson(
                                snapshot.data!.data);
                            reviews = completeReviews.reviews ?? [];
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.03,
                                    right: Get.width * 0.03),
                                child: Container(
                                  height: Get.height * 0.28,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.bostonUniRed,
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          product.productImage!.isEmpty
                                              ? "https://www.woolha.com/media/2020/03/eevee.png"
                                              : product.productImage![0].url ??
                                                  "https://www.woolha.com/media/2020/03/eevee.png",
                                          fit: BoxFit.cover, errorBuilder:
                                              (context, error, stackTrace) {
                                        return Container(
                                          width: width * 0.35,
                                          height: Get.height * 0.1,
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.grey
                                                    .withOpacity(0.1),
                                                width: 1),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.image_not_supported,
                                              color: AppColors.background,
                                              size: width * 0.1,
                                            ),
                                          ),
                                        );
                                      })),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Get.width * 0.018,
                                    height: Get.width * 0.018,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.03),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.015,
                                                bottom: Get.height * 0.01),
                                            child: Text(product.name.toString(),
                                                style: AppTextStyle.subtitle1
                                                    .copyWith(
                                                        fontSize:
                                                            multiplier * 0.08,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                          ),
                                          RatingBarIndicator(
                                              rating: reviewAverage,
                                              itemBuilder: (context, _) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                );
                                              }),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.015,
                                                top: Get.height * 0.01),
                                            child: Text(
                                              'N${product.price.toString()}',
                                              style:
                                                  AppTextStyle.caption.copyWith(
                                                color: AppColors.primary,
                                                fontSize: Get.width * 0.045,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: Get.width * 0.07,
                                          width: Get.width * 0.07,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                              color: AppColors.grey
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: Icon(
                                              FeatherIcons.heart,
                                              color: AppColors.grey
                                                  .withOpacity(0.2),
                                              size: Get.width * 0.05,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.04,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: Get.width * 0.0),
                                          child: ItemCounter(
                                            itemIncrement: () {
                                              controller.cartItemIncrement(
                                                  product.id!);
                                            },
                                            maxCount: product.remaining ?? 0,
                                            itemDecrement: () {
                                              controller.cartItemDecrement(
                                                  product.id!);
                                            },
                                            initialCount: controller.cartItems
                                                    .containsKey(product.id)
                                                ? controller.cartItems.values
                                                    .firstWhere((element) =>
                                                        element.product.id ==
                                                        product.id)
                                                    .quantity
                                                : 1,
                                            onCountChanged: (count) {
                                              if (count == 0) {
                                                currentQuantity = 1;
                                              } else {
                                                currentQuantity = count;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.0,
                                    right: Get.width * 0.03),
                                child: TabBar(
                                  controller: tabController,
                                  padding: EdgeInsets.zero,
                                  labelColor: Colors.black,
                                  unselectedLabelColor: const Color(0xff9A9A9A),
                                  indicatorColor: AppColors.primary,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelPadding: EdgeInsets.zero,
                                  indicatorPadding: EdgeInsets.zero,
                                  tabs: const [
                                    Tab(
                                      text: 'Description',
                                      iconMargin: EdgeInsets.zero,
                                    ),
                                    Tab(
                                      text: 'Reviews',
                                      iconMargin: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.03,
                                    right: Get.width * 0.03),
                                child: Container(
                                  height: 1,
                                  width: width,
                                  color: AppColors.grey.withOpacity(0.1),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.03,
                                    right: Get.width * 0.03),
                                child: SizedBox(
                                  height: Get.height * 0.21,
                                  width: Get.width,
                                  child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.description.toString(),
                                              style: AppTextStyle.subtitle1
                                                  .copyWith(
                                                fontSize: multiplier * 0.075,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      reviews.isEmpty
                                          ? Column(
                                              children: [
                                                AppButton(
                                                  title: 'Leave a Review',
                                                  bckgrndColor:
                                                      AppColors.orange,
                                                  onPressed: () {
                                                    var logInDetails =
                                                        LogInModel.fromJson(
                                                            jsonDecode(MyPref
                                                                .logInDetail
                                                                .val));
                                                    AppOverlay
                                                        .showProductReviewDialog(
                                                            context: context,
                                                            reload: onApiChange,
                                                            userId: logInDetails
                                                                    .id ??
                                                                '',
                                                            productId:
                                                                product.id ??
                                                                    '');
                                                  },
                                                ),
                                                const SizedBox(height: 10),
                                                const Center(
                                                    child: Text(
                                                        'No Reviews Yet, Buy this Product to make a review')),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                AppButton(
                                                  title: 'Leave a Review',
                                                  bckgrndColor:
                                                      AppColors.orange,
                                                  onPressed: () {
                                                    var logInDetails =
                                                        LogInModel.fromJson(
                                                            jsonDecode(MyPref
                                                                .logInDetail
                                                                .val));
                                                    AppOverlay
                                                        .showProductReviewDialog(
                                                            context: context,
                                                            reload: onApiChange,
                                                            userId: logInDetails
                                                                    .id ??
                                                                '',
                                                            productId:
                                                                product.id ??
                                                                    '');
                                                  },
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        'Reviews (${reviews.length})'),
                                                    const Spacer(),
                                                    const Icon(Icons.star,
                                                        color: Colors.amber),
                                                    Text(reviewAverage
                                                        .toString())
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.1,
                                                  child: ListView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      itemCount: reviews.length,
                                                      itemBuilder: (ctx, i) {
                                                        final review =
                                                            reviews[i];
                                                        return ListTile(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          title: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'User: ${review.client?.name ?? ''}',
                                                                style: AppTextStyle
                                                                    .bodyText2
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black),
                                                              ),
                                                              RatingBarIndicator(
                                                                  itemSize:
                                                                      Get.width *
                                                                          0.05,
                                                                  rating: (review
                                                                              .star ??
                                                                          0)
                                                                      .toDouble(),
                                                                  itemBuilder:
                                                                      (context,
                                                                          _) {
                                                                    return Icon(
                                                                      Icons
                                                                          .star,
                                                                      size: Get
                                                                              .width *
                                                                          0.02,
                                                                      color: Colors
                                                                          .amber,
                                                                    );
                                                                  })
                                                            ],
                                                          ),
                                                          subtitle: Text(
                                                            review.review ?? '',
                                                            style: AppTextStyle
                                                                .bodyText2
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              GetBuilder<HomeController>(builder: (controller) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: Get.width * 0.03,
                                      right: Get.width * 0.03),
                                  child: AppButton(
                                    title: controller.cartItems.keys
                                            .contains(product.id)
                                        ? 'Proceed to Checkout'
                                        : 'Add To Cart',
                                    onPressed: () {
                                      if (controller.cartItems.keys
                                          .contains(product.id)) {
                                        Get.back();
                                        Get.back();
                                        controller.currentBottomNavPage.value =
                                            3;
                                        controller.updateNewUser(
                                            controller.currentType);
                                        controller.update(['home']);
                                      } else {
                                        controller.addItem(
                                            product, currentQuantity);
                                      }
                                    },
                                    borderRadius: 10,
                                    padding: EdgeInsets.symmetric(
                                        vertical: Get.height * 0.02),
                                  ),
                                );
                              }),
                            ],
                          );
                        }
                      }),
                ),
              ),
              bottomNavigationBar: HomeBottomWidget(
                controller: controller,
                isHome: false,
                doubleNavigate: true,
              ),
            );
          }),
    );
  }
}


//  FutureBuilder<ApiResponse>(
//                   future: controller.userRepo.getData(
//                       '/review/product/get-review?productId=${product.id}'),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const AppLoader();
//                     } else {
//                       if (snapshot.hasError) {
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: Text(snapshot.error.toString()),
//                             ),
//                           ],
//                         );
//                       } else {
//                         final response = snapshot.data!.data as List<dynamic>;

//                         final productReviews = <ProductReviewModel>[];

//                         for (var element in response) {
//                           productReviews
//                               .add(ProductReviewModel.fromJson(element));
//                         }

//                         double sum = 0;
//                         var reviewAverage = 0.0;
//                         for (var item in productReviews) {
//                           sum += item.star ?? 0;
//                         }
//                         reviewAverage = productReviews.isEmpty
//                             ? 0
//                             : sum / productReviews.length;

                     
//                       }
//                     }
//                   }),


   