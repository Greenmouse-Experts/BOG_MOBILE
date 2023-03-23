import 'package:bog/app/global_widgets/app_ratings.dart';
import 'package:bog/app/global_widgets/page_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/my_products.dart';
import '../../data/model/shop_category.dart';
import '../../data/providers/api_response.dart';
import '../../global_widgets/bottom_widget.dart';

import 'product_details.dart';

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
            body: SizedBox(
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.05,
                        left: width * 0.03,
                        top: kToolbarHeight),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            "assets/images/back.svg",
                            height: width * 0.045,
                            width: width * 0.045,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Shop",
                                style: AppTextStyle.subtitle1.copyWith(
                                    fontSize: multiplier * 0.07,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * 0.04,
                  ),
                  Container(
                    height: 1,
                    width: width,
                    color: AppColors.grey.withOpacity(0.1),
                  ),
                  SizedBox(
                    height: width * 0.04,
                  ),
                  FutureBuilder<ApiResponse>(
                      future: getProductCategory,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data!.isSuccessful) {
                          final posts =
                              ShopCategory.fromJsonList(snapshot.data!.data);

                          List<Tab> tabs = [
                            const Tab(
                              child: Text('All'),
                            )
                          ];
                          List<String> dropDownItem = [
                            'All',
                          ];
                          List<Widget> contents = [];
                          contents.add(getProducts(controller, posts[0],
                              multiplier, width, true, getAllProducts));
                          for (var element in posts) {
                            if (element.totalProducts != 0) {
                              tabs.add(
                                  Tab(child: Text(element.name.toString())));
                            }

                            if (element.totalProducts != 0) {
                              dropDownItem.add(element.name!);
                              contents.add(getProducts(controller, element,
                                  multiplier, width, false, getAllProducts));
                            }
                          }

                          prods = contents[0];
                          //   String selectedValue = dropDownItem[0];

                          return SizedBox(
                            height: Get.height * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  PageDropButton(
                                    onChanged: (val) {
                                      setState(() {
                                        //   selectedValue = val;
                                        final index = dropDownItem.indexWhere(
                                            (element) => element == val);

                                        prods = contents[index];
                                        print(prods);
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
                                  const SizedBox(height: 20),
                                  Column(
                                    children: [prods],
                                  )
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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

            return SizedBox(
              height: Get.height * 0.73,
              width: Get.width * 0.92,
              child: GridView.builder(
                itemCount: posts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 4.5,
                    crossAxisCount: 2,
                    mainAxisSpacing: 15),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(0),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.02, right: width * 0.02),
                    child: InkWell(
                      onTap: () {
                        Get.to(const ProductDetails(key: Key('ProductDetails')),
                            arguments: posts[index]);
                      },
                      child: Container(
                        width: width * 0.45,
                        height: Get.height * 0.45,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundVariant2,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppColors.grey.withOpacity(0.1), width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: Get.height * 0.1,
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
                                            .url
                                            .toString(),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    errorBuilder: (context, error, stackTrace) {
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
                                  left: width * 0.03, right: width * 0.03),
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
                                  left: width * 0.03, right: width * 0.03),
                              child: Text(
                                "NGN ${posts[index].price} ",
                                // /${posts[index].unit
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
                                  rating: 5,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
