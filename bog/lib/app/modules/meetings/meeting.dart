import 'package:bog/app/global_widgets/app_base_view.dart';
import 'package:bog/app/global_widgets/bottom_widget.dart';
import 'package:bog/app/global_widgets/global_widgets.dart';
import 'package:bog/app/global_widgets/new_app_bar.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';

import '../chat/chat.dart';

class Meetings extends GetView<HomeController> {
  const Meetings({Key? key}) : super(key: key);

  static const route = '/notification';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: 'Meetings',
        builder: (controller) {
          return
              // Scaffold(
              //  backgroundColor: AppColors.backgroundVariant2,
              // body:
              SizedBox(
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.03, right: Get.width * 0.03),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppInput(
                        hintText: 'Search with name or keyword ...',
                        filledColor: Colors.grey.withOpacity(.1),
                        prefexIcon: Icon(
                          FeatherIcons.search,
                          color: Colors.black.withOpacity(.5),
                          size: Get.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      SizedBox(
                        height: Get.height * 0.65,
                        child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: Get.height * 0.08,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.16,
                                    height: Get.width * 0.16,
                                    child: IconButton(
                                      icon: AppAvatar(
                                          imgUrl: "",
                                          radius: Get.width * 0.16,
                                          name: "Land"),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Land Project",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.04),
                                      ),
                                      Text(
                                        "Attended",
                                        style: AppTextStyle.subtitle1.copyWith(
                                            color: Colors.grey,
                                            fontSize: Get.width * 0.035),
                                      ),
                                      //Divider
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Container(
                                        height: 1,
                                        width: Get.width * 0.7,
                                        color: Colors.grey.withOpacity(.2),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Get.toNamed(Chat.route);
                      },
                      backgroundColor: AppColors.primary,
                      child: Stack(
                        children: [
                          SizedBox(
                              width: Get.width * 0.05,
                              height: Get.width * 0.05,
                              child:
                                  Image.asset("assets/images/Vector (3).png")),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
          //);
        });
  }
}

class NewMeetings extends StatelessWidget {
  const NewMeetings({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBaseView(
      child: GetBuilder<HomeController>(
          id: 'Meetings',
          builder: (controller) {
            return Scaffold(
              appBar: newAppBarBack(context, 'Meetings'),
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.03, right: Get.width * 0.03),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppInput(
                            hintText: 'Search with name or keyword ...',
                            filledColor: Colors.grey.withOpacity(.1),
                            prefexIcon: Icon(
                              FeatherIcons.search,
                              color: Colors.black.withOpacity(.5),
                              size: Get.width * 0.05,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          SizedBox(
                            height: Get.height * 0.65,
                            child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: Get.height * 0.08,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.16,
                                        height: Get.width * 0.16,
                                        child: IconButton(
                                          icon: AppAvatar(
                                              imgUrl: "",
                                              radius: Get.width * 0.16,
                                              name: "Land"),
                                          onPressed: () {},
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Land Project",
                                            style: AppTextStyle.subtitle1
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: Get.width * 0.04),
                                          ),
                                          Text(
                                            "Attended",
                                            style: AppTextStyle.subtitle1
                                                .copyWith(
                                                    color: Colors.grey,
                                                    fontSize:
                                                        Get.width * 0.035),
                                          ),
                                          //Divider
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Container(
                                            height: 1,
                                            width: Get.width * 0.7,
                                            color: Colors.grey.withOpacity(.2),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            Get.toNamed(Chat.route);
                          },
                          backgroundColor: AppColors.primary,
                          child: Stack(
                            children: [
                              SizedBox(
                                  width: Get.width * 0.05,
                                  height: Get.width * 0.05,
                                  child: Image.asset(
                                      "assets/images/Vector (3).png")),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: HomeBottomWidget(
                  isHome: false, controller: controller, doubleNavigate: false),
            );
          }),
    );
  }
}
