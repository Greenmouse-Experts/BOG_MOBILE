import 'package:bog/app/modules/home/pages/CartTab.dart';
import 'package:bog/app/modules/home/pages/ChatTab.dart';
import 'package:bog/app/modules/home/pages/ProfileTab.dart';
import 'package:bog/app/modules/home/pages/project_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/model/my_products.dart';
import '../modules/home/pages/home_tab.dart';
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

  updateNewUser(String userType, {bool updatePages = true}) {
    if (userType == "Client" || userType == "Corporate Client") {
      //Group 46942.png
      homeIcon = currentBottomNavPage.value == 0
          ? 'assets/images/homeIcon.png'
          : 'assets/images/Vector (7).png';
      chatIcon = currentBottomNavPage.value == 1
          ? 'assets/images/Vector (5).png'
          : 'assets/images/chatIcon.png';
      projectIcon = currentBottomNavPage.value == 2
          ? 'assets/images/Group 46942.png'
          : 'assets/images/projectIcon.png';
      cartIcon = currentBottomNavPage.value == 3
          ? 'assets/images/Vector (6).png'
          : 'assets/images/cartIcon.png';
      profileIcon = currentBottomNavPage.value == 4
          ? 'assets/images/Group (3).png'
          : 'assets/images/profileIcon.png';

      homeTitle = 'Home';
      cartTitle = 'Cart';
      projectTitle = 'Project';
    } else if (userType == "Product Partner") {
      homeIcon = currentBottomNavPage.value == 0
          ? 'assets/images/Vector (4).png'
          : 'assets/images/dashboardIcon.png';
      chatIcon = currentBottomNavPage.value == 1
          ? 'assets/images/Vector (5).png'
          : 'assets/images/chatIcon.png';
      projectIcon = currentBottomNavPage.value == 2
          ? 'assets/images/Group 47400.png'
          : 'assets/images/ordersIcon.png';
      cartIcon = currentBottomNavPage.value == 3
          ? 'assets/images/Group (2).png'
          : 'assets/images/prodctIcon.png';
      profileIcon = currentBottomNavPage.value == 4
          ? 'assets/images/Group (3).png'
          : 'assets/images/profileIcon.png';

      homeTitle = 'Dashboard';
      cartTitle = 'Products';
      projectTitle = 'Orders';
    } else {
      homeIcon = currentBottomNavPage.value == 0
          ? 'assets/images/homeIcon.png'
          : 'assets/images/Vector (7).png';
      chatIcon = currentBottomNavPage.value == 1
          ? 'assets/images/Vector (5).png'
          : 'assets/images/chatIcon.png';
      projectIcon = currentBottomNavPage.value == 2
          ? 'assets/images/Group 46942.png'
          : 'assets/images/projectIcon.png';
      cartIcon = currentBottomNavPage.value == 3
          ? 'assets/images/Group (4).png'
          : 'assets/images/Vector (8).png';
      profileIcon = currentBottomNavPage.value == 4
          ? 'assets/images/Group (3).png'
          : 'assets/images/profileIcon.png';

      homeTitle = 'Home';
      cartTitle = 'Orders';
      projectTitle = 'Project';
    }
    if (updatePages) {
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

  int totalPrice = 0;
  bool isBuyNow = false;
  MyProducts? myProducts;
  int get cartLength => productsList.length;
  List<MyProducts> productsList = [];
  Map<String, int> productsMap = {};


  void addProductToCart (MyProducts product){
      productsList.add(product);
      update();
  }
}
