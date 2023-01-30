import 'dart:convert';

import 'package:bog/app/base/base.dart';
import 'package:bog/app/modules/home/subscribe.dart';
import 'package:bog/app/modules/notifications/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../blocs/homeswitch_controller.dart';
import '../../controllers/home_controller.dart';
import '../../data/model/log_in_model.dart';
import '../../data/providers/my_pref.dart';
import '../../global_widgets/app_avatar.dart';
import '../../global_widgets/app_drawer.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var homeController = Get.find<HomeController>();

  var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var subs = [];
  @override
  void initState() {
    super.initState();
    var logInDetails = LogInModel.fromJson(jsonDecode(MyPref.logInDetail.val));
    var type = logInDetails.userType.toString().replaceAll("_", " ").capitalizeFirst.toString();
    if(type == "Client") {
      homeController.currentType = "Client";
    } else if(type == "Vendor") {
      homeController.currentType = "Product Partner";
    }else{
      homeController.currentType = "Service Partner";
    }
    homeController.updateNewUser(logInDetails.userType.toString().replaceAll("_", " ").capitalizeFirst.toString(),updatePages: false);
    subs.add(HomeSwitchController.instance.stream.listen((event) {
      showSwitch();
    }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for(var sub in subs)sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.backgroundVariant2,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.backgroundVariant2,
          systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: GetBuilder<HomeController>(
          id: 'home',
          builder: (controller) {
            return Scaffold(
              key: scaffoldKey,
              body: Column(
                children: [
                  /*if(controller.currentBottomNavPage.value!=4)Padding(
                    padding: const EdgeInsets.only(right: 10.0,top: 15.0,left: 10,bottom: 10),
                    child: Row(
                      children: [
                        // Container(
                        //     width: 30,height: 40,
                        //     child: TextButton(onPressed: (){
                        //       scaffoldKey.currentState!.openDrawer();
                        //     },
                        //         style: TextButton.styleFrom(
                        //             padding: EdgeInsets.zero
                        //         ),
                        //         child: Icon(Icons.menu,color: blackColor.withOpacity(.5),))),
                        addSpaceWidth(5),
                        Builder(
                        builder: (context1) {
                          return SizedBox(
                            width: Get.width * 0.13,
                            height: Get.width * 0.13,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: AppAvatar(
                                imgUrl: (logInDetails.photo).toString(),
                                radius: Get.width * 0.16,
                                name: "${logInDetails.fname} ${logInDetails.lname}",
                              ),
                              onPressed: () {
                                scaffoldKey.currentState!.openDrawer();
                                // Scaffold.of(context).openDrawer();
                              },
                            ),
                          );
                        }
                    ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   "Hello,",
                                  //   style: AppTextStyle.subtitle1.copyWith(
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 5.0,
                                  // ),
                                  Text(
                                    "${logInDetails.fname} ${logInDetails.lname}",
                                    style: AppTextStyle.subtitle1.copyWith(
                                      color: Colors.black,
                                      fontSize: Get.width * 0.05,
                                    ),
                                  ),
                                  addSpace(5),
                                  Container(
                                    height: 20,
                                    child: TextButton(onPressed: (){
                                      showSwitch();
                                    },
                                        style: TextButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)
                                          ),
                                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0)
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(controller.currentType,style: textStyle(false, 12, white),),
                                            addSpaceWidth(5),
                                            const Icon(Icons.expand_circle_down,color: white,size: 12,)
                                          ],
                                        )),
                                  )
                                ],
                              ),
                              //Alarm Icon
                              IconButton(
                                icon: const Icon(Icons.notifications,color: Colors.grey),
                                onPressed: () {
                                  Get.to(() => const NotificationPage());
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  addLine(.5, blackColor.withOpacity(.1), 0, 0, 0, 0),
                 */ Expanded(
                    child: SizedBox(
                      width: Get.width,
                      child:
              //             (controller.currentBottomNavPage.value==3
              // && controller.currentType == "Service Partner")?
              //     Subscribe()
              //     :
                      controller.pages[controller.currentBottomNavPage.value],
                    ),
                  ),
                ],
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
                          controller.currentBottomNavPage.value == 1 ? 'assets/images/chat_filled.png' : 'assets/images/chatIcon.png',
                          width: 22,
                          //color: controller.currentBottomNavPage.value == 1 ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                      label: 'Message',
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
                    controller.update(['home']);
                  }
              ),
              drawer: const AppDrawer(),
            );
          }),
    );
  }


  showSwitch(){
    int selectedPosition =
    homeController.currentType=="Client"?0:
    homeController.currentType=="Corporate Client"?1:
    homeController.currentType=="Service Partner"?2:3
    ;
    List mainTitles = [
      "Client",
      "Corporate Client",
      "Service Partner",
      "Product Partner"
    ];
    List titles = [
      "Private Client",
      "Corporate Client",
      "Service Partner",
      "Product Partner"
    ];
    List subtitles = [
      'Access services and products',
      'Access services and products',
      'Render services to users in need ',
      'Sell your products online ',
    ];
    List icons = [
      'assets/images/m2.png',
      'assets/images/m2.png',
      'assets/images/m1.png',
      'assets/images/m3.png',
    ];
    List types = [
      "private_client",
      "corporate_client",
      "professional",
      "vendor"
    ];


    List loadedTypes = HomeSwitchController.instance.accountTypes;
    List myTypes = List.generate(loadedTypes.length, (index) {
      Map item = loadedTypes[index];
      return item["userType"]??"";
    });

    showModalBottomSheet(
        backgroundColor: transparent,
        context: context, builder: (c){


      return StatefulBuilder(builder: (c,setState){


        return  Container(
          decoration: const BoxDecoration(
              color:white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // addSpace(10),
              Icon(Icons.drag_handle,size: 30,color: black.withOpacity(.2),),
                Padding(padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                  child:
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (icon != null)
                      //   Container(margin: EdgeInsets.only(right: 10),
                      //     padding: EdgeInsets.all(5),
                      //     decoration: BoxDecoration(
                      //         color: blue0,shape: BoxShape.circle
                      //     ),
                      //     child: imageItem(icon, 25,white,),
                      //   ),
                      Flexible(
                        fit:FlexFit.tight,
                        child:Text("Switch Account",style: textStyle(true,20,blackColor),),
                      ),
                      Container(
                          height:30,
                          // width: 40,
                          child:TextButton(
                              onPressed:
                                  (){
                                Navigator.pop(context,selectedPosition);
                              },
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                                  primary: transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                              child:Text("Done",style: textStyle(true, 16, AppColors.primary))
                            //Icon(Icons.check,color: white,),
                          )
                      )
                    ],
                  ),),
              addLine(.5, blackColor.withOpacity(.1), 20, 0, 20, 10),
              Column(
                children: List.generate(titles.length, (index){
                  String title = titles[index];
                  String subtitle = subtitles[index];
                  String icon = icons[index];
                  if(!myTypes.contains(types[index]))return Container();
                  return optionItem(title,subtitle,icon, selectedPosition==index,
                          (){
                        setState((){
                          selectedPosition=index;
                        });
                      });
                }),
              ),
              addSpace(10)
            ],
          ),
        );
      });
    },barrierColor:black.withOpacity(.5),isScrollControlled: true)
        .then((index) async{
          if(index==null)return;
          homeController.currentType = mainTitles[index];
          homeController.update();
          homeController.updateNewUser(mainTitles[index]);
          var body = {
            "userType": types[index],
          };
          var response = await homeController.userRepo.postData("/user/switch-account", body);

    });

  }

  Widget optionItem(String title,String subtitle,String icon,
      bool selected,onTap){

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: transparent,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20,10,20,10),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              // padding: EdgeInsets.all(3),
              // decoration: BoxDecoration(
              //     color: whiteColor3,shape: BoxShape.circle
              // ),
              child: Image.asset(icon, height:50,),
            ),
            Flexible(
                fit: FlexFit.tight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: textStyle(false, 17, blackColor),),
                    addSpace(5),
                    Text(subtitle,style: textStyle(false, 12, blackColor.withOpacity(.5)),)
                  ],
                )),
            addSpaceWidth(10),
            checkBox(selected)
          ],
        ),
      ),
    );
  }
}
