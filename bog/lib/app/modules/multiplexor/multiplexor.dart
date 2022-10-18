import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import '../../global_widgets/app_button.dart';
import '../sign_up/service_provider.dart';
import '../sign_up/sign_up.dart';
import '../sign_up/supplier.dart';

class Multiplexor extends StatelessWidget {
  const Multiplexor({Key? key}) : super(key: key);

  static const route = '/multiplexor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.all(AppThemes.appPaddingVal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              SvgPicture.asset(
                'assets/images/wayagram2.svg',
                color: AppColors.background,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              Image.asset(
                'assets/images/boglogo.png',
                width: Get.width,
                height: Get.height * 0.2,
              ),
              Text(
                'Select the type of account you would like to create',
                style: AppTextStyle.headline4.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(ServiceProviderSignUp.route);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/multiplexorBG.png',
                    ),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        Image.asset(
                          'assets/images/m1.png',
                          width: Get.width*0.15,
                          height: Get.width*0.15,
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Service Provider',
                              style: AppTextStyle.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Monetize your knowledge',
                              style: AppTextStyle.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(SignUp.route);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/multiplexorBG.png',
                    ),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        Image.asset(
                          'assets/images/m2.png',
                          width: Get.width*0.15,
                          height: Get.width*0.15,
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Client',
                              style: AppTextStyle.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Accelerate your career',
                              style: AppTextStyle.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(SupplierSignUp.route);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/multiplexorBG.png',
                    ),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        Image.asset(
                          'assets/images/m3.png',
                          width: Get.width*0.15,
                          height: Get.width*0.15,
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Supplier',
                              style: AppTextStyle.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Sell and supply goods to clients',
                              style: AppTextStyle.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
