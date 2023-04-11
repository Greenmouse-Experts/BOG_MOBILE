import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/app_base_view.dart';
import '../../global_widgets/app_button.dart';
import '../../global_widgets/new_app_bar.dart';

class AddProductSuccess extends StatelessWidget {
  const AddProductSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;
    return AppBaseView(
      child: GetBuilder<HomeController>(builder: (controller) {
        return Scaffold(
          appBar: newAppBarBack(context, 'Product Added Successfully'),
          backgroundColor: AppColors.backgroundVariant2,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Product Submitted",
                    style: AppTextStyle.subtitle1.copyWith(
                        fontSize: multiplier * 0.07,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.05, right: width * 0.05),
                    child: Text(
                      "Congratulations,  your product has been submitted successfully. ",
                      style: AppTextStyle.subtitle1.copyWith(
                          fontSize: multiplier * 0.06,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    bottom: width * 0.2),
                child: AppButton(
                  title: "See My Products",
                  onPressed: () {
                    controller.currentBottomNavPage.value = 3;
                    controller.update(['home']);
                    Get.back();
                    Get.back();
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
