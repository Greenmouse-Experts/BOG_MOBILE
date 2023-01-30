import 'dart:async';

import 'package:bog/app/base/base.dart';
import 'package:bog/app/modules/sign_in/sign_in.dart';
import 'package:bog/core/utils/extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
  PageController pageController = PageController(initialPage: 999);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Future.delayed(Duration(seconds: 1),(){startTimer();});
    });
  }

  Timer? timer;
  void startTimer(){
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

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
              Center(
                child: Image.asset(
                  "launch_back".png,
                  fit: BoxFit.cover,
                ),
              ),
              Builder(
                builder: (context) {
                  var onboardingModel = _screen[0];
                  return Center(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: currentIndex==0?1:0,
                      child: Image.asset(
                        "launch1a".png,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              ),
              Builder(
                builder: (context) {
                  var onboardingModel = _screen[1];
                  return Center(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: currentIndex==1?1:0,
                      child: Image.asset(
                        "launch1b".png,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              ),
              Builder(
                builder: (context) {
                  var onboardingModel = _screen[2];
                  return Center(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: currentIndex==2?1:0,
                      child: Image.asset(
                        "launch1c".png,
                        fit: BoxFit.cover,
                      ),
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
                        addSpace(20),
                        SmoothPageIndicator(
                            controller: pageController,
                            key: ValueKey("pc$currentIndex"),
                            count:  _screen.length,
                            effect:  WormEffect(dotWidth: 80,
                                dotHeight: 3,radius: 5,
                                activeDotColor: AppColors.primary,
                                dotColor: AppColors.primary.withOpacity(.5)),  // your preferred effect
                            onDotClicked: (index){

                            }
                        ),
                        addSpace(50),
                        Expanded(
                          child: PageView.builder(
                            itemBuilder: (c,p){

                              OnboardingModel model = _screen[currentIndex];
                              return Column(
                                children: [
                                  Text(model.title,style: textStyle(true, 20, blackColor),
                                  textAlign: TextAlign.center,),
                                  Expanded(child: Container(color: Colors.transparent,)),
                                  Text(model.subtitle,style: textStyle(false, 16, blackColor),
                                  textAlign: TextAlign.center,),


                                ],
                              );
                            },
                            controller: pageController,
                            onPageChanged: (p){
                              setState((){
                                currentIndex=p%(_screen.length);
                              });
                            },
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
                          fontColor: AppColors.primary,
                          bckgrndColor: Colors.transparent,
                        ),
                        // SizedBox(
                        //   height: Get.height * 0.05,
                        // ),
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
    title: 'Monitor and manage your projects from anywhere',
    subtitle: 'Achieve your dream project to your taste without the barrier or distance',
  ),
  OnboardingModel(
    image: 'two',
    title: 'Find service partners suitable for your jobs',
    subtitle: 'Hire professional workers with top skills and experience for your projects.',
  ),
  OnboardingModel(
    image: 'three',
    title: 'Access quality construction materials for projects',
    subtitle: 'We offer top-quality construction materials to suit your project need',
  ),
];
