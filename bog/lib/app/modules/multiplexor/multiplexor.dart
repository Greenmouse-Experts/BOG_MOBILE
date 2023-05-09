import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import '../sign_up/service_provider.dart';
import '../sign_up/sign_up.dart';
import '../sign_up/supplier.dart';

class Multiplexor extends StatelessWidget {
  const Multiplexor({Key? key}) : super(key: key);

  static const route = '/multiplexor';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Container(
          color: AppColors.backgroundVariant1,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Center(
                  child: Stack(
                    children: [
                      Image.asset('assets/images/multiplexor_bg.png',
                          width: Get.width * 0.4, height: Get.height * 0.2),
                      Image.asset(
                        'assets/images/boglogo.png',
                        width: Get.width * 0.4,
                        height: Get.height * 0.2,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.015,
                        ),
                        Text(
                          'Sign Up as :',
                          style: AppTextStyle.headline4.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: Get.textScaleFactor * 24),
                        ),
                        SizedBox(
                          height: Get.height * 0.018,
                        ),
                        Text(
                          'Select the type of account you would like \nto create',
                          style: AppTextStyle.headline4.copyWith(
                            color: AppColors.primaryVariant,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(SignUp.route);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/client_bg.png',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Get.width < 300
                                        ? Get.width * 0.03
                                        : Get.width * 0.05,
                                  ),
                                  Image.asset(
                                    'assets/images/m2.png',
                                    width: Get.width < 300
                                        ? Get.width * 0.08
                                        : Get.width * 0.15,
                                    height: Get.width < 300
                                        ? Get.width * 0.08
                                        : Get.width * 0.15,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Client',
                                        style: AppTextStyle.headline4.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: Get.width < 300
                                              ? Get.textScaleFactor * 16
                                              : Get.textScaleFactor * 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Access services and products',
                                        style: AppTextStyle.headline4.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: Get.width < 300
                                              ? Get.textScaleFactor * 11
                                              : Get.textScaleFactor * 14,
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
                            Get.toNamed(ServiceProviderSignUp.route);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/service_provider.png',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Get.width < 300
                                        ? Get.width * 0.03
                                        : Get.width * 0.05,
                                  ),
                                  Image.asset(
                                    'assets/images/m1.png',
                                    width: Get.width < 300
                                        ? Get.width * 0.08
                                        : Get.width * 0.15,
                                    height: Get.width < 300
                                        ? Get.width * 0.08
                                        : Get.width * 0.15,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Service Partner',
                                        style: AppTextStyle.headline4.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: Get.width < 300
                                              ? Get.textScaleFactor * 16
                                              : Get.textScaleFactor * 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Render services to users in need ',
                                        style: AppTextStyle.headline4.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: Get.width < 300
                                              ? Get.textScaleFactor * 11
                                              : Get.textScaleFactor * 14,
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
                                'assets/images/rect3.png',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: Get.width < 300
                                        ? Get.width * 0.03
                                        : Get.width * 0.05,
                                  ),
                                  Image.asset(
                                    'assets/images/m3.png',
                                    width: Get.width < 300
                                        ? Get.width * 0.08
                                        : Get.width * 0.15,
                                    height: Get.width < 300
                                        ? Get.width * 0.08
                                        : Get.width * 0.15,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product Partner',
                                        style: AppTextStyle.headline4.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: Get.width < 300
                                              ? Get.textScaleFactor * 16
                                              : Get.textScaleFactor * 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Sell your products online ',
                                        style: AppTextStyle.headline4.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: Get.width < 300
                                              ? Get.textScaleFactor * 11
                                              : Get.textScaleFactor * 14,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
