import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/my_products.dart';
import '../../data/model/shop_category.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/bottom_widget.dart';

import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/new_app_bar.dart';
import '../../global_widgets/page_dropdown.dart';
import 'product_details.dart';

final loadedProducts = <Widget>[];

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  static const route = '/shop';

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late Future<ApiResponse> getProductCategory;
  late Future<ApiResponse> getAllProducts;
  Widget prods = Container();
  var contentIndex = 0.obs;

  @override
  void initState() {
    final controller = Get.find<HomeController>();
    getProductCategory = controller.userRepo.getData('/product/category');
    getAllProducts = controller.userRepo.getData("/products/all");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return GetBuilder<HomeController>(
        id: 'shop',
        builder: (controller) {
          return Scaffold(
            appBar: newAppBarBack(context, 'Shop'),
            body: SizedBox(
              width: Get.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FutureBuilder<ApiResponse>(
                        future: getProductCategory,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data!.isSuccessful) {
                            final posts =
                                ShopCategory.fromJsonList(snapshot.data!.data);

                            List<String> dropDownItem = [
                              'All',
                            ];
                            final contents = <Widget>[].obs;
                            contents.add(getProducts(controller, posts[0],
                                multiplier, width, true, getAllProducts));
                            for (var element in posts) {
                              // if (element.totalProducts != 0) {}

                              if (element.totalProducts != 0) {
                                dropDownItem.add(element.name!);
                                contents.add(getProducts(controller, element,
                                    multiplier, width, false, getAllProducts));
                              }
                            }

                            prods = contents[0];

                            return SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    PageDropButton(
                                      onChanged: (val) {
                                        setState(() {
                                          final index = dropDownItem.indexWhere(
                                              (element) => element == val);
                                          contentIndex.value = index;
                                          prods = contents[index];
                                        });
                                      },
                                      label: '',
                                      hint: 'Categories',
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      value: dropDownItem.first,
                                      items: dropDownItem.map((value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 10),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: contents.length,
                                        itemBuilder: (context, i) {
                                          return contentIndex.value == i
                                              ? contents[i]
                                              : const SizedBox.shrink();
                                        })
                                  ],
                                ),
                              ),
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
                                      "No Products Categories Found",
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
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: HomeBottomWidget(
              controller: controller,
              isHome: false,
              doubleNavigate: false,
            ),
          );
        });
  }

  FutureBuilder<ApiResponse> getProducts(
      HomeController controller,
      ShopCategory element,
      double multiplier,
      double width,
      bool allPoructs,
      Future<ApiResponse> getAllProducts) {
    return FutureBuilder<ApiResponse>(
        future: getAllProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.isSuccessful) {
            final posts = MyProducts.fromJsonList(snapshot.data!.data);
            allPoructs
                ? null
                : posts.removeWhere((e) => e.categoryId != element.id);

            final newProduct = SizedBox(
              height: Get.height * 0.73,
              width: Get.width * 0.92,
              child: posts.isEmpty
                  ? const Center(
                      child: Text('No Products available'),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: posts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 4 / 4.5,
                              crossAxisCount: 2,
                              mainAxisSpacing: 15),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        final prod = posts[index];

                        final productReviews = prod.review;

                        double sum = 0;
                        var reviewAverage = 5.0;
                        for (var item in productReviews!) {
                          sum += item.star ?? 0;
                        }
                        reviewAverage = productReviews.isEmpty
                            ? 0.0
                            : sum / productReviews.length;
                        return Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.02, right: width * 0.02),
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => ProductDetails(
                                    productId: posts[index].id ?? '',
                                    prod: posts[index],
                                    key: const Key('ProductDetails')),
                                //   arguments: posts[index]
                              );
                            },
                            child: Container(
                              width: width * 0.45,
                              height: Get.height * 0.45,
                              decoration: BoxDecoration(
                                color: AppColors.backgroundVariant2,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.grey.withOpacity(0.1),
                                    width: 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.12,
                                    width: Get.width,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: width * 0.03,
                                          left: width * 0.03,
                                          right: width * 0.03),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          posts[index].productImage!.isEmpty
                                              ? "https://www.woolha.com/media/2020/03/eevee.png"
                                              : posts[index]
                                                      .productImage![0]
                                                      .url ??
                                                  "https://www.woolha.com/media/2020/03/eevee.png",
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              width: width * 0.45,
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
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: width * 0.02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.03,
                                        right: width * 0.03),
                                    child: Text(
                                      posts[index].name.toString(),
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.055,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: width * 0.02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.03,
                                        right: width * 0.03),
                                    child: Text(
                                      "NGN ${posts[index].price} ",
                                      style: AppTextStyle.subtitle1.copyWith(
                                          fontSize: multiplier * 0.055,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: width * 0.02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(width * 0.03),
                                    child: FittedBox(
                                      child: AppRating(
                                        onRatingUpdate: (val) {},
                                        rating: reviewAverage,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            );
            return newProduct;
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ],
              ),
            );
          }
        });
  }
}
