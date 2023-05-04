import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../controllers/home_controller.dart';
import '../../global_widgets/global_widgets.dart';
import '../../global_widgets/page_dropdown.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({Key? key}) : super(key: key);

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  var pageController = PageController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

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
          systemNavigationBarIconBrightness: Brightness.dark),
      child: GetBuilder<HomeController>(
          id: 'AddActivity',
          builder: (controller) {
            return Scaffold(
              backgroundColor: AppColors.backgroundVariant2,
              body: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05,
                          left: width * 0.045,
                          top: kToolbarHeight),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              "assets/images/back.svg",
                              height: width * 0.045,
                              width: width * 0.045,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Activity",
                                  style: AppTextStyle.subtitle1.copyWith(
                                      fontSize: multiplier * 0.07,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Container(
                      height: 1,
                      width: width,
                      color: AppColors.grey.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.043, right: width * 0.043),
                      child: const PageInput(
                          hint: "Enter a title for your report",
                          label: "Task Name"),
                    ),
                    SizedBox(
                      height: width * 0.06,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: PageDropButton(
                        label: "Task Status",
                        hint: '',
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        onChanged: (val) {},
                        items: ["Pending", "Ongoing", "Completed"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.06,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.043, right: width * 0.043),
                      child: const AppInput(
                        label: "Remark/Message",
                        hintText: 'Write your message',
                        maxLines: 6,
                      ),
                    ),
                    SizedBox(
                      height: width * 0.1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.043, right: width * 0.043),
                      child: const AppButton(title: "Send Update"),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: AppColors.backgroundVariant2,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.homeIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 0 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.homeTitle,
                      backgroundColor: AppColors.background,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.currentBottomNavPage.value == 1
                              ? 'assets/images/chat_filled.png'
                              : 'assets/images/chatIcon.png',
                          width: 22,
                          //color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.projectIcon,
                          width: 20,
                          //color: controller.currentBottomNavPage.value == 2 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.projectTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.cartIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 3 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: controller.cartTitle,
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          controller.profileIcon,
                          width: 25,
                          //color: controller.currentBottomNavPage.value == 4 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: controller.currentBottomNavPage.value,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    controller.currentBottomNavPage.value = index;
                    controller.updateNewUser(controller.currentType);
                    Get.back();
                    Get.back();
                  }),
            );
          }),
    );
  }
}

// class _TextButton extends StatelessWidget {
//   final String imageAsset;
//   final String text;
//   final String? subtitle;
//   final bool showArrow;
//   final Function() onPressed;
//   const _TextButton(
//       {required this.imageAsset,
//       required this.text,
//       required this.onPressed,
//       this.subtitle,
//       this.showArrow = true});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Padding(
//         padding:
//             EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               width: Get.width * 0.1,
//               height: Get.width * 0.1,
//               decoration: BoxDecoration(
//                 color: const Color(0xffE8F4FE),
//                 borderRadius: BorderRadius.circular(100),
//               ),
//               child: Center(
//                 child: Image.asset(
//                   imageAsset,
//                   width: Get.width * 0.05,
//                   height: Get.width * 0.05,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: Get.width * 0.7,
//               child: Padding(
//                 padding: EdgeInsets.only(left: Get.width * 0.01),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       SizedBox(
//                         height: Get.height * 0.01,
//                       ),
//                       Text(
//                         text,
//                         maxLines: 1,
//                         overflow: TextOverflow.clip,
//                         style: AppTextStyle.subtitle1.copyWith(
//                             color: text == "Log Out"
//                                 ? AppColors.bostonUniRed
//                                 : Colors.black,
//                             fontSize: Get.width * 0.04,
//                             fontWeight: FontWeight.w500),
//                       ),
//                       SizedBox(
//                         height: Get.height * 0.01,
//                       ),
//                       if (subtitle != null)
//                         Text(
//                           subtitle!,
//                           maxLines: 1,
//                           overflow: TextOverflow.clip,
//                           style: AppTextStyle.subtitle1
//                               .copyWith(color: Colors.black),
//                         ),
//                       if (subtitle != null)
//                         SizedBox(
//                           height: Get.height * 0.01,
//                         ),
//                     ]),
//               ),
//             ),
//             IconButton(
//               onPressed: onPressed,
//               padding: EdgeInsets.zero,
//               icon: showArrow
//                   ? Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.black,
//                       size: Get.width * 0.04,
//                     )
//                   : Container(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
