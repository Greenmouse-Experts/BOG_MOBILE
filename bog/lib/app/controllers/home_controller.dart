import 'package:bog/app/modules/home/pages/CartTab.dart';
import 'package:bog/app/modules/home/pages/ChatTab.dart';
import 'package:bog/app/modules/home/pages/ProfileTab.dart';
import 'package:bog/app/modules/home/pages/ProjectTab.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../modules/home/pages/HomeTab.dart';
import '../repository/user_repo.dart';

class HomeController extends GetxController {
  final UserRepository userRepo;
  HomeController(this.userRepo);

  RxInt currentBottomNavPage = 0.obs;
  String currentType = "Client";

  String homeIcon = 'assets/images/homeIcon.png';
  String chatIcon = 'assets/images/homeIcon.png';
  String projectIcon = 'assets/images/projectIcon.png';
  String cartIcon = 'assets/images/cartIcon.png';
  String profileIcon = 'assets/images/profileIcon.png';

  String homeTitle = 'Home';
  String cartTitle = 'Cart';
  String projectTitle = 'Project';

  updateNewUser(String userType,{bool updatePages = true}) {
    if(userType == "Client"){
      homeIcon = 'assets/images/homeIcon.png';
      chatIcon = 'assets/images/chatIcon.png';
      projectIcon = 'assets/images/projectIcon.png';
      cartIcon = 'assets/images/cartIcon.png';
      profileIcon = 'assets/images/profileIcon.png';

      homeTitle = 'Home';
      cartTitle = 'Cart';
      projectTitle = 'Project';
    }else{
      homeIcon = 'assets/images/dashboardIcon.png';
      chatIcon = 'assets/images/chatIcon.png';
      projectIcon = currentBottomNavPage.value == 2 ? 'assets/images/Group 47400.png': 'assets/images/ordersIcon.png';
      cartIcon = 'assets/images/prodctIcon.png';
      profileIcon = 'assets/images/profileIcon.png';

      homeTitle = 'Dashboard';
      cartTitle = 'Products';
      projectTitle = 'Orders';
    }
    if(updatePages){
      update();
      update(['home']);
    }
  }
  List<Widget> pages = const [
    HomeTab(),
    ChatTab(),
    ProjectTab(),
    CartTab(),
    ProfileTab()
  ];
}