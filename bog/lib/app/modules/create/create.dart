import 'dart:convert';

import 'package:bog/app/global_widgets/app_button.dart';
import 'package:bog/app/modules/create/inner_pages/building_approval.dart';
import 'package:bog/app/modules/create/inner_pages/construction_drawing.dart';
import 'package:bog/app/modules/create/inner_pages/contractor_or_smart_calculator.dart';
import 'package:bog/app/modules/create/inner_pages/geotechnical_investigation.dart';
import 'package:bog/app/modules/create/inner_pages/land_survey.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_input.dart';
import '../../global_widgets/tabs.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  static const route = '/create';

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  var chosen = -1;
  var titleController = TextEditingController();
  var searchController = TextEditingController();

  Map<String,String> assetImage = {
    "Land Surveyor" : "assets/images/oneS.png",
    "Construction Drawing" : "assets/images/twoS.png",
    "Geotechnical \nInvestigation" : "assets/images/threeS.png",
    "Smart Calculator" : "assets/images/fourS.png",
    "Building Approval" : "assets/images/fiveS.png",
    "Contractor" : "assets/images/Group 47136.png"
  };

  List<String> titles = [
    "Land Surveyor",
    "Construction Drawing",
    "Geotechnical \nInvestigation",
    "Smart Calculator",
    "Building Approval",
    "Contractor"
  ];

  List<String> titlesToUse = [
    "Land Surveyor",
    "Construction Drawing",
    "Geotechnical \nInvestigation",
    "Smart Calculator",
    "Building Approval",
    "Contractor"
  ];

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    final Size size = MediaQuery.of(context).size;
    double multiplier = 25 * size.height * 0.01;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: GetBuilder<HomeController>(
          id: 'Create',
          builder: (controller) {

            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: width*0.05,left: width*0.045,top: kToolbarHeight),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                "assets/images/back.svg",
                                height: width*0.045,
                                width: width*0.045,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: width*0.04,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Create",
                                    style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.07,color: Colors.black,fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width*0.04,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),
                      Container(
                        height: 1,
                        width: width,
                        color: AppColors.grey.withOpacity(0.1),
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        child: Text(
                          "Search ",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.08,color: Colors.black,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: width*0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        child: AppInput(
                            hintText: "Search for your desired service",
                            controller: searchController,
                          onChanged: (val){
                            if(val.isNotEmpty){
                              titlesToUse.clear();
                              for (var element in titles) {
                                if(element.toLowerCase().contains(val.toLowerCase().trim()) || element.toLowerCase() == val.toLowerCase().trim()){
                                  titlesToUse.add(element);
                                }
                              }
                            }else{
                              titlesToUse.clear();
                              titlesToUse.addAll(titles);
                            }
                            chosen = -1;
                            controller.update(['Create']);
                          },
                        ),
                      ),
                      SizedBox(
                        height: width*0.1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
                        child: Text(
                          "What service do you need ? ",
                          style: AppTextStyle.subtitle1.copyWith(fontSize: multiplier * 0.08,color: Colors.black,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: width*0.05,
                      ),

                      SizedBox(
                        height: Get.height * 0.62,
                        child: GridView.builder(
                          itemCount: titlesToUse.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 0),
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5,bottom: 5),
                              child: ServiceWidget(
                                width: width,
                                function: (){
                                  chosen = index+1;
                                  controller.update(['Create']);
                                  titleController.text = titlesToUse[index];

                                  if(titlesToUse[index] == "Land Surveyor"){
                                    Get.to(() => const LandSurvey(),arguments: titleController.text);
                                  }else if(titlesToUse[index] == "Construction Drawing"){
                                    Get.to(() => const ConstructionDrawing(),arguments: titleController.text);
                                  }else if(titlesToUse[index] == "Geotechnical \nInvestigation"){
                                    Get.to(() => const GeotechnicalInvestigation(),arguments: titleController.text);
                                  }else if(titlesToUse[index] == "Smart Calculator"){
                                    Get.to(() => const ContractorOrSmartCalculator(),arguments: titleController.text);
                                  }else if(titlesToUse[index] == "Building Approval"){
                                    Get.to(() => const BuildingApproval(),arguments: titleController.text);
                                  }else if(titlesToUse[index] == "Contractor"){
                                    Get.to(() => const ContractorOrSmartCalculator(),arguments: titleController.text);
                                  }
                                },
                                asset: assetImage[titlesToUse[index]]!,
                                title: titlesToUse[index],
                                multiplier: multiplier,
                                hasBorder: chosen == index+1,
                                selectedText: searchController.text,
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(
                        height: width*0.07,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: AppColors.backgroundVariant2,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/homeIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Home',
                      backgroundColor: AppColors.background,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        controller.currentBottomNavPage.value == 1 ? 'assets/images/chat_filled.png' : 'assets/images/chatIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/projectIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Project',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/cartIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/profileIcon.png',
                        width: 25,
                        color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: controller.currentBottomNavPage.value,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    controller.currentBottomNavPage.value = index;
                    controller.update(['home']);
                    Get.back();
                  }
              ),
            );
          }),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    Key? key,
    required this.width,
    required this.function,
    required this.asset,
    required this.title,
    required this.multiplier,
    this.hasBorder = false,
    this.selectedText = ""
  }) : super(key: key);

  final double width;
  final Function() function;
  final String asset;
  final String title;
  final String selectedText;
  final double multiplier;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: width*0.05,right: width*0.05),
      child: InkWell(
        onTap: function,
        child: Container(
          height: width*0.4,
          width: width*0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: hasBorder ? const Border.fromBorderSide(BorderSide(color: Color(0xffEC8B20))) : null,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: width*0.15,
                width: width*0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(asset),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: width*0.04,
              ),
              Text.rich(
                  TextSpan(
                      text: '',
                      children: highlightOccurrences(title, selectedText)
                  ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [ TextSpan(text: source) ];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xffEC8B20)),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

}
