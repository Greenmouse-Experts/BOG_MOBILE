import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../data/providers/api_response.dart';
import '../../../data/providers/my_pref.dart';
import '../../../global_widgets/app_avatar.dart';
import '../../../global_widgets/app_input.dart';
import '../../../global_widgets/horizontal_item_tile.dart';
import '../../chat/chat.dart';
import '../../create/create.dart';
import '../../shop/product_details.dart';

class ProjectTab extends StatelessWidget {
  const ProjectTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.only(left: Get.width*0.03, right: Get.width*0.03),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              height: Get.height * 0.91,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: kToolbarHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "My Projects",
                          style: AppTextStyle.subtitle1.copyWith(
                            color: Colors.black,
                            fontSize: Get.width * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
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
                    child: GridView.builder(
                      itemCount: 4,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: 15),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            //Get.to(const ProductDetails(key: Key('ProductDetails')));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/Group 47257.png"),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            //floating action button
            FloatingActionButton(
              onPressed: (){
                Get.toNamed(Create.route);
              },
              backgroundColor: AppColors.primary,
              child: Stack(
                children: [
                  SizedBox(
                      width: Get.width * 0.05,
                      height: Get.width * 0.05,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: Get.width * 0.05,
                      ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}