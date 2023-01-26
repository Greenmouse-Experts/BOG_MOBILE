import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bog/app/base/base.dart';

//TODO: Please make sure you add this to your get_it instance

class NavController {

  int currentTab = 0;

  final rootTabs = [
    // HomeTab.route,
    // ScanTab.route,
    // WalletTab.route,
    // ProfileTab.route,
  ];

  final navigatorKeys = {
    0:GlobalKey<NavigatorState>(),
    1:GlobalKey<NavigatorState>(),
    2:GlobalKey<NavigatorState>(),
    3:GlobalKey<NavigatorState>(),
  };

  final navigatorIcons = [
    "ic_home".png,
    "ic_scan".png,
    "ic_wallet".png,
    "ic_user_circle".png,
  ];

  final navigatorTitles = [
    "Home",
    "Scan",
    "Wallet",
    "Profile",
  ];

  GlobalKey<NavigatorState> get currentKey => navigatorKeys[currentTab]!;
  String get currentRoute => rootTabs[currentTab]!;

  static NavController get instance => Get.find();//getIt<NavController>();

  void pushNamed(String routeName){
    currentKey!.currentState!.pushNamed(routeName);
  }

  final StreamController<int> _streamController = StreamController.broadcast();

  Stream<int> get stream => _streamController.stream;

  void selectTab(int index)async {
    if (index == currentTab) {
      // pop to first route
      // navigatorKeys[index]!.currentState!.popUntil((route) => route.isFirst);
      // navigatorKeys[index]!.currentState!.pushNamed(rootTabs[index]);
      navigatorKeys[index]!.currentState!.pushNamedAndRemoveUntil(rootTabs[index], ModalRoute.withName("/"));
      } else {
      currentTab = index;
      _streamController.add(currentTab);
    }
  }
 }