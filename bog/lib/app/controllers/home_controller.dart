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
  List<Widget> pages = const [
    HomeTab(),
    ChatTab(),
    ProjectTab(),
    CartTab(),
    ProfileTab()
  ];
}