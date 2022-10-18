import 'package:carousel_slider/carousel_slider.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../multiplexor/multiplexor.dart';
import '../../../app/global_widgets/app_button.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_themes.dart';
import 'onboarding_item.dart';

CarouselController buttonCarouselController = CarouselController();

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);
  static const route = '/onboarding';

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.background,
            systemNavigationBarIconBrightness: Brightness.dark
        ),
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              if(currentIndex == 0)
                Image.asset(
                  'assets/images/bg1.png',
                  height: Get.height*1.1,
                  width: Get.width,
                ),
              if(currentIndex == 1)
                Image.asset(
                  'assets/images/bg2.png',
                  height: Get.height*1.1,
                  width: Get.width,
                ),
              if(currentIndex == 2)
                Image.asset(
                  'assets/images/bg3.png',
                  height: Get.height*1.1,
                  width: Get.width,
                ),
              SafeArea(
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Multiplexor.route);
                            },
                            child: Text(
                              'Skip',
                              style: AppTextStyle.bodyText1.copyWith(color: AppColors.primary,fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/images/boglogo.png',
                          height: Get.width * 0.13,
                          width: Get.height*0.13,
                        ),
                        Expanded(
                          child: CarouselSlider(
                            items: _screen.map((e) => OnboardingItem(
                              onboardingModel: e, pos: _screen.indexOf(e),
                            ))
                                .toList(),
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              height: double.infinity,
                              autoPlay: false,
                              viewportFraction: 1,
                              initialPage: 0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 31,
                        ),
                        SizedBox(
                          height: 10,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                index == currentIndex
                                    ? Container(
                                  decoration: BoxDecoration(
                                      color: index == currentIndex
                                          ? AppColors.primary
                                          : AppColors.fadedPrimary,
                                      //borderRadius: BorderRadius.circular(8),
                                      shape: BoxShape.circle
                                  ),
                                  height: 8,
                                  width: 8,
                                )
                                    : Container(
                                  decoration: BoxDecoration(
                                      color: index == currentIndex
                                          ? AppColors.primary
                                          : AppColors.fadedPrimary,
                                      shape: BoxShape.circle),
                                  height: 8,
                                  width: 8,
                                ),
                              ],
                            ),
                            separatorBuilder: (context, index) => const SizedBox(
                              width: 5,
                            ),
                            itemCount: 3,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AppButton(
                          title: currentIndex == 2 ? 'Continue' : 'Next',
                          onPressed: (){
                            buttonCarouselController.nextPage();
                            if (currentIndex == 2) {
                              Get.toNamed(Multiplexor.route);
                            }
                          },
                          borderRadius: 10,
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

class OnboardingModel {
  final String image;
  final String title;
  final String subtitle;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

List<OnboardingModel> _screen = [
  OnboardingModel(
    image: 'two',
    title: 'Monetize your knowledge',
    subtitle: 'B.O.G gives you a chance to earn by offering expert services by signing up as a service provider .',
  ),
  OnboardingModel(
    image: 'three',
    title: 'Accelerate your career',
    subtitle: 'With B.O.G you have a quick access to world-class professionals anywhere in the world offering the best services',
  ),
  OnboardingModel(
    image: 'one',
    title: 'Work with apprentices',
    subtitle: 'B.O.G gives you a chance to provide workplaces, sites, equipment in a safe condition',
  ),
];
