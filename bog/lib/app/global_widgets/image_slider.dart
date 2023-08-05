import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/theme/theme.dart';
import '../data/model/my_products.dart';

class ImageSlider extends StatelessWidget {
  final List<ProductImage> images;
  const ImageSlider({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: images.isEmpty
          ? [
              CachedNetworkImage(
                  imageUrl:
                      // 'https://ichef.bbci.co.uk/news/976/cpsprodpb/16DEB/production/_121457639_tv071221629.jpg',
                      '',
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) {
                    return Container(
                      width: Get.width * 0.35,
                      height: Get.height * 0.1,
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
                  }),
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
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ],
              )
            ]
          : [
              Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.03, right: Get.width * 0.03),
                child: Container(
                  height: Get.height * 0.28,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.bostonUniRed,
                  ),
                  child: PageView(
                    controller: controller,
                    children: images.map((e) {
                      return CachedNetworkImage(
                          imageUrl:
                              // 'https://ichef.bbci.co.uk/news/976/cpsprodpb/16DEB/production/_121457639_tv071221629.jpg',
                              e.url ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (context, error, stackTrace) {
                            return Container(
                              width: Get.width * 0.35,
                              height: Get.height * 0.1,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.grey.withOpacity(0.1),
                                    width: 1),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: AppColors.background,
                                  size: Get.width * 0.1,
                                ),
                              ),
                            );
                          });
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: images.length,
                        effect: WormEffect(
                            dotHeight: Get.height * 0.014,
                            dotWidth: Get.height * 0.014,
                            //   expansionFactor: 3.2,
                            dotColor: AppColors.primary.withOpacity(0.2),
                            activeDotColor: AppColors.primary),
                      ),
                    ),
                  ),
                  // Container(
                  //   width: Get.width * 0.018,
                  //   height: Get.width * 0.018,
                  //   decoration: BoxDecoration(
                  //     color: AppColors.primary,
                  //     borderRadius: BorderRadius.circular(100.0),
                  //   ),
                  // ),
                ],
              ),
            ],
    );
  }
}
