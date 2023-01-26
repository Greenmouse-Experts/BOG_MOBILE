import 'package:bog/app/modules/sign_in/sign_in.dart';
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
          body: Stack(fit: StackFit.expand,
            children: [
              Builder(
                builder: (context) {
                  var onboardingModel = _screen[0];
                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: currentIndex==0?1:0,
                    child: Image.asset(
                      'assets/images/${onboardingModel.image}.png',
                      fit: BoxFit.cover,
                    ),
                  );
                }
              ),
              Builder(
                builder: (context) {
                  var onboardingModel = _screen[1];
                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: currentIndex==1?1:0,
                    child: Image.asset(
                      'assets/images/${onboardingModel.image}.png',
                      fit: BoxFit.cover,
                    ),
                  );
                }
              ),
              Builder(
                builder: (context) {
                  var onboardingModel = _screen[2];
                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: currentIndex==2?1:0,
                    child: Image.asset(
                      'assets/images/${onboardingModel.image}.png',
                      fit: BoxFit.cover,
                    ),
                  );
                }
              ),
              SafeArea(
                child: Container(
                  // color: AppColors.background,
                  child: Padding(
                    padding: const EdgeInsets.all(AppThemes.appPaddingVal),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: null,
                            child: Text(
                              'Skip',
                              style: AppTextStyle.bodyText1.copyWith(color: AppColors.background,fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/images/logo.png',
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
                              autoPlay: true,
                              enableInfiniteScroll: false,
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
                                          : AppColors.primary.withOpacity(.5),
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
                          title: 'Sign Up',
                          onPressed: (){
                            Get.toNamed(Multiplexor.route);
                          },
                          borderRadius: 10,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        AppButton(
                          title: 'Login',
                          onPressed: (){
                            Get.toNamed(SignIn.route);
                          },
                          borderRadius: 10,
                          fontColor: Colors.white,
                          bckgrndColor: Colors.transparent,
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
    image: 'one',
    title: 'Monitor and manage your projects',
    subtitle: 'Enjoy full control over your project',
  ),
  OnboardingModel(
    image: 'two',
    title: 'Find construction professionals for your jobs',
    subtitle: 'Hire professional Service Partners',
  ),
  OnboardingModel(
    image: 'three',
    title: 'Get quality construction materials for projects',
    subtitle: 'Access materials easily for your project',
  ),
];
